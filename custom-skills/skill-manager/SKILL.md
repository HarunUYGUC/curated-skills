---
name: skill-manager
description: Manages the curated-skills repository. Use when adding an external skill from GitHub, creating a new custom skill, removing an existing skill, or synchronizing skills to local AI agent environments.
---

# Skill Manager Workflow

This skill automates the lifecycle management of skills within the `curated-skills` repository (`C:\Users\harun\Documents\antigravity\curated-skills`).

## Workspaces & Locations
- **Curated Repository:** `C:\Users\harun\Documents\antigravity\curated-skills`
- **Global Skills Directory:** `C:\Users\harun\.gemini\config\skills` (or `$HOME\.gemini\config\skills`)
- **Manifest File:** `curated-skills/skills.json`
- **Documentation:** `curated-skills/README.md`
- **Custom Skills Directory:** `curated-skills/custom-skills`

---

## 1. Adding an External Skill from GitHub

Trigger: The user provides a GitHub repository URL or asks to add an existing skill from the internet.

### Step 1: Inspect & Classify
1. Fetch and inspect the repository:
   - **Type A (`git-clone`):** The repository itself is a standalone, dedicated skill (contains `SKILL.md` at its root or represents a single package like `ui-ux-pro-max` or `diagram-design`).
   - **Type B (`github-extract`):** The repository is a monorepo or collection containing multiple skills (like `addyosmani/agent-skills`). Identify the specific `subpath` (e.g. `skills/<skill-name>`).
2. Read the target `SKILL.md` to extract:
   - `name`: exact skill name identifier.
   - `author`: GitHub owner / author username.
   - `description`: 1-sentence concise summary in English.
   - `references`: Check if the skill references external checklist files (e.g. in `references/`).

### Step 2: Update `skills.json`
Add the new skill object to the `skills.external` array in `skills.json`:

```json
{
  "name": "<skill-name>",
  "author": "<github-author>",
  "repo": "https://github.com/<owner>/<repo>",
  "subpath": "<optional-subpath>",
  "type": "git-clone" | "github-extract",
  "references": ["<optional-reference-files>"],
  "description": "<concise-english-description>"
}
```

### Step 3: Update `README.md`
Add a new row to the **1. External Skills** table in `README.md`:

```markdown
| **`<skill-name>`** | [<author>](https://github.com/<owner>/<repo>) | <description> |
```

### Step 4: Install & Verify
1. Run `install.bat` (or execute `install.ps1`) to download the skill and verify clean installation into the global directory.
2. Verify that the skill appears in `C:\Users\harun\.gemini\config\skills\<skill-name>\SKILL.md`.

---

## 2. Creating a New Custom Skill

Trigger: The user asks to write, generate, or build a new custom skill for their personal workflow.

### Step 1: Author the Skill
1. Create a dedicated folder: `curated-skills/custom-skills/<skill-name>/`.
2. Write `SKILL.md` following Agent Skills best practices:
   - Valid YAML frontmatter with `name` and `description` (clearly defining *when* and *why* it triggers).
   - Clear operational rules, checklists, and progressive disclosure links.
   - Verification steps.

### Step 2: Register in `skills.json`
Add an entry to the `skills.custom` array in `skills.json`:

```json
{
  "name": "<skill-name>",
  "author": "harun (local)",
  "path": "custom-skills/<skill-name>",
  "description": "<concise-english-description>"
}
```

### Step 3: Update `README.md`
Add a row to the **2. Custom Skills** table in `README.md`:

```markdown
| **`<skill-name>`** | [`custom-skills/<skill-name>/`](./custom-skills/<skill-name>/) | <description> |
```

### Step 4: Synchronize
Copy the new skill directory to `C:\Users\harun\.gemini\config\skills\<skill-name>` so it is immediately active in the current AI environment.

---

## 3. Removing a Skill

Trigger: The user asks to remove, delete, or uninstall a skill.

1. Remove the skill entry from `skills.json`.
2. Remove the row from `README.md`.
3. If it is a custom skill, delete `curated-skills/custom-skills/<skill-name>/`.
4. Remove the skill folder from the global directory: `C:\Users\harun\.gemini\config\skills\<skill-name>`.

---

## 4. Git Hygiene
After performing additions, modifications, or removals in the `curated-skills` repository:
- Run `git status` to verify staged/unstaged changes.
- Propose or execute a clean conventional commit (e.g. `feat(skills): add <skill-name>`, `feat(custom): add <skill-name>`, or `chore(skills): remove <skill-name>`).
