-- Dart LSP Configuration
-- Language server for Dart providing IDE features

return {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    outline = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      enableSnippets = true,
      enableSdkFormatter = true,
      lineLength = 80,
    },
  },
}
