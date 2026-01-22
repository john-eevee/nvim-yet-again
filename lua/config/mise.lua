-- ╔══════════════════════════════════════════════════════════════╗
-- ║     MISE-EN-PLACE ENVIRONMENT & PROJECT CONFIGURATION       ║
-- ║  Setup for common tools, languages, and development paths   ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ENVIRONMENT DETECTION & SETUP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Detect if we're in a project with specific tools
local function has_file(name)
  return vim.fn.filereadable(vim.fn.getcwd() .. "/" .. name) == 1
end

local function has_dir(name)
  return vim.fn.isdirectory(vim.fn.getcwd() .. "/" .. name) == 1
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PROJECT TYPE DETECTION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local project_type = {}

if has_file("package.json") then
  table.insert(project_type, "node")
end

if has_file("pyproject.toml") or has_file("requirements.txt") or has_dir("venv") then
  table.insert(project_type, "python")
end

if has_file("Cargo.toml") then
  table.insert(project_type, "rust")
end

if has_file("go.mod") then
  table.insert(project_type, "go")
end

if has_file("pom.xml") or has_file("build.gradle") then
  table.insert(project_type, "java")
end

if has_file(".ruby-version") or has_file("Gemfile") then
  table.insert(project_type, "ruby")
end

-- Store detected project types for later use
vim.g.project_types = project_type

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LANGUAGE-SPECIFIC SETUP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Python: Configure virtual environment detection
if vim.tbl_contains(project_type, "python") then
  local venv_dirs = { "venv", ".venv", "env", ".env" }
  for _, venv in ipairs(venv_dirs) do
    if has_dir(venv) then
      vim.env.VIRTUAL_ENV = vim.fn.getcwd() .. "/" .. venv
      break
    end
  end
end

-- Node.js: Ensure node_modules are excluded from search
if vim.tbl_contains(project_type, "node") then
  vim.opt.wildignore:append("node_modules")
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- HELPER FUNCTIONS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Check if a project type is detected
--- @param pt string The project type to check
--- @return boolean
function vim.g.is_project_type(pt)
  return vim.tbl_contains(vim.g.project_types or {}, pt)
end
