# ⚡ CodeCompanion Agents - Quick Reference Card

## 🚀 Quick Start (30 seconds)

```vim
" Open Planner for task breakdown
:PlannerAgent
" or press <leader>cp

" Open Git Operator for commits/history
:GitOperator
" or press <leader>cg

" Send message: Ctrl-s
" Close chat: Ctrl-c
```

---

## 🎯 Planner Agent - What It Does

**Best For:**
- ✅ Breaking down features into tasks
- ✅ Planning sprints & milestones
- ✅ Creating todo lists with estimates
- ✅ Identifying dependencies
- ✅ Refactoring strategies

**Quick Prompts:**
```
"Break down implementing [FEATURE]"
"Create a sprint plan for [PROJECT]"
"Plan the refactoring of [COMPONENT]"
"What are the risks in this plan?"
"How do we parallelize this work?"
```

**You Get:**
- Multi-phase breakdown
- Time estimates
- Priority levels (🔴🟠🟡🟢)
- Dependencies & critical path
- Success criteria

---

## 🔗 Git Operator - What It Does

**Best For:**
- ✅ Writing conventional commits
- ✅ Understanding repository history
- ✅ Analyzing code hotspots
- ✅ Recommending git workflows
- ✅ Planning releases & refactors

**Quick Prompts:**
```
"Help me write a commit message for [CHANGES]"
"Analyze my commit history for [PERIOD]"
"What's the best git workflow for [TEAM]?"
"Show me commits related to [FILE/ISSUE]"
"Are there code quality issues in history?"
```

**You Get:**
- Conventional commit format
- Repository health analysis
- Commit frequency patterns
- Code hotspot identification
- Workflow recommendations

---

## 📋 Common Workflows

### Workflow 1: Plan & Build
```
1. :PlannerAgent
   "Break down this feature"

2. Work on task 1

3. :GitOperator
   "Help me write commit for task 1"

4. Repeat for each task
```

### Workflow 2: Sprint Retrospective
```
1. :GitOperator
   "Analyze commits from last sprint"

2. :PlannerAgent
   "Plan improvements based on analysis"
```

### Workflow 3: Code Review Prep
```
1. :GitOperator
   "Show commits on this branch clearly"

2. If major issues:
   :PlannerAgent
   "Plan how to restructure commits"
```

---

## ⌨️ All Keymaps

| Shortcut | What It Does |
|----------|-------------|
| `<leader>cc` | Open CodeCompanion Chat |
| `<leader>ca` | CodeCompanion Actions menu |
| `<leader>cp` | Open **Planner Agent** |
| `<leader>cg` | Open **Git Operator** |
| `Ctrl-s` | Send message in chat |
| `Ctrl-c` | Close chat window |

---

## 💡 Pro Tips

1. **Paste Code** - Better suggestions with context
2. **Ask Follow-ups** - Agents understand conversation history
3. **Copy Output** - Use in docs, task boards, wikis
4. **Refine** - Keep asking for more detail ("Expand phase 2")
5. **Export** - Save outputs for team reference

---

## 📚 Full Documentation

- **[CODECOMPANION_AGENTS.md](CODECOMPANION_AGENTS.md)** - Complete guide with examples
- **[AGENT_PROMPTS.md](AGENT_PROMPTS.md)** - Copy-paste prompt templates
- **[AGENTS_SUMMARY.md](AGENTS_SUMMARY.md)** - Implementation overview

---

## 🔧 Customization

Edit `lua/plugins/codecompanion_agents.lua` to:
- Modify agent behavior (change `system_prompt`)
- Add new agents
- Change keymaps
- Add team conventions

---

## ✅ You Now Have

✅ **Planner Agent** - Professional task breakdown & planning
✅ **Git Operator** - Expert git & repository guidance
✅ **3 Documentation Files** - Complete guides & templates
✅ **4 Quick Keymaps** - Fast access to agents
✅ **System Prompts** - AI-guided professional output

**→ Ready to use right now!**

---

## 🎯 First Steps

1. Press `<leader>cp` to open Planner
2. Ask: "Break down [your project]"
3. Get structured task breakdown with estimates
4. Press `<leader>cg` to open Git Operator
5. Ask: "Help me write a commit for [changes]"
6. Get professional conventional commit format

---

**Questions?** See [CODECOMPANION_AGENTS.md](CODECOMPANION_AGENTS.md)
**Need prompts?** See [AGENT_PROMPTS.md](AGENT_PROMPTS.md)
**Want details?** See [AGENTS_SUMMARY.md](AGENTS_SUMMARY.md)
