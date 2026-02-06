-- Python LSP Configuration (Ty - Astral's Python type checker)
-- Ty provides fast type checking and diagnostics for Python
-- See: https://docs.astral.sh/ty/editors/

return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_dir = function(fname)
    return vim.fs.root(fname, {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'pyrightconfig.json',
      'typings',
      '.git'
    })
  end,
 settings = {
    ty = {
      -- Type checking mode: strict, standard, or basic
      typeCheckingMode = 'standard',
      -- Additional settings for type checking
      diagnosticMode = 'workspace',
    },
  },
}
