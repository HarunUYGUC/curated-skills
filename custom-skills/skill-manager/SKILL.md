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

- **Central Curated Repository & Sync Preferences (`repo-config.json`):**
  Check `repo-config.json` inside `skill-manager`'s own directory:
  - `repoPath`: The absolute path to the repository root.
  - `targetHost`: The user's persisted sync target (`"auto"`, `"gemini"`, `"claude"`, `"cursor"`, `"windsurf"`). Defaults to `"auto"` if omitted.
  
  Resolution order for repository root:
  1. **Auto-Detected Configuration (`repo-config.json`):** Check if `repo-config.json` exists in `skill-manager`'s own folder. Read `repoPath` (automatically written by `install.ps1`).
  2. **Environment Variable:** Check `$env:CURATED_SKILLS_DIR` if set.
  3. **Default Location:** Check `$HOME/Documents/antigravity/curated-skills`.
  4. **Dynamic Discovery:** Search `$HOME` for a directory containing `skills.json` and `skills.template.json`.
  - Manifest: `<repo-root>/skills.json`
  - Documentation: `<repo-root>/README.md`
  - Custom skills source: `<repo-root>/custom-skills/`

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
  3. Synchronize by executing `install.ps1` with the user's preferred `targetHost`:
     ```powershell
     # Read targetHost from repo-config.json (defaults to 'auto' if omitted):
     powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice <targetHost>
     ```
     *(Do NOT run interactive `install.bat` inside automated agent sessions to avoid blocking prompts).*
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
  4. Synchronize across preferred host(s) simultaneously:
     ```powershell
     # Read targetHost from repo-config.json (defaults to 'auto' if omitted):
     powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice <targetHost>
     ```
     *(This automatically copies the new custom skill and replicates it according to targetHost at local SSD speed).*
- **If Local:**
  1. Save directly to `<workspace>\.agents\skills\<skill-name>\SKILL.md`.

---

## 5. Removing a Skill

Trigger: User requests to remove or delete a skill.

1. Determine where the skill is located:
   - **Global Skill:** Registered in `curated-skills` (`skills.external` or `skills.custom`) and installed on global hosts.
   - **Cataloged Local Skill:** Bookmarked in `curated-skills` (`skills.local.external` or `skills.local.custom`).
   - **Workspace Local Skill:** Active inside `<workspace>/.agents/skills/<skill-name>/` (or `<workspace>/.claude/skills/`).

2. **If Global:**
   - Remove entry from `curated-skills/skills.json` under `skills.external` or `skills.custom`.
   - Remove row from `curated-skills/README.md`.
   - If custom, delete `curated-skills/custom-skills/<skill-name>/`.
   - Delete from all installed AI host directories (e.g., `~/.gemini/config/skills/<skill-name>/`, `~/.claude/skills/<skill-name>/`, `~/.cursor/skills/<skill-name>/`, `~/.windsurf/skills/<skill-name>/`).

3. **If Cataloged Local Skill (Removing from Central Archive):**
   - Remove entry from `curated-skills/skills.json` under `skills.local.external` or `skills.local.custom`.
   - Remove row from `curated-skills/README.md` (if listed in cataloged table).
   - If custom, delete `curated-skills/local-skills/<skill-name>/`.

4. **If Workspace Local Skill:**
   - Delete `<workspace>/.agents/skills/<skill-name>/` (or `<workspace>/.claude/skills/<skill-name>/`).

---

## 6. Cataloging & Archiving Local Skills to Central Repository

Trigger: User in a workspace requests to catalog, register, or archive a local skill to the central repository (e.g., *"Save / bookmark this project's local skill to central repository"*, *"Archive this local skill to curated-skills"*).

### Step 1: Locate Local Skill
1. Identify the skill folder inside `<workspace>/.agents/skills/<skill-name>/` (or `<workspace>/.claude/skills/<skill-name>/`).
2. Read `SKILL.md` to extract name, description, and origin.

