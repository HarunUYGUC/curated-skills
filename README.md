# 🚀 Curated Agent Skills & Autonomous Skill Manager

> **A single source of truth to consolidate, version-control, and effortlessly synchronize all your AI agent skills across machines, projects, and coding assistants.**

A modular, lightweight, and cross-platform **Dotfiles & Management Framework** for AI coding agent skills ([Google Antigravity](https://antigravity.google), [Claude Code](https://claude.ai), [Cursor](https://cursor.com), [Windsurf](https://codeium.com/windsurf), Codex, etc.).

---

### 🎯 The Core Purpose

AI coding skills often end up scattered across different machines, outdated over time, or lost across project directories. This repository acts as your **central skill hub**:

* 📦 **Consolidate:** Bring all your external and custom skills together in one clean, lightweight manifest without bloating repos.
* 🔄 **Synchronize:** Keep your local AI agents continuously updated with upstream sources in a single click or command.
* ☁️ **Backup & Portability:** Version-control your entire agent skillset to your own GitHub repository, so you can spin up your ideal AI workflow on any new machine instantly.
* 🧠 **Autonomous Management:** [`skill-manager`](./custom-skills/skill-manager/) empowers your AI assistant to fetch external skills from GitHub, generate custom skills, and manage installation scopes (Global vs. Local) automatically.

---

## ⚡ Quick Start

### 1. Get the Repository

To back up and version-control your own skills to GitHub:

* **Option A (Recommended):** Click **"Use this template"** at the top of this repository to create your own personal repository (e.g. `yourname/my-skills`), then clone it:
  ```bash
  git clone https://github.com/<your-username>/<your-repo-name>.git "$HOME/Documents/antigravity/curated-skills"
  cd "$HOME/Documents/antigravity/curated-skills"
  ```
* **Option B:** Clone this repository directly:
  ```bash
  git clone https://github.com/HarunUYGUC/curated-skills.git "$HOME/Documents/antigravity/curated-skills"
  cd "$HOME/Documents/antigravity/curated-skills"
  ```

> **💡 Custom Directory / Repo Name Note:**
> Whether you use this template or clone directly, if you place your repository in a custom folder or choose a different repository name (e.g., `C:\tools\my-skills` or `~/dotfiles/agent-skills`), open [`custom-skills/skill-manager/SKILL.md`](./custom-skills/skill-manager/SKILL.md) and update the **`Central Curated Repository:`** line with your custom path. This ensures `skill-manager` can always locate your central catalog from within any project workspace.

---

### 2. Choose Your Installation Mode

When running the installer, choose between two modes:

| Mode | What it Installs | Best For |
| :--- | :--- | :--- |
| **`[1] Full Curated Pack`** *(Recommended)* | Core `skill-manager` + 7 Curated External Skills + `push` | Getting a fully loaded, production-ready agent toolkit out of the box. |
| **`[2] Clean Slate`** *(Empty Template)* | Core `skill-manager` engine **only** (initializes clean `skills.json` from `skills.template.json`) | Starting with a clean canvas to curate and build your own private skills catalog. |

#### Method 1: Double-Click (Easiest - Windows)
Double-click **`install.bat`**. You will be prompted to select **[1] Full Curated Pack** or **[2] Clean Slate**.

#### Method 2: Command Line / PowerShell
Run the installer via PowerShell:

```powershell
# Mode 1: Full Curated Pack (Default)
powershell -ExecutionPolicy Bypass -File .\install.ps1

# Mode 2: Clean Slate (Empty Template)
powershell -ExecutionPolicy Bypass -File .\install.ps1 -CleanTemplate
```

> **🛡️ Safety Confirmation Guard:**
> Whenever **Clean Slate** is selected, the installer will always ask for explicit confirmation (`[y/N]`) before resetting `skills.json`. This ensures you never accidentally wipe out custom skills you have added over time. (To bypass the prompt in automated scripts, pass `-Force`).

---

## 🌐 Multi-Agent Compatibility

Because all skills adhere to the open **Agent Skills Standard**, you can install them to any supported AI host by passing `-TargetDir`:

```powershell
# Google Antigravity (Default):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "$HOME\.gemini\config\skills"

# Claude Code (Global):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "$HOME\.claude\skills"

# Cursor / Codex (Project-Level):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir ".\.agents\skills"

# Windsurf / OpenCode (Global):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "$HOME\.windsurf\skills"
```

*(You can also edit `install.bat` and uncomment your preferred AI tool).*

---

## 📦 What's Inside

### 1. The Core Engine (Built-in)

| Skill | Role | Description |
| :--- | :--- | :--- |
| **`skill-manager`** | **Core Engine** | The autonomous brain of this repository. Allows your AI assistant to add, inspect, create, scope (Global vs. Local), and remove skills dynamically. |

### 2. Curated External Skills (Optional / Full Pack)

| Skill | Source | Description |
| :--- | :--- | :--- |
| **`ui-ux-pro-max`** | [nextlevelbuilder](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Design intelligence with 84 UI styles, 192 color palettes, 74 typography pairings, and 119 UX guidelines. |
| **`diagram-design`** | [cathrynlavery](https://github.com/cathrynlavery/diagram-design) | 35+ editorial and enterprise SVG/HTML architecture diagrams, data flows, and system blueprints. |
| **`shipping-and-launch`** | [addyosmani](https://github.com/addyosmani/agent-skills) | Pre-flight verification, staged rollouts (canary), and rollback planning before deploying to production. |
| **`security-and-hardening`** | [addyosmani](https://github.com/addyosmani/agent-skills) | OWASP Top 10, SQLi, XSS, secure authentication, and data leak prevention standards. |
| **`performance-optimization`**| [addyosmani](https://github.com/addyosmani/agent-skills) | Core Web Vitals (LCP, INP, CLS), N+1 query elimination, memory leak prevention, and speed tuning. |
| **`api-and-interface-design`** | [addyosmani](https://github.com/addyosmani/agent-skills) | REST, GraphQL, OpenAPI 3.1, and RFC 7807 compliant error handling and API contracts. |
| **`code-simplification`** | [addyosmani](https://github.com/addyosmani/agent-skills) | Simplifies complex logic for clarity and maintainability without altering runtime behavior. |

### 3. Custom / Personal Skills (`custom-skills/`)

The [`custom-skills/`](./custom-skills/) directory is your personal workspace:
* **`push`**: A bundled sample utility that inspects git changes, crafts conventional commit messages in English, and pushes to GitHub. (Keep it or replace it with your own workflows!).
* **Your Own Skills**: Place any new custom skill directories inside `custom-skills/`. The installer will automatically discover and install them.

---

## 📂 Repository Structure

```text
curated-skills/
├── custom-skills/              # Workspace for your personal custom skills
│   ├── push/                   # Bundled utility: Autonomous conventional commit & push
│   │   └── SKILL.md
│   └── skill-manager/          # 🧠 CORE ENGINE: Universal autonomous skill manager agent
│       └── SKILL.md
├── .gitignore                  # Git ignore rules for logs, temp files & OS metadata
├── LICENSE                     # MIT open-source license
├── README.md                   # Documentation, setup guides, and skills catalog
├── install.bat                 # ⚡ Double-click interactive launcher for Windows
├── install.ps1                 # 🚀 Cross-platform installation & synchronization engine
├── skills.json                 # 📋 Active manifest: Tracks curated & custom skills
└── skills.template.json        # 🧼 Empty starter template for Clean Slate initialization
```

---

## 🤖 Using `skill-manager` with Your Agent

Once installed, you don't need to manually edit config files. Simply speak to your AI agent:

* *"Add the GitHub skill from `https://github.com/user/my-skill`"*
* *"Create a new skill for summarizing Kubernetes deployment logs"*
* *"Remove the diagram-design skill"*

The `skill-manager` will prompt you for the desired scope (**Global** for all projects or **Local** for the current workspace) and handle installation automatically.

---

## 🌟 Credits and Attribution

All credit for external skills belongs to their respective original authors:
* **Addy Osmani** ([@addyosmani](https://github.com/addyosmani))
* **NextLevelBuilder** ([@nextlevelbuilder](https://github.com/nextlevelbuilder))
* **Cathryn Lavery** ([@cathrynlavery](https://github.com/cathrynlavery))

---

## 📄 License

This project is licensed under the [MIT License](./LICENSE). Feel free to use, fork, and adapt it for your own AI development workflows.
