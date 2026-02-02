-- Rust-analyzer LSP Configuration
-- Provides fast, incremental type checking and IDE features for Rust

return {
  settings = {
    ['rust-analyzer'] = {
      assist = {
        expressionFillDefault = 'todo',
      },
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = 'clippy',
        extraArgs = { '--all-targets', '--all-features' },
      },
      procMacro = {
        enable = true,
      },
      runnables = {
        command = 'cargo',
      },
      inlayHints = {
        enable = true,
        chainingHints = true,
        closureReturnTypeHints = 'with_block',
        closingBraceHints = true,
        lifetimeElisionHints = {
          enable = 'skip_trivial',
          useParameterNames = true,
        },
        maxLength = nil,
        reborrowHints = 'mutable',
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    },
  },
}
