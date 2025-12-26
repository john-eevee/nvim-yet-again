# Snippets Guide

This guide covers the snippet management system in your Neovim configuration using **LuaSnip**.

## Overview

LuaSnip is a snippet engine that allows you to quickly insert common code patterns. It supports:
- **Built-in snippets** from friendly-snippets (VSCode-compatible snippets)
- **Custom snippets** that you can create for your specific workflows
- **Dynamic expansion** with variables, transformations, and conditionals

## Quick Start

### Using Built-in Snippets

Snippets from friendly-snippets are automatically loaded. To use them:

1. Start typing a snippet prefix (e.g., `for`, `if`, `fn`, etc.)
2. Look for completions that appear in the autocomplete menu
3. Select the snippet and press `<Tab>` to expand it

**Common snippets by language:**
- **Python**: `for`, `if`, `def`, `class`, `try`
- **JavaScript/TypeScript**: `for`, `if`, `fn`, `arrow`, `async`
- **Lua**: `for`, `if`, `local`, `function`
- **Java**: `class`, `method`, `try`, `for`

### Creating Custom Snippets

Use the command to create and manage custom snippets:

```vim
:SnippetCreate
```

Or use the keybind:

```vim
<leader>snip
```

This will:
1. Prompt you for a snippet name
2. Create a JSON snippet file in `~/.config/nvim/snippets/[filetype].json`
3. Open the file for editing

## Snippet File Structure

Snippets are stored as JSON files with the following structure:

```json
{
  "snippet_name": {
    "prefix": "sn",
    "body": [
      "Line 1 of expanded text",
      "Line 2 of expanded text",
      "${1:default_value}"
    ],
    "description": "What this snippet does"
  }
}
```

### Components

- **prefix**: The text you type to trigger the snippet
- **body**: An array of strings representing lines. Can include:
  - `${1}` - Tab stop (cursor jumps here)
  - `${1:default}` - Tab stop with default text
  - `${2}`, `${3}`, etc. - Multiple tab stops in order
  - `${1|option1,option2|}` - Choice between options
  - `$TM_FILENAME` - Current filename
  - `$TM_SELECTED_TEXT` - Selected text
- **description**: Appears in the autocomplete menu

## Example Snippets

### Python Class Definition

```json
{
  "class": {
    "prefix": "class",
    "body": [
      "class ${1:ClassName}:",
      "    \"\"\"${2:Docstring}\"\"\"",
      "    ",
      "    def __init__(self${3:, args}):",
      "        ${0:pass}"
    ],
    "description": "Class definition"
  }
}
```

### JavaScript Arrow Function

```json
{
  "arrow_function": {
    "prefix": "af",
    "body": [
      "const ${1:name} = (${2:params}) => {",
      "  ${0:}",
      "};"
    ],
    "description": "Arrow function"
  }
}
```

### React Component

```json
{
  "react_component": {
    "prefix": "comp",
    "body": [
      "export default function ${1:ComponentName}() {",
      "  return (",
      "    <div>",
      "      ${0:}",
      "    </div>",
      "  );",
      "}"
    ],
    "description": "React functional component"
  }
}
```

## Navigation & Editing

After expanding a snippet:

| Action | Key |
|--------|-----|
| Jump to next tab stop | `<Tab>` |
| Jump to previous tab stop | `<Shift-Tab>` |
| Select tab stop text | `<Tab>` at a stop with default text |
| Exit snippet mode | `<Esc>` |

## Snippet Locations

### Built-in Snippets
- From `friendly-snippets` package
- Covers 50+ languages with standard patterns
- Auto-loaded when LuaSnip initializes

### Custom Snippets Directory
```
~/.config/nvim/snippets/
├── python.json
├── lua.json
├── javascript.json
├── java.json
└── ...
```

Each filetype has its own JSON file.

## Managing Snippets

### View Available Snippets
Currently, built-in snippets are available immediately. For custom snippets:

1. Create them using `:SnippetCreate`
2. View them in `~/.config/nvim/snippets/[filetype].json`

### Edit Existing Snippets
Directly edit the JSON files in `~/.config/nvim/snippets/`

### Organization Tips
- Keep snippets organized by language/filetype
- Use descriptive prefixes (e.g., `for_`, `if_`, `class_`)
- Include docstrings in descriptions
- Document custom syntax in comments

## Advanced Features

### Tab Stops & Placeholders

```json
{
  "prefix": "ts",
  "body": [
    "function ${1:name}(${2:arg1}, ${3:arg2}) {",
    "  // TODO: ${4:implementation}",
    "  return ${0:};",
    "}"
  ]
}
```

### Choices

```json
{
  "prefix": "choice",
  "body": [
    "const ${1|const,let,var|} x = ${0:value};"
  ]
}
```

### Transformations

```json
{
  "prefix": "trans",
  "body": [
    "function ${1:myFunction}() {",
    "  // Function: ${1:/upcase}",
    "}"
  ]
}
```

## Configuration

Current configuration in `lua/plugins/snippets.lua`:

- **Auto-loading**: Snippets are automatically loaded from both built-in and custom directories
- **Directory**: Snippets stored at `~/.config/nvim/snippets/`
- **VSCode Format**: Uses JSON format compatible with VSCode snippets

## Troubleshooting

### Snippets not showing in autocomplete
- Ensure LuaSnip is installed and loaded
- Check that the snippet prefix matches what you're typing
- Verify snippet files are in the correct format (valid JSON)

### Custom snippets not loading
- Check file is at `~/.config/nvim/snippets/[filetype].json`
- Verify JSON syntax is valid
- Restart Neovim or run `:LuaSnipReload`

### Tab navigation not working
- Ensure you're expanding a snippet (not just typing text)
- Check that LuaSnip is properly initialized
- Try pressing `<Tab>` while a snippet is active

## Resources

- [LuaSnip Documentation](https://github.com/L3MON4D3/LuaSnip)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Built-in snippet library
- [VSCode Snippets Format](https://code.visualstudio.com/docs/editor/userdefinedsnippets)

## Quick Reference

| Command | Action |
|---------|--------|
| `:SnippetCreate` | Create new snippet |
| `<leader>snip` | Create new snippet (keybind) |
| `<Tab>` | Expand snippet / Jump to next tab stop |
| `<Shift-Tab>` | Jump to previous tab stop |

---

*Last updated: 2025-12-26*
