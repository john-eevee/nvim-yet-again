# Navigation & Utility Plugins Guide

## 📍 Harpoon - Quick File Navigation

Harpoon lets you bookmark up to 4 files per project for instant navigation. Perfect for jumping between your main files.

### Features
- Mark up to 4 files per project
- Quick menu for overview
- Navigate with single keybind
- Project-scoped bookmarks
- Persistent across sessions

### Key Bindings

```vim
<leader>ha    Add file to harpoon
<leader>hm    Toggle harpoon menu (view all marked files)
<leader>h1    Jump to marked file 1
<leader>h2    Jump to marked file 2
<leader>h3    Jump to marked file 3
<leader>h4    Jump to marked file 4
<leader>hp    Jump to previous harpooned file
<leader>hn    Jump to next harpooned file
```

### Usage Example

```
1. Open main.ex
2. Press <leader>ha to add it to harpoon
3. Open helper.ex
4. Press <leader>ha to add it to harpoon
5. Open test.exs
6. Press <leader>ha to add it
7. Now use <leader>h1, h2, h3 to jump between them
8. Or press <leader>hm to see all marked files
```

### Tips
- Mark your 4 most-used files per project
- Use `<leader>hm` to see which files are marked
- Marks are saved in `.harpoon.json` per project
- Perfect for context-switching between files

---

## 🔗 opencode.nvim - Open URLs and Documentation

Automatically detect and open URLs, API documentation, and resource links from your code.

### Features
- Click to open URLs under cursor
- Automatic link detection
- Platform-aware (macOS/Linux)
- Works with any URL
- API documentation integration

### Key Bindings

```vim
<leader>od    Open URL/link under cursor
```

### Usage Example

```python
# With cursor on a URL like https://github.com/username/repo
# Press <leader>od to open it in browser

# Also works with:
# - Documentation links in comments
# - GitHub URLs
# - API references
# - Any clickable URL
```

### Configuration

The handler is automatically detected:
- **macOS**: Uses `open` command
- **Linux**: Uses `xdg-open` command

### Tips
- Useful for opening GitHub issues/PRs directly
- Opens API docs from comment links
- Works with any protocol-based URL

---

## 🔀 other.nvim - Alternate File Navigation

Seamlessly toggle between your source files and test files. Supports multiple languages with smart patterns.

### Features
- Toggle between implementation and test files
- Smart file pattern matching
- Support for multiple languages
- Split/vsplit options
- Language-specific mappings

### Key Bindings

```vim
<leader>oa    Open alternate file
<leader>os    Open alternate in horizontal split
<leader>ov    Open alternate in vertical split
```

### Supported File Patterns

#### Elixir
```
lib/module.ex          ↔ test/module_test.exs
lib/my/path.ex         ↔ test/my/path_test.exs
```

#### Dart/Flutter
```
lib/widget.dart        ↔ test/widget_test.dart
lib/models/user.dart   ↔ test/models/user_test.dart
```

#### Lua
```
module.lua             ↔ spec/module_spec.lua
my/module.lua          ↔ my/spec/module_spec.lua
```

#### JavaScript/TypeScript
```
src/component.js       ↔ __tests__/component.test.js
src/utils/helper.ts    ↔ __tests__/helper.test.ts
```

### Usage Example

```
-- In lib/user.ex
<leader>oa    Opens test/user_test.exs

-- In test/user_test.exs
<leader>oa    Opens lib/user.ex

-- In vsplit mode:
<leader>ov    Opens alternate in vsplit window
```

### Tips
- Great for TDD workflow
- Use `<leader>os` to compare implementation and tests side-by-side
- Automatically creates missing test files on newer versions
- Customize patterns in `lua/plugins/navigation.lua`

---

## 🎯 Workflow Examples

### Example 1: Elixir Development
```
1. Open lib/user.ex
2. Press <leader>ha to mark it
3. Open lib/user_service.ex
4. Press <leader>ha to mark it
5. Write some tests - press <leader>oa to jump to tests
6. Fix implementations - press <leader>oa to jump back
7. Use <leader>h1, h2 to quickly switch files
```

### Example 2: Flutter Development
```
1. Working on lib/widgets/button.dart
2. Press <leader>ha to mark main widget
3. Open lib/models/app_state.dart
4. Press <leader>ha to mark model
5. Use <leader>oa to jump to tests
6. Make changes to tests
7. Use <leader>oa to jump back to implementation
8. Switch files with <leader>h1, h2
```

### Example 3: Documentation Workflow
```
1. Reading code with API docs reference
2. Press <leader>od on documentation link
3. Browser opens with docs in focus
4. Alt+Tab back to Neovim
5. Continue reading code
```

