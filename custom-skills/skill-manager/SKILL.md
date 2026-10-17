---
name: skill-manager
description: Manages skills across AI coding agents (Antigravity, Claude Code, Cursor, Windsurf). Use when adding an external skill from GitHub, creating a custom skill, removing a skill, or deciding between global and local (project-level) installation.
---

# Universal Skill Manager Workflow

This skill automates adding, creating, removing, and scoping skills across any AI coding agent environment.

---

## 1. Runtime Environment & Target Directories

When executed, determine the active AI coding host and its corresponding installation paths:

| AI Host Environment | Global Directory (All Projects) | Local Directory (Current Workspace) |
| :--- | :--- | :--- |
| **Google Antigravity** | `$HOME\.gemini\config\skills\` | `<workspace>\.agents\skills\` |
| **Claude Code** | `$HOME\.claude\skills\` | `<workspace>\.claude\skills\` |
| **Cursor / Codex** | `$HOME\.cursor\skills\` (or global config) | `<workspace>\.agents\skills\` |
| **Windsurf / OpenCode** | `$HOME\.windsurf\skills\` | `<workspace>\.agents\skills\` |

- **Central Curated Repository:** `C:\Users\harun\Documents\antigravity\curated-skills`
  - Manifest: `curated-skills/skills.json`
  - Documentation: `curated-skills/README.md`
  - Custom skills source: `curated-skills/custom-skills/`

---

## 2. Mandatory Scope Decision: Global vs. Local

Before installing or creating any skill:

1. **Check User Intent:** If the user explicitly specified the scope (e.g., *"install globally"* or *"install only to this project"*), proceed with that choice.
2. **Proactively Ask if Undefined:** If the scope was NOT specified in the user's prompt, ask the user before writing any files:
   > *"Would you like to install this skill **Globally** (available across all projects on this machine) or **Locally** (only in this specific project workspace)?"*

### Scope Behaviors:
- **Global Scope:**
  - Registered into the central `curated-skills` repository (`skills.json` and `README.md`).
  - Installed into the host's global skills directory (e.g., `~/.gemini/config/skills/` or `~/.claude/skills/`).
- **Local (Project) Scope:**
  - Installed directly into `<current-workspace>\.agents\skills\<skill-name>\` (or `<workspace>\.claude\skills\` for Claude Code).
  - Keeps the central dotfiles repository clean and prevents global context pollution.

---

## 3. Adding an External Skill from GitHub

Trigger: User provides a GitHub repository link or requests an existing open-source skill.

### Step 1: Inspect Repository
1. Determine repository structure:
   - **`git-clone`:** The repository is a standalone skill with `SKILL.md` at root.
   - **`github-extract`:** The repository is a monorepo / collection. Identify the specific `subpath` (e.g. `skills/<name>`).
2. Read the upstream `SKILL.md` to extract: `name`, `author`, `description`, and any `references`.

### Step 2: Install Based on Chosen Scope
- **If Global:**
  1. Add an entry to `skills.json` under `skills.external`:
     ```json
     {
       "name": "<name>",
       "author": "<author>",
       "repo": "https://github.com/<owner>/<repo>",
       "subpath": "<optional-subpath>",
       "type": "git-clone" | "github-extract",
       "references": ["<optional-reference-files>"],
       "description": "<concise-english-summary>"
     }
     ```
  2. Add a row to the **1. External Skills** table in `curated-skills/README.md`.
  3. Execute `install.bat` (or `install.ps1`) to download and configure into the global directory.
- **If Local:**
  1. Download or clone directly into `<workspace>\.agents\skills\<skill-name>\`.
  2. Verify that `<workspace>\.agents\skills\<skill-name>\SKILL.md` is valid.

---

## 4. Creating a New Custom Skill

Trigger: User requests to build a new skill or custom workflow.

### Step 1: Author the Skill
1. Create `SKILL.md` adhering strictly to Agent Skills best practices:
   - Frontmatter with unique `name` and action-oriented `description` (stating *when* to trigger).
   - Clear rules, operational steps, checklists, and verification criteria.

### Step 2: Save by Scope
- **If Global:**
  1. Save file to: `curated-skills/custom-skills/<skill-name>/SKILL.md`.
  2. Register in `curated-skills/skills.json` under `skills.custom`.
  3. Add row to **2. Custom Skills** table in `curated-skills/README.md`.
  4. Copy to the active host's global directory (e.g., `~/.gemini/config/skills/<skill-name>/`).
- **If Local:**
  1. Save directly to `<workspace>\.agents\skills\<skill-name>\SKILL.md`.

---

## 5. Removing a Skill

Trigger: User requests to remove or delete a skill.

1. Determine where the skill is located (Global in `curated-skills`, or Local in the workspace).
2. If Global:
   - Remove entry from `curated-skills/skills.json`.
   - Remove row from `curated-skills/README.md`.
   - If custom, delete `curated-skills/custom-skills/<skill-name>/`.
   - Delete from the host's global directory (`~/.gemini/config/skills/<skill-name>/` or `~/.claude/skills/<skill-name>/`).
3. If Local:
   - Delete `<workspace>\.agents\skills\<skill-name>/`.

---

## 6. Git Hygiene for `curated-skills`
Whenever modifications are made to the central `curated-skills` repository (for global additions, removals, or custom skill authoring):
- Run `git status` to check changes.
- Suggest or commit with a conventional commit message (e.g., `feat(skills): add <skill-name>`, `feat(custom): add <skill-name>`, or `chore(skills): remove <skill-name>`).
