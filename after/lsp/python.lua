-- Python LSP Configuration (Ty - Astral's Python type checker)
-- Ty provides fast type checking and diagnostics for Python
-- See: https://docs.astral.sh/ty/editors/

return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_dir = require('lspconfig.util').root_pattern(
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'pyrightconfig.json',
    'typings',
    '.git'
  ),
  settings = {
    ty = {
      -- Type checking mode: strict, standard, or basic
      typeCheckingMode = 'standard',
      -- Additional settings for type checking
      diagnosticMode = 'workspace',
    },
  },
}
