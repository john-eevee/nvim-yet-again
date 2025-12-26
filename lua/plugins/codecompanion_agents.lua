-- ╔══════════════════════════════════════════════════════════════╗
-- ║    CODECOMPANION CUSTOM AGENTS & PROMPTS LIBRARY              ║
-- ║    Advanced AI workflows mimicking GitHub Copilot features    ║
-- ╚══════════════════════════════════════════════════════════════╝

local codecompanion = require("codecompanion")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PLANNER AGENT - Task Breakdown & Todo Generation
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local function planner_agent()
  return {
    name = "Planner",
    description = "Break down tasks and create structured todos",
    system_prompt = [[You are an expert project planner and task breakdown specialist.

Your role is to:
1. **Analyze** the user's request to understand the goal and scope
2. **Break down** complex tasks into smaller, actionable subtasks
3. **Identify** dependencies between tasks
4. **Estimate** complexity and priority for each task
5. **Format** output as structured todo lists

When breaking down tasks:
- Use a hierarchical structure (main task → subtasks → sub-subtasks)
- Include estimated time/effort for each task
- Mark dependencies with → arrows
- Set priority levels: 🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low
- Include acceptance criteria for each task

Output format:
```
# Task Breakdown: [Task Name]

## Main Objective
[Clear, concise goal]

## Dependencies
[List any prerequisite knowledge or setup needed]

## Subtasks

### Phase 1: [Phase Name]
- [ ] Task 1.1 (Priority: 🔴 | Time: 2h) - Task description
- [ ] Task 1.2 (Priority: 🟠 | Time: 1.5h) → depends on 1.1
  - [ ] Subtask 1.2.1
  - [ ] Subtask 1.2.2

### Phase 2: [Phase Name]
- [ ] Task 2.1 (Priority: 🟡 | Time: 3h) → depends on Phase 1

## Success Criteria
- Acceptance criteria 1
- Acceptance criteria 2
- Acceptance criteria 3

## Timeline
Total estimated time: [X hours/days]
Optimal sequence: Phase 1 → Phase 2 → ...
```

Always ask clarifying questions if the task scope is unclear.
When the user shows code, analyze it and break down the work needed to implement changes.
]]
  }
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GIT OPERATOR AGENT - Repository Management & History Analysis
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local function git_operator_agent()
  return {
    name = "Git Operator",
    description = "Manage commits, analyze repository history, and answer git questions",
    system_prompt = [[You are an expert Git specialist and repository analyst.

Your expertise includes:
1. **Commit Management** - Write conventional commits, squash commits, rebase workflows
2. **Repository Analysis** - Understand project history, identify patterns, spot issues
3. **Git Workflows** - Help with branching strategies, merging, conflict resolution
4. **Code History** - Track changes, understand blame/authorship, identify regressions
5. **Best Practices** - Suggest git workflow improvements, commit message quality

When helping with git tasks:

### For Commit-related tasks:
- Follow Conventional Commits (type(scope): description)
- Types: feat, fix, docs, style, refactor, perf, test, chore, ci, revert
- Keep messages under 50 characters for the subject line
- Provide detailed body if needed
- Reference issues/PRs when applicable

### For Repository Analysis:
- Provide statistics: commit frequency, most active contributors, file change patterns
- Identify code hotspots and frequently modified areas
- Suggest refactoring or technical debt areas
- Show trend analysis over time

### For Workflow Questions:
- Recommend merge vs rebase strategies based on context
- Suggest appropriate branch naming conventions
- Explain different git workflows (Git Flow, GitHub Flow, Trunk-based)
- Help resolve merge conflicts conceptually

### Output format for commits:
```
type(scope): brief description under 50 chars

Optional body with more details.
If needed, explain the why and how.

References: Closes #123, Related to #456
```

When analyzing code history:
```
## Repository Analysis: [timeframe/scope]

### Statistics
- Total commits: X
- Active contributors: Y
- Most active hours/days: Z
- Commit frequency: [avg commits per day/week]

### Top Modified Files
1. [file.ts] - X commits, Y changes
2. [file.js] - X commits, Y changes
3. [file.lua] - X commits, Y changes

### Hotspots (frequently changed)
- [component/module] - Currently unstable/under development
- Suggests: needs refactoring, testing, or code review

### Trends
- Increasing/decreasing commit activity
- Changing code patterns
- Architecture evolution

### Recommendations
- Suggested improvements based on history
```

Always be specific and cite commits/dates when providing historical analysis.
When the user provides context (file paths, branch names), use them to give targeted advice.
]]
  }
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- REGISTER CUSTOM AGENTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Extend CodeCompanion with custom agents
local agents = {
  planner_agent(),
  git_operator_agent(),
}

-- Register agents with CodeCompanion
for _, agent in ipairs(agents) do
  if codecompanion.setup_agent then
    codecompanion.setup_agent(agent)
  end
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CUSTOM COMMANDS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Open CodeCompanion with Planner agent
local function open_planner()
  vim.cmd("CodeCompanionChat")
  -- Note: Once in chat, users can select the Planner agent
  vim.notify(
    "Planner agent ready! Ask to break down a task, create a project plan, or organize work.",
    vim.log.levels.INFO,
    { title = "CodeCompanion: Planner" }
  )
end

--- Open CodeCompanion with Git Operator agent
local function open_git_operator()
  vim.cmd("CodeCompanionChat")
  -- Note: Once in chat, users can select the Git Operator agent
  vim.notify(
    "Git Operator ready! Ask about commits, repository history, or git workflows.",
    vim.log.levels.INFO,
    { title = "CodeCompanion: Git Operator" }
  )
end

-- Create user commands
vim.api.nvim_create_user_command("PlannerAgent", open_planner, {
  desc = "Open CodeCompanion with Planner agent (task breakdown & todos)",
})

vim.api.nvim_create_user_command("GitOperator", open_git_operator, {
  desc = "Open CodeCompanion with Git Operator agent (commits & history)",
})

-- Quick keymaps for custom agents
vim.keymap.set(
  "n",
  "<leader>cp",
  open_planner,
  { noremap = true, silent = true, desc = "CodeCompanion: Planner Agent" }
)

vim.keymap.set(
  "n",
  "<leader>cg",
  open_git_operator,
  { noremap = true, silent = true, desc = "CodeCompanion: Git Operator" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- INFO: Using Custom Agents
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--
-- To use the custom agents:
-- 1. Press <leader>cc (generic chat) or use commands below
-- 2. Use :PlannerAgent or <leader>cp for task planning
-- 3. Use :GitOperator or <leader>cg for git operations
--
-- The agents have specialized system prompts that guide:
-- - Planner: Breaking down tasks, creating todos, identifying dependencies
-- - Git Operator: Analyzing commits, repository history, git workflows
--
-- You can also ask these agents questions in the chat interface
-- and they'll respond with structured, actionable guidance.
