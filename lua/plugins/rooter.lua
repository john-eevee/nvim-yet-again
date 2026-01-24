-- ╔══════════════════════════════════════════════════════════════╗
-- ║         VIM-ROOTER - AUTO CD TO PROJECT ROOT                ║
-- ║     Automatically change directory to project root           ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Configure vim-rooter to detect project roots
vim.g.rooter_patterns = {
  ".git",
  ".hg",
  ".svn",
  "Makefile",
  "package.json",
  "pyproject.toml",
  "setup.py",
  "go.mod",
  "Cargo.toml",
  "mix.exs",
  "pubspec.yaml",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  ".root",
}

-- Change directory silently (don't echo the directory change)
vim.g.rooter_silent_chdir = 1

-- Resolve symlinks in project root detection
vim.g.rooter_resolve_symlinks = 1


-- Add keymap for manual rooter
vim.keymap.set(
  "n",
  "<leader>ur",
  "<cmd>RootCD<CR>",
  { noremap = true, silent = true, desc = "UI: Change to project root" }
)
