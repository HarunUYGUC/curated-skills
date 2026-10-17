# 🚀 Curated Agent Skills

A lightweight, modular, and portable **Curated Skills (Dotfiles)** configuration repository for AI coding agents (Google Antigravity, Claude Code, Cursor, Windsurf, Codex, etc.).

Instead of bloating your GitHub repository with megabytes of duplicated files, this repository adopts a **Dotfiles / Manifest Architecture**:
* **External Skills:** Only source repository URLs and reference manifests are tracked in [`skills.json`](./skills.json).
* **Custom Skills:** Your own locally crafted skills live cleanly in [`custom-skills/`](./custom-skills/).
* **Automated Installation:** A single command or double-click downloads, configures, and synchronizes everything directly from upstream sources.

---

## ⚡ Quick Start

When setting up a new machine or refreshing your environment, choose either method:

### Method 1: Double-Click (Easiest)
Double-click the **`install.bat`** file in this directory. The installer will run automatically and display a summary of installed skills when finished.

### Method 2: Command Line / PowerShell
Run the following command in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

This script:
1. Parses [`skills.json`](./skills.json),
2. Clones full-repository skills (`ui-ux-pro-max`, `diagram-design`) at their latest revisions,
3. Extracts individual skills (`shipping-and-launch`, `security-and-hardening`, etc.) and their references without downloading full monorepos,
4. Automatically optimizes Windows file paths,
5. Copies your custom skills (`custom-skills/`) to your target agent configuration directory.

---

## 🌐 Installing to Different AI Tools

Because these skills follow the open **Agent Skills Standard**, they are 100% compatible across different AI coding environments. Specify your target directory as needed:

```powershell
# For Google Antigravity (Default):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "$HOME\.gemini\config\skills"

# For Claude Code (Global):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "$HOME\.claude\skills"

# For Cursor / Codex (Current Project Level):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir ".\.agents\skills"

# For Windsurf / OpenCode (Global):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "$HOME\.windsurf\skills"
```

*(Alternatively, edit `install.bat` and uncomment your preferred tool).*

---

## 📦 Included Skills

### 1. External Skills

| Skill | Author / Source | Description |
| :--- | :--- | :--- |
| **`ui-ux-pro-max`** | [nextlevelbuilder](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Design intelligence with 84 UI styles, 192 color palettes, 74 typography pairings, and 119 UX guidelines. |
| **`diagram-design`** | [cathrynlavery](https://github.com/cathrynlavery/diagram-design) | 35+ editorial and enterprise SVG/HTML architecture diagrams, data flows, and system blueprint templates. |
| **`shipping-and-launch`** | [addyosmani](https://github.com/addyosmani/agent-skills) | Pre-flight verification, staged rollouts (canary), and rollback planning before deploying to production. |
| **`security-and-hardening`** | [addyosmani](https://github.com/addyosmani/agent-skills) | OWASP Top 10, SQLi, XSS, secure authentication, and data leak prevention standards. |
| **`performance-optimization`**| [addyosmani](https://github.com/addyosmani/agent-skills) | Core Web Vitals (LCP, INP, CLS), N+1 query elimination, memory leak prevention, and speed tuning. |
| **`api-and-interface-design`** | [addyosmani](https://github.com/addyosmani/agent-skills) | REST, GraphQL, OpenAPI 3.1, and RFC 7807 compliant error handling and API contract architecture. |
| **`code-simplification`** | [addyosmani](https://github.com/addyosmani/agent-skills) | Simplifies complex logic for clarity and maintainability without altering runtime behavior. |

### 2. Custom Skills

| Skill | Location | Description |
| :--- | :--- | :--- |
| **`push`** | [`custom-skills/push/`](./custom-skills/push/) | Inspects git changes, crafts conventional commits in English, and pushes to GitHub. |

---

## ➕ How to Add New Skills

### A. Adding an External Skill from GitHub:
Add an entry to the `external` array in [`skills.json`](./skills.json):

```json
{
  "name": "skill-name",
  "author": "github-username",
  "repo": "https://github.com/username/repo",
  "type": "git-clone",
  "description": "Short description of what the skill does..."
}
```
Then run `install.bat` (or `.\install.ps1`).

### B. Creating a Custom Skill:
1. Create a new directory under `custom-skills/`: e.g. `custom-skills/my-skill/`
2. Add your `SKILL.md` file inside that folder.
3. *(Optional)* Add its name and description to the `custom` list in `skills.json` to keep your catalog updated.
4. Run `install.bat` (or `.\install.ps1`). The installer will automatically detect all directories in `custom-skills/` and install them.

---

## 🌟 Credits and Attribution

All credit for external skills belongs to their respective original authors:
* **Addy Osmani** ([@addyosmani](https://github.com/addyosmani))
* **NextLevelBuilder** ([@nextlevelbuilder](https://github.com/nextlevelbuilder))
* **Cathryn Lavery** ([@cathrynlavery](https://github.com/cathrynlavery))
