# 🤖 CodeCompanion Custom Agents Guide

Advanced AI-powered workflows mimicking GitHub Copilot's VSCode features. Two specialized agents for task planning and git operations.

## Table of Contents

- [Quick Start](#quick-start)
- [Planner Agent](#planner-agent)
- [Git Operator Agent](#git-operator-agent)
- [Usage Examples](#usage-examples)
- [Tips & Tricks](#tips--tricks)

## Quick Start

**Three ways to access agents:**

```vim
" Open main chat interface
:CodeCompanionChat          " or <leader>cc

" Open with Planner agent
:PlannerAgent              " or <leader>cp

" Open with Git Operator
:GitOperator               " or <leader>cg
```

**In the chat interface:**
- `Ctrl-s` to send message
- `Ctrl-c` to close
- Type your request naturally
- Agent responds with structured output

---

## Planner Agent

**Purpose:** Break down complex tasks into manageable todos with dependencies, priority levels, and timelines.

### Key Capabilities

- ✅ **Task Decomposition** - Break down features into subtasks
- ✅ **Dependency Mapping** - Identify task relationships (→)
- ✅ **Priority Levels** - 🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low
- ✅ **Time Estimation** - Realistic effort for each task
- ✅ **Phase Organization** - Group related work into phases
- ✅ **Success Criteria** - Define acceptance criteria

### Usage Examples

#### Example 1: Feature Planning

**Ask the Planner:**
```
I need to implement a dark mode toggle for my Neovim config.
The interface should remember user preference and apply on startup.
```

**Expected response:**
```
# Task Breakdown: Implement Dark Mode Toggle

## Main Objective
Add persistent dark mode toggle with auto-apply on startup

## Subtasks

### Phase 1: Core Implementation
- [ ] Modify color scheme loading (Priority: 🔴 | Time: 1h)
  - [ ] Create theme detection logic
  - [ ] Add theme storage mechanism
- [ ] Create toggle command (Priority: 🔴 | Time: 0.5h)

### Phase 2: Persistence
- [ ] Add user preference storage (Priority: 🟠 | Time: 1.5h)
  - [ ] Save preference to config file
  - [ ] Load on startup
  - [ ] Handle missing config gracefully

## Timeline
Total: ~3 hours
Order: Phase 1 → Phase 2
```

#### Example 2: Project Initialization

**Ask:**
```
Help me plan the structure for a Python web scraper project.
It should handle multiple data sources, store in database, and generate reports.
```

**You get:**
- Multi-phase breakdown
- Component architecture suggestions
- Dependency management plan
- Testing strategy
- Timeline with effort estimates

### Pro Tips

1. **Provide Context** - Share code snippets or requirements for better breakdown
2. **Ask for Refinement** - "Expand on Phase 2" or "Add testing phase"
3. **Request Estimation** - "How long for each subtask?"
4. **Ask About Risks** - "What could go wrong?"

---

## Git Operator Agent

**Purpose:** Expert guidance on commits, repository analysis, and git workflows.

### Key Capabilities

- ✅ **Commit Crafting** - Write conventional commits with context
- ✅ **Repository Analysis** - Understand project history and patterns
- ✅ **Workflow Guidance** - Recommend git strategies
- ✅ **History Investigation** - Track changes, identify regressions
- ✅ **Conflict Resolution** - Help with merge conflicts
- ✅ **Best Practices** - Suggest improvements

### Conventional Commits Format

Agent guides you to use this standard:

```
type(scope): subject under 50 chars

Optional body with more details explaining:
- What changed
- Why it changed
- How it impacts the project

Closes #issue-number
References #related-issue
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Formatting (no code logic change)
- `refactor` - Code reorganization
- `perf` - Performance improvement
- `test` - Test changes
- `chore` - Build/dependency changes
- `ci` - CI/CD changes
- `revert` - Revert previous commit

### Usage Examples

#### Example 1: Commit Help

**Ask:**
```
I just refactored the test utilities module to improve readability.
Help me write a good commit message.
```

**You get:**
```
type(scope): brief description

refactor(test): improve test utility readability and reduce duplication

This refactoring:
- Extracts common assertion helpers into utility functions
- Simplifies test setup/teardown with factory functions
- Improves type safety with better documentation
- Reduces test file sizes by ~30%

Relates to #123
```

#### Example 2: Repository Analysis

**Ask:**
```
Analyze my repository's commit history for the last 3 months.
What patterns do you see? Any concerns?
```

**You get:**
```
## Repository Analysis: Last 3 Months

### Statistics
- Total commits: 127
- Active contributors: 3
- Peak activity: Weekdays 10am-3pm
- Commit frequency: ~4 commits per day

### Top Modified Files
1. src/components/Form.tsx - 34 commits
2. src/utils/api.ts - 28 commits
3. tests/integration.test.ts - 18 commits

### Hotspots (Code Needs Attention)
- src/components/Form.tsx - Highly unstable, changes frequently
  Suggests: Complex component, consider splitting
- src/utils/api.ts - Changing frequently
  Suggests: API needs stabilization or versioning

### Trends
- Increasing test coverage (good!)
- Form component becoming large (refactor needed)
- Steady churn in utilities (expected)

### Recommendations
1. Break down Form.tsx into smaller components
2. Consider API versioning or stability strategy
3. Add E2E tests for frequently-changed features
4. Review and document complex utility functions
```

#### Example 3: Workflow Recommendation

**Ask:**
```
Our team is 5 developers. What git workflow would you recommend?
We do daily deploys and need to maintain stability in main.
```

**You get:**
```
## Recommended: GitHub Flow (with slight modifications)

### Workflow:
1. Create feature branch from main
2. Make commits, push regularly
3. Create PR for code review
4. Merge to main after approval
5. Deploy immediately

### Branch Naming:
- feature/feature-name
- bugfix/issue-description
- hotfix/critical-issue
- docs/what-changed

### Commit Guidelines:
- Use conventional commits
- One logical change per commit
- Write descriptive messages (helps with bisect/blame)

### Protection Rules:
- Require PR review (1-2 approvals)
- Require passing CI/CD
- Auto-delete head branches
- Allow force-push only to feature branches

### For Your Case (Daily Deploys):
- Keep feature branches short-lived (< 1-2 days)
- Deploy main automatically to staging
- Manual approval to production
- Tag releases for easy rollback
```

### Pro Tips

1. **Provide Branch Context** - "Analyze my current branch"
2. **Ask About Tools** - "How to handle this conflict?"
3. **Request Patterns** - "Show me the commit history for this file"
4. **Ask for Explanations** - "Why is this approach better?"

---

## Usage Examples

### Task Planning Workflow

1. **Open Planner:**
   ```vim
   :PlannerAgent
   ```

2. **Describe Your Project:**
   ```
   I'm building a Neovim plugin for AI-assisted git operations.
   It should help with commit messages, branch management, and history queries.
   ```

3. **Get Structured Breakdown:**
   - Multi-phase plan with subtasks
   - Time estimates
   - Dependency chains
   - Success criteria

4. **Refine as Needed:**
   ```
   Can you expand the testing phase?
   What's the estimated timeline for just the MVP?
   ```

### Git Workflow Setup

1. **Open Git Operator:**
   ```vim
   :GitOperator
   ```

2. **Ask for Guidance:**
   ```
   What's the best strategy for handling hotfixes
   while keeping the main branch production-ready?
   ```

3. **Get Actionable Recommendations:**
   - Step-by-step workflow
   - Branch strategies
   - Protection rules
   - Tools and automation

### Real-Time Development

**While coding:**
```vim
" Ask Planner for next steps
:PlannerAgent
" What should I work on next according to the breakdown?

" Ask Git Operator for commit help
:GitOperator
" I just refactored X. Help me write the commit message.
```

---

## Tips & Tricks

### 1. Context is Power
Always provide relevant context:
- Show code snippets for better suggestions
- Share project requirements for planning
- Explain team constraints for workflow suggestions

### 2. Ask Clarifying Questions
If a response isn't perfect:
```
That's good, but can you:
- Add more detail to phase 2?
- Include database schema planning?
- Explain the rationale for this approach?
```

### 3. Export & Reference
Copy formatted output to:
- Project documentation
- Issue descriptions
- Task management tools (Jira, Linear, etc.)
- Team wikis

### 4. Use in Workflow
**Day Start:**
```vim
:PlannerAgent
" What should I focus on today given the project timeline?
```

**Before Committing:**
```vim
:GitOperator
" Help me write a clear commit message for these changes
```

**End of Sprint:**
```vim
:GitOperator
" Analyze last 2 weeks of commits. What patterns do you see?
```

### 5. Iterate & Refine
Agents understand context from previous messages:
```
Initial: "Help me plan a React component library"
Follow-up: "Now add accessibility requirements"
Follow-up: "Make the phases smaller for weekly sprints"
Follow-up: "Include performance benchmarking"
```

### 6. Team Synchronization
Use agent output for team discussions:
- Share Planner breakdowns for sprint planning
- Use Git Operator analysis for retrospectives
- Reference workflow recommendations for onboarding

---

## Keyboard Shortcuts Reference

| Shortcut | Action |
|----------|--------|
| `<leader>cc` | Open CodeCompanion Chat |
| `<leader>ca` | CodeCompanion Actions |
| `<leader>cp` | Open Planner Agent |
| `<leader>cg` | Open Git Operator |
| `Ctrl-s` (in chat) | Send message |
| `Ctrl-c` (in chat) | Close chat |

---

## Troubleshooting

**Agent not responding?**
- Ensure Copilot API is configured
- Check `:checkhealth codecompanion`
- Try opening fresh chat window

**Want to modify agents?**
- Edit [lua/plugins/codecompanion_agents.lua](../lua/plugins/codecompanion_agents.lua)
- Update `system_prompt` for agent behavior
- Add new agents following the same pattern

**Need different agent?**
Create a new agent in `codecompanion_agents.lua`:
```lua
local function custom_agent()
  return {
    name = "Custom Name",
    description = "What it does",
    system_prompt = [[Your custom prompt here]]
  }
end
```

---

## Advanced: Extending Agents

Each agent is defined with a `system_prompt` that guides the AI behavior. To customize:

1. Open `lua/plugins/codecompanion_agents.lua`
2. Find the agent you want to modify
3. Update the `system_prompt` string
4. Reload Neovim or run `:e` in the config file

Example additions:
- Add team-specific conventions to Git Operator
- Add project-specific patterns to Planner
- Create domain-specific agents (Testing, Performance, Security, etc.)
