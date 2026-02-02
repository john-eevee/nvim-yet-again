-- Go LSP Configuration (gopls)
-- Official Go language server providing IDE features for Go

return {
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}