---

## ⚙️ Configuration

### Customize Harpoon
Edit `lua/plugins/navigation.lua` to change:
- Number of slots (default: 4)
- Save behavior
- Sync settings

### Customize other.nvim
Add more file patterns in `lua/plugins/navigation.lua`:
```lua
{
  pattern = "(.*)/app/(.*)\.rb$",
  target = "%1/spec/%2_spec.rb",
  context = "test",
}
```

### Customize opencode.nvim
Edit handler in `lua/plugins/navigation.lua` to use:
- Custom browser: `"firefox"`, `"google-chrome"`, etc.
- Different URL opener

---

## 🐛 Troubleshooting

### Harpoon marks not persisting
- Check project directory permissions
- Ensure `.harpoon.json` is in project root
- Try `:HarpoonSync` to refresh

### other.nvim can't find alternate file
- Verify file structure matches patterns
- Check pattern syntax in configuration
- Add custom patterns for your project structure

### URLs not opening
- Check system has `xdg-open` (Linux) or `open` (macOS)
- Try custom handler: `handler = "firefox"`
- Ensure URL is valid and cursor is on it

### Commands not found
```vim
:Mason          " Install missing plugins
:checkhealth   " Verify setup
:PackerSync    " Update plugins
```

---

## 📚 Integration with Other Tools

### With LSP Navigation
```vim
gd          Go to definition
gr          Find references
<leader>oa Jump to test file
<leader>h1 Jump to harpooned file
```

### With Telescope
```vim
<leader>ff Find files in project
<leader>ha Add to harpoon
<leader>h1 Jump to marked file
```

### With Buffer Navigation
```vim
<leader>bp Previous buffer
<leader>bn Next buffer
<leader>oa Switch to test/implementation
```

---

## 💡 Best Practices

1. **Harpoon Strategy**
   - Mark the 4 most-used files
   - One main file, 3 supporting files
   - Update marks as you work

2. **other.nvim Workflow**
   - Keep tests close to implementation
   - Use consistent naming patterns
   - Split view for side-by-side comparison

3. **opencode.nvim Usage**
   - Leave documentation links in comments
   - Document external resources
   - Quick access to references

---

## 🔧 File Patterns Reference

For `other.nvim`, common patterns:

```lua
-- Ruby on Rails
(.*)/app/models/(.*)\\.rb$              <-> %1/spec/models/%2_spec.rb
(.*)/app/controllers/(.*)\\.rb$         <-> %1/spec/controllers/%2_spec.rb

-- Go
(.*)/(.*)\\.(go)$                       <-> %1/%2_test.go

-- Python
(.*)/(.*)\\.(py)$                       <-> %1/tests/test_%2.py

-- C/C++
(.*)/src/(.*)\\.c$                      <-> %1/test/%2_test.c
```

---

## 🎨 Visual Navigation Flow

```
┌─────────────────────────────────────────────────┐
│  Project Files                                  │
├─────────────────────────────────────────────────┤
│ 📁 lib/                                         │
│  ├─ user.ex          ← <leader>ha mark this    │
│  ├─ service.ex       ← <leader>ha mark this    │
│  └─ helper.ex        ← <leader>ha mark this    │
│ 📁 test/                                        │
│  ├─ user_test.exs    ← <leader>oa from user.ex│
│  ├─ service_test.exs                           │
│  └─ helper_test.exs                            │
└─────────────────────────────────────────────────┘

Navigation:
  <leader>h1 → user.ex
  <leader>h2 → service.ex
  <leader>h3 → helper.ex
  <leader>oa → Toggle between file and test
```

---

## 📊 Plugin Comparison

| Feature | Harpoon | other.nvim | opencode.nvim |
|---------|---------|-----------|---------------|
| File Bookmarks | ✅ | - | - |
| Test/Impl Toggle | - | ✅ | - |
| URL Opening | - | - | ✅ |
| Split Support | ✅ | ✅ | - |
| Project Scoped | ✅ | ✅ | ✅ |
| Keybindings | ✅ | ✅ | ✅ |

---

## 🚀 Quick Start

1. **Mark files with Harpoon**
   ```vim
   :e lib/main.ex
   <leader>ha
   ```

2. **Jump to test file**
   ```vim
   <leader>oa
   ```

3. **Navigate marked files**
   ```vim
   <leader>h1  " Jump to marked file 1
   <leader>hm  " See all marked files
   ```

4. **Open URL in browser**
   ```vim
   <leader>od  " On any URL
   ```

---

**Happy navigating!** 🚀
