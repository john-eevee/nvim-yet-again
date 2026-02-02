# Navigation Plugins - Quick Reference

## 🔗 Harpoon - File Bookmarks

### Keymaps
```vim
<leader>ha    Add current file to harpoon
<leader>hm    Toggle harpoon menu (see all 4 marks)
<leader>h1    Jump to harpooned file 1
<leader>h2    Jump to harpooned file 2
<leader>h3    Jump to harpooned file 3
<leader>h4    Jump to harpooned file 4
<leader>hp    Jump to previous harpooned file
<leader>hn    Jump to next harpooned file
```

### Quick Workflow
```
1. Mark 4 important files: <leader>ha (4 times)
2. View all marks: <leader>hm
3. Jump between them: <leader>h1, h2, h3, h4
4. Or navigate with: <leader>hp / <leader>hn
```

### Pro Tips
- Use same 4 files per project
- Great for: main file, test file, config, utils
- Marks save automatically per project
- See marks in `.harpoon.json`

---

## 🔀 other.nvim - Implementation ↔ Test Toggle

### Keymaps
```vim
<leader>oa    Open/toggle alternate file
<leader>os    Open alternate in horizontal split
<leader>ov    Open alternate in vertical split
```

### Supported Patterns
```
ELIXIR:
  lib/module.ex              <--> test/module_test.exs
  lib/my/path.ex             <--> test/my/path_test.exs

DART/FLUTTER:
  lib/widget.dart            <--> test/widget_test.dart
  lib/models/user.dart       <--> test/models/user_test.dart

LUA:
  module.lua                 <--> spec/module_spec.lua
  my/module.lua              <--> my/spec/module_spec.lua

JAVASCRIPT/TYPESCRIPT:
  src/component.js           <--> __tests__/component.test.js
  src/utils/helper.ts        <--> __tests__/helper.test.ts
```

### Quick Workflow
```
Editing implementation:
  <leader>oa  → Open/create test file

Editing test:
  <leader>oa  → Open implementation

Side-by-side comparison:
  <leader>os  → Split horizontally with test
  <leader>ov  → Split vertically with test
```

### Pro Tips
- Perfect for TDD (write test first)
- Use splits to compare code
- Works with most naming conventions
- Extensible with custom patterns

---

## 🌐 opencode.nvim - Open URLs

### Keymaps
```vim
<leader>od    Open URL/link under cursor
```

### What It Opens
- GitHub URLs (repos, issues, PRs)
- Documentation links
- API references
- Any valid URL in code/comments

### Quick Example
```python
# Documentation: https://docs.example.com/api
# Put cursor on URL, press <leader>od → Opens in browser

# Or in comments:
# See: https://github.com/user/repo
<leader>od  → Opens GitHub repo
```

### Pro Tips
- Works with any protocol (http, https, etc.)
- Platform-aware (macOS/Linux)
- Great for leaving reference links in code
- Supports custom browsers if needed

---

## 🎯 Common Workflows

### Workflow 1: Elixir TDD
```
1. :e lib/user.ex
2. <leader>ha           Mark implementation
3. <leader>oa          Jump to test
4. Write test
5. <leader>oa          Back to implementation
6. Fix code
7. <leader>oa          Back to test
8. Repeat
```

### Workflow 2: Flutter Development
```
1. :e lib/widgets/button.dart
2. <leader>ha           Mark widget file
3. :e lib/models/state.dart
4. <leader>ha           Mark model file
5. <leader>ov           Open test in vsplit
6. Write test and impl side-by-side
7. <leader>h1, h2       Jump between marked files
```

### Workflow 3: Documentation Reference
```
1. Reading code with API docs nearby
2. Hover on doc link
3. <leader>od           Opens docs in browser
4. Alt+Tab back to Neovim
5. Continue coding
```

### Workflow 4: Project Navigation
```
1. Main project files:
   - lib/main.ex         <leader>ha
   - lib/core.ex         <leader>ha
   - lib/utils.ex        <leader>ha
   - config/config.exs   <leader>ha

2. Quick navigation:
   <leader>hm  See all 4
   <leader>h1  Main file
   <leader>h2  Core logic
   <leader>h3  Utils
   <leader>h4  Config
```

---

## ⚙️ Integration Tips

### With LSP
```vim
gd              Go to definition
gr              Find references
<leader>oa      Jump to test file
<leader>h1      Jump to bookmarked file
```

### With Telescope
```vim
<leader>ff      Find file
<leader>ha      Add to harpoon
<leader>hm      See harpooned files
```

### With Tree
```vim
<leader>e       Toggle file explorer
Navigate to file
<leader>ha      Mark it
<leader>oa      Jump to test
```

---

## 📊 Comparison: When to Use

| Situation | Plugin | Command |
|-----------|--------|---------|
| Jump between 4 most-used files | Harpoon | `<leader>h1-h4` |
| Switch impl ↔ test | other.nvim | `<leader>oa` |
| Open API doc URL | opencode.nvim | `<leader>od` |
| See all marked files | Harpoon | `<leader>hm` |
| Split view impl + test | other.nvim | `<leader>os/ov` |
| Navigate previous marked | Harpoon | `<leader>hp` |

---

## 🚀 Pro Tips & Tricks

### Harpoon
- Mark files that you jump between most
- Use same 4 marks per project type
- Alt+[1-4] can be mapped for muscle memory
- Marks are project-directory scoped

### other.nvim
- Use for test-driven development
- Side-by-side editing with splits
- Create test files on-the-fly
- Works with most naming patterns

### opencode.nvim
- Leave documentation links in comments
- Easy access to GitHub issues
- Share links with team easily
- Works without mouse!

---

## 🔧 Customization

### Add Custom Patterns (other.nvim)
Edit `lua/plugins/navigation.lua`:
```lua
{
  pattern = "(.*)/app/(.*)\.rb$",
  target = "%1/spec/%2_spec.rb",
  context = "test",
}
```

### Change URL Handler
Edit `lua/plugins/navigation.lua`:
```lua
handler = "firefox"        -- Use Firefox
handler = "google-chrome"  -- Use Chrome
```

### Add More Harpoon Marks
Modify `lua/plugins/navigation.lua` to add more keymaps:
```lua
map("n", "<leader>h5", function()
  harpoon:list():select(5)
end, { noremap = true, desc = "Harpoon: Jump to 5" })
```

---

## ❓ FAQ

**Q: Do harpoon marks persist?**
A: Yes! Marks are saved in `.harpoon.json` per project.

**Q: Can I have more than 4 harpoon marks?**
A: Yes, add more keymaps in `navigation.lua`.

**Q: What if test file doesn't exist?**
A: other.nvim creates it on jump (version dependent).

**Q: Does opencode.nvim work offline?**
A: No, it opens URLs in browser. Needs internet.

**Q: Can I customize file patterns?**
A: Yes, edit `lua/plugins/navigation.lua` mappings.

---

## 🎓 Learning Path

1. **Start with Harpoon**
   - Mark 4 files
   - Use `<leader>h1-4` to jump
   - Master muscle memory

2. **Add other.nvim**
   - Use `<leader>oa` for test toggle
   - Try splits with `<leader>ov`

3. **Complete with opencode.nvim**
   - Leave doc links in comments
   - Use `<leader>od` for quick access

4. **Combine All Three**
   - Harpoon for main navigation
   - other.nvim for test files
   - opencode.nvim for documentation

---

**Start using navigation plugins! 🚀**

All keymaps are non-conflicting and integrate seamlessly with your existing setup.