### Step 2: Register in Central Repository
- **If External (originates from an upstream GitHub repository):**
  1. Add an entry to `curated-skills/skills.json` under `skills.local.external`:
     ```json
     {
       "name": "<name>",
       "project": "<project-name-or-context>",
       "author": "<author>",
       "repo": "https://github.com/<owner>/<repo>",
       "subpath": "<optional-subpath>",
       "type": "git-clone" | "github-extract",
       "references": ["<optional-reference-files>"],
       "description": "<concise-summary>"
     }
     ```
  2. Add a row to the **4. Cataloged Local Skills** table in `curated-skills/README.md`:
     `| **<name>** | <project> | <repo-url> | <description> |`

- **If Custom (project-specific bespoke workflow):**
  1. Copy the skill directory from `<workspace>/.agents/skills/<skill-name>/` to `curated-skills/local-skills/<skill-name>/`.
  2. Add an entry to `curated-skills/skills.json` under `skills.local.custom`:
     ```json
     {
       "name": "<name>",
       "project": "<project-name-or-context>",
       "author": "<author>",
       "path": "local-skills/<name>",
       "description": "<concise-summary>"
     }
     ```
  3. Add a row to the **4. Cataloged Local Skills** table in `curated-skills/README.md`:
     `| **<name>** | <project> | local-skills/<name> | <description> |`

*(Note: Cataloged local skills are NEVER installed during global `install.bat` / `install.ps1` runs. They remain safely archived for on-demand project use).*

---

## 7. Restoring / Installing a Cataloged Local Skill to Current Workspace

Trigger: User in a project workspace requests to install a previously cataloged local skill (e.g., *"Install cataloged local skill '<name>' into this project"*, *"Restore local skill '<name>' from central repository"*).

1. Search `curated-skills/skills.json` under `skills.local.external` and `skills.local.custom` for `<name>`.
2. Target directory is `<workspace>/.agents/skills/<name>/` (or `<workspace>/.claude/skills/<name>/` for Claude Code).
3. If found in `skills.local.external`:
   - Download or clone directly into `<workspace>/.agents/skills/<name>/`.
4. If found in `skills.local.custom`:
   - Copy from `curated-skills/local-skills/<name>/` to `<workspace>/.agents/skills/<name>/`.
5. Confirm to the user that the skill is now active locally in this workspace without modifying any global AI host directories.

---

## 8. Switching Target Host Preference

Trigger: User requests to change their default target AI host (e.g., *"Switch sync mode to auto"*, *"Only sync to Antigravity from now on"*, *"Change skill manager target to Claude Code"*).

1. Read `repo-config.json` in `skill-manager`'s directory.
2. Update `targetHost` to the requested value (`auto`, `gemini`, `claude`, `cursor`, `windsurf`).
3. Re-run `install.ps1` with the new target:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice <targetHost>
   ```
4. Confirm to the user that the preference was updated and synchronizations applied.

---

## 9. Git Hygiene & GitHub Sync Call-to-Action

Whenever modifications are made to the central `curated-skills` repository (e.g., adding a global skill, creating a custom skill, cataloging a local skill, or removing a skill):

1. **Inspect Git Changes:**
   - Run `git status` inside the central curated repository to verify all staged and unstaged files.

2. **Mandatory End-of-Response Confirmation Prompt:**
   - Always append a polite, low-friction confirmation prompt at the very end of your final response:
     > 💡 **GitHub Backup:** Would you like me to commit and push these central repository changes to GitHub? Just reply with **"Yes"**, **"Do it"**, or **"Push"**.
     *(If communicating in Turkish: `💡 **GitHub Senkronizasyonu:** Bu değişiklikleri merkezi GitHub reponuza yedeklememi (commit & push) ister misiniz? Sadece **"Yap"**, **"Evet"** veya **"Push"** demeniz yeterlidir.`)*

3. **Autonomous Execution Upon User Confirmation:**
   - When the user replies with a confirmation (e.g., *"yes"*, *"do it"*, *"yap"*, *"push"*):
     - Stage the files: `git add .`
     - Commit with a clear conventional commit message in English:
       - `feat(skills): add <skill-name>`
       - `feat(custom): add <skill-name>`
       - `feat(local): catalog <skill-name> from <project>`
       - `chore(skills): remove <skill-name>`
     - Push to remote: `git push origin main`
     - Briefly report the commit hash and confirmation to the user.
