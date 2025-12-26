-- ╔══════════════════════════════════════════════════════════════╗
-- ║            JAVA DEVELOPMENT SETUP                             ║
-- ║    Formatting, linting, and test integration for Java         ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JAVA FORMATTING - SPOTLESS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local conform = require("conform")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JAVA LINTING - CHECKSTYLE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local lint = require("lint")

lint.linters.checkstyle = {
  cmd = "checkstyle",
  stdin = false,
  append_fname = true,
  args = {
    "-c", "/google_checks.xml",
  },
  parser = function(output)
    local diagnostics = {}
    for match in output:gmatch("[^\n]+") do
      local file, line, col, msg = match:match("([^:]+):(%d+):(%d+): (.+)")
      if file then
        table.insert(diagnostics, {
          lnum = tonumber(line) - 1,
          col = tonumber(col),
          message = msg,
          severity = vim.diagnostic.severity.WARN,
        })
      end
    end
    return diagnostics
  end,
}

lint.linters_by_ft = {
  java = { "checkstyle" },
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JAVA-SPECIFIC KEYMAPS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local function run_spotless()
  local cwd = vim.fn.getcwd()
  local cmd = ""

  -- Detect Maven project
  if vim.fn.filereadable(cwd .. "/pom.xml") == 1 then
    cmd = "bash -c 'cd " .. cwd .. " && ./mvnw spotless:apply'"
  -- Detect Gradle project
  elseif vim.fn.filereadable(cwd .. "/build.gradle") == 1 or
         vim.fn.filereadable(cwd .. "/build.gradle.kts") == 1 then
    cmd = "bash -c 'cd " .. cwd .. " && ./gradlew spotless'"
  else
    vim.notify("No pom.xml or build.gradle found. Install Spotless.", vim.log.levels.WARN)
    return
  end

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n"), vim.log.levels.WARN)
      end
    end,
    on_exit = function()
      vim.notify("Spotless formatting complete!", vim.log.levels.INFO)
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = true }

    -- Format with Spotless (auto-detects Maven or Gradle)
    keymap("n", "<leader>lf", run_spotless, vim.tbl_extend("force", opts, {
      desc = "Format Java with Spotless (Maven/Gradle auto-detect)",
    }))

    -- Run linter
    keymap("n", "<leader>ll", function()
      require("lint").try_lint()
    end, vim.tbl_extend("force", opts, {
      desc = "Lint Java with checkstyle",
    }))

    -- Run Maven tests
    keymap("n", "<leader>tm", "<cmd>!mvn test<CR>", vim.tbl_extend("force", opts, {
      desc = "Run Maven tests",
    }))

    -- Run Gradle tests
    keymap("n", "<leader>tg", "<cmd>!gradle test<CR>", vim.tbl_extend("force", opts, {
      desc = "Run Gradle tests",
    }))

    -- Build Maven
    keymap("n", "<leader>bm", "<cmd>!mvn clean install<CR>", vim.tbl_extend("force", opts, {
      desc = "Build Maven (clean install)",
    }))

    -- Build Gradle
    keymap("n", "<leader>bg", "<cmd>!gradle clean build<CR>", vim.tbl_extend("force", opts, {
      desc = "Build Gradle (clean build)",
    }))
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- JAVA SNIPPETS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("java", {
  s("cl", {
    t("public class "),
    i(1, "ClassName"),
    t(" {"),
    t({ "", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s("m", {
    t("public "),
    i(1, "void"),
    t(" "),
    i(2, "methodName"),
    t("("),
    i(3),
    t(") {"),
    t({ "", "\t" }),
    i(4),
    t({ "", "}" }),
  }),

  s("psvm", {
    t("public static void main(String[] args) {"),
    t({ "", "\t" }),
    i(1),
    t({ "", "}" }),
  }),

  s("sout", {
    t("System.out.println("),
    i(1),
    t(");"),
  }),

  s("serr", {
    t("System.err.println("),
    i(1),
    t(");"),
  }),

  s("for", {
    t("for ("),
    i(1, "int i"),
    t(" = 0; i < "),
    i(2, "n"),
    t("; i++) {"),
    t({ "", "\t" }),
    i(3),
    t({ "", "}" }),
  }),

  s("if", {
    t("if ("),
    i(1),
    t(") {"),
    t({ "", "\t" }),
    i(2),
    t({ "", "}" }),
  }),

  s("try", {
    t("try {"),
    t({ "", "\t" }),
    i(1),
    t({ "", "} catch (" }),
    i(2, "Exception e"),
    t(") {"),
    t({ "", "\t" }),
    i(3),
    t({ "", "}" }),
  }),
})
