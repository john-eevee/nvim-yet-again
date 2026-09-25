-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- :ExtractToFile — cut the visual selection and append it to a file
--
--   Usage:
--     1. Select some text (visual mode: v / V / <C-v>)
--     2. Run :ExtractToFile
--     3. Type a destination path (resolved relative to the current buffer)
--
--   Behaviour:
--     • The destination is resolved relative to the *directory of the
--       focused buffer* (absolute / ~ / $VAR paths are used as-is).
--     • The file is created if it does not exist (parent dirs included).
--     • The selected text is CUT from the source buffer.
--     • The text is appended to the BOTTOM of the destination file,
--       preserving it exactly (including trailing newlines).
--     • If the destination is already open in a buffer, that buffer is
--       reloaded afterwards (and appending is refused if it has unsaved
--       edits, so nothing is clobbered).
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local M = {}

-- Cut the current/last visual selection into a register and return the
-- removed text (with correct newlines). Relies on `gv` so vim handles
-- every selection shape (charwise, linewise, blockwise) exactly right.
local function cut_selection()
  -- If we are somehow still inside visual mode, leave it first.
  local mode = vim.fn.mode()
  if mode:find("^[vV]") or mode:byte(1) == 22 or mode:find("^%^") then
    vim.cmd("normal! \27")
  end

  if vim.fn.getpos("'<")[2] == 0 then
    error("no visual selection — select some text first")
  end

  -- Preserve the `z` register (it may hold a macro).
  local oldz = vim.fn.getreg("z")
  local oldzt = vim.fn.getregtype("z")

  vim.cmd("normal! gv\"zd")
  local text = vim.fn.getreg("z")
  local ty = vim.fn.getregtype("z")

  -- Restore `z`, but mirror the cut text into the unnamed register so a
  -- subsequent `p` pastes it, like a regular cut would.
  vim.fn.setreg("z", oldz, oldzt)
  vim.fn.setreg('"', text, ty)

  return text
end

-- Resolve the destination path relative to the focused buffer.
local function resolve_destination(raw)
  local cur = vim.api.nvim_get_current_buf()
  local curpath = vim.api.nvim_buf_get_name(cur)
  local dir = (curpath ~= "" and vim.fn.fnamemodify(curpath, ":h")) or vim.fn.getcwd()

  local expanded = vim.fn.expand(raw) -- expand ~ and $VAR
  local is_abs = expanded:sub(1, 1) == "/"
    or expanded:sub(1, 1) == "~"
    or expanded:match("^[A-Za-z]:[\\/]") ~= nil

  local joined = is_abs and expanded or (dir .. "/" .. expanded)
  return vim.fn.fnamemodify(joined, ":p")
end

-- Append `text` to the bottom of `target` (creating it if needed),
-- preserving the existing content and separating cleanly.
local function append_to_file(target, text)
  -- Create parent directories if missing.
  local parent = vim.fn.fnamemodify(target, ":h")
  if parent ~= "" and vim.fn.isdirectory(parent) == 0 then
    vim.fn.mkdir(parent, "p")
  end

  -- If the file is open in a buffer, refuse to clobber unsaved edits.
  local bn = vim.fn.bufnr(target)
  if bn ~= -1 and vim.bo[bn].modified then
    error(("destination '%s' has unsaved changes — save or close it first"):format(target))
  end

  -- Read current raw content (exact, no line-model surprises).
  local fh = io.open(target, "rb")
  local content = ""
  if fh then
    content = fh:read("*a")
    fh:close()
  end

  -- Separate the existing text from the appended chunk only when the file
  -- does not already end with a newline.
  local sep = (content ~= "" and content:sub(-1) ~= "\n") and "\n" or ""
  local out = io.open(target, "wb")
  if not out then
    error(("cannot open for writing: %s"):format(target))
  end
  out:write(content .. sep .. text)
  out:close()

  -- Reload the buffer if it was already open (and unmodified).
  if bn ~= -1 then
    pcall(vim.api.nvim_buf_call, bn, function()
      vim.cmd("edit!")
    end)
  end
end

function M.extract_to_file()
  -- Ask for the destination first, so cancelling never cuts anything.
  local cur = vim.api.nvim_get_current_buf()
  local curpath = vim.api.nvim_buf_get_name(cur)
  local dir = (curpath ~= "" and vim.fn.fnamemodify(curpath, ":h")) or vim.fn.getcwd()

  local raw = vim.fn.input({
    prompt = "Extract to (" .. dir .. "/): ",
    completion = "file",
  })
  if raw == "" then
    return
  end

  local target = resolve_destination(raw)

  -- Refuse to extract a file into itself.
  if curpath ~= "" and vim.fn.fnamemodify(target, ":p") == vim.fn.fnamemodify(curpath, ":p") then
    return vim.notify("ExtractToFile: destination is the current file", "error", { title = "ExtractToFile" })
  end

  -- Cut the selection.
  local ok, text = pcall(cut_selection)
  if not ok then
    return vim.notify("ExtractToFile: " .. tostring(text), "error", { title = "ExtractToFile" })
  end
  if text == "" then
    return vim.notify("ExtractToFile: selection is empty", "warn", { title = "ExtractToFile" })
  end

  -- Append to the destination.
  local ok2, err = pcall(append_to_file, target, text)
  if not ok2 then
    -- The cut already happened, so warn rather than pretend nothing did.
    return vim.notify(
      ("ExtractToFile: selection was cut, but append failed: %s"):format(tostring(err)),
      "error",
      { title = "ExtractToFile" }
    )
  end

  vim.notify("Extracted to " .. target, "info", { title = "ExtractToFile" })
end

vim.api.nvim_create_user_command("ExtractToFile", M.extract_to_file, {
  force = true,
  range = true, -- allow :'<,'>ExtractToFile from visual mode
  desc = "Cut the visual selection and append it to a file (path relative to the current buffer)",
})

return M
