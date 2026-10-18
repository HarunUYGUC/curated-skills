# 🚀 Curated Agent Skills & Autonomous Skill Manager

> **A single source of truth to consolidate, version-control, and effortlessly synchronize all your AI agent skills across machines, projects, and coding assistants.**

A modular, lightweight, and cross-platform **Dotfiles & Management Framework** for AI coding agent skills ([Google Antigravity](https://antigravity.google), [Claude Code](https://claude.ai), [Cursor](https://cursor.com), [Windsurf](https://codeium.com/windsurf), Codex, etc.).

> 💡 **New here?** Read [**Real-World Scenarios & Everyday Workflows (`SCENARIOS.md`)**](./SCENARIOS.md) to see how this system automates your AI agent skills across machines, projects, and coding assistants without manual configuration.

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
  git clone https://github.com/<your-username>/<your-repo-name>.git curated-skills
  cd curated-skills
  ```
* **Option B:** Clone this repository directly:
  ```bash
  git clone https://github.com/HarunUYGUC/curated-skills.git
  cd curated-skills
  ```

> **✨ Zero-Config Auto-Location:**
> No matter where you clone this repository or what you name it (e.g., `C:\tools\my-skills` or `~/dotfiles/agent-skills`), the installer (`install.bat` / `install.ps1`) automatically binds the repository's path into `skill-manager` (`repo-config.json`). You never need to manually edit configuration paths.

---

### 2. Choose Your Installation Mode

When running the installer, choose between two modes:

| Mode | What it Installs | Best For |
| :--- | :--- | :--- |
| **`[1] Full Curated Pack`** *(Recommended)* | Core `skill-manager` + 8 Curated External Skills + Custom Utilities | Getting a fully loaded, production-ready agent toolkit out of the box. |
| **`[2] Clean Slate`** *(Empty Template)* | Core `skill-manager` engine **only** (initializes clean `skills.json` from `skills.template.json`) | Starting with a clean canvas to curate and build your own private skills catalog. |

#### Method 1: Double-Click (Easiest - Windows)
Double-click **`install.bat`**. You will be guided through a simple 2-step setup:
1. **Target AI Environment:** Choose `[1] Auto-Detect & Sync ALL` (Recommended) or pick a specific tool (Antigravity, Claude, Cursor, Windsurf).
2. **Installation Mode:** Choose `[1] Full Curated Pack` or `[2] Clean Slate`.

*(💡 **Quick Tip:** Pressing Enter twice automatically detects all installed AI agents and installs the full pack to all of them with zero configuration!).*

#### Method 2: Command Line / PowerShell
Run the installer via PowerShell:

```powershell
# Auto-detect all installed AI tools & install Full Pack (Default):
powershell -ExecutionPolicy Bypass -File .\install.ps1

# Clean Slate on all detected AI tools:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -CleanTemplate
```

> **🛡️ Safety Confirmation Guard:**
> Whenever **Clean Slate** is selected, the installer will always ask for explicit confirmation (`[y/N]`) before resetting `skills.json` and `README.md`, removing extra custom/local skills from the repository, and pruning curated skills from your AI hosts. Any independent skills you installed outside of this repository are safely preserved. (To bypass the prompt in automated scripts, pass `-Force`).

---

## 🌐 Multi-Agent Auto-Detection & Cross-Sync

Because all skills adhere to the open **Agent Skills Standard**, the installer automatically scans your machine for installed AI coding assistants and synchronizes all of them simultaneously:

* 🤖 **Google Antigravity:** `$HOME\.gemini\config\skills\`
* 🧠 **Claude Code:** `$HOME\.claude\skills\`
* ⚡ **Cursor / Codex:** `$HOME\.cursor\skills\` (or `.\.agents\skills`)
* 🌊 **Windsurf / OpenCode:** `$HOME\.windsurf\skills\`

### ⚡ Smart Single-Download Replicator
When multiple AI tools are detected, external skills are downloaded **only once** from GitHub to the primary target, then replicated to all other agent environments locally in milliseconds. Zero wasted bandwidth, zero duplicate cloning!

```powershell
# Auto-detect all installed AI tools (Default):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice auto

# Target a specific AI host directly:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice gemini    # Google Antigravity
powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice claude    # Claude Code
powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice cursor    # Cursor
powershell -ExecutionPolicy Bypass -File .\install.ps1 -HostChoice windsurf  # Windsurf

# Or specify an explicit target directory:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -TargetDir "C:\path\to\skills"
```

### 💾 Preference Persistence
The installer saves your chosen host selection (`targetHost`) in `repo-config.json`. Whenever `skill-manager` adds or authors skills in the future, it automatically respects your preference. You can change your preference at any time simply by re-running `install.bat` / `install.ps1` or telling your AI assistant.

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
| **`ci-cd-and-automation`** | [addyosmani](https://github.com/addyosmani/agent-skills) | Automates CI/CD pipeline setup, quality gates, test runners, and deployment strategies. |

### 3. Custom / Personal Skills (`custom-skills/`)

Place your own reusable custom skills in [`custom-skills/`](./custom-skills/):

| Skill | Author | Description |
| :--- | :--- | :--- |
| **`git-summary`** | [HarunUYGUC](https://github.com/HarunUYGUC) | Transforms raw git commits and working tree status into a sleek, copy-paste ready daily standup summary. |
| **`push`** | [HarunUYGUC](https://github.com/HarunUYGUC) | Bundled sample utility that inspects git changes, crafts conventional commit messages in English, and pushes to GitHub. |

### 4. Cataloged Local Skills (`skills.json -> local` & `local-skills/`)

A personal registry and archive for project-specific skills that you do **not** want installed globally:

> 🛡️ **The Two Guarantees for Local Skills:**
> 1. **Opt-In Archiving Only:** A local skill in your project workspace is **NEVER** added to `skills.json` or `local-skills/` unless you explicitly tell your agent: *"Archive / bookmark this local skill"*. Your private project tools will never accidentally leak into your central dotfiles.
> 2. **Zero Auto-Installation:** Even when cataloged in `skills.json`, local skills are **NEVER** installed globally or into new projects during `install.bat` / `install.ps1`. They are strictly on-demand—only installed when you explicitly say: *"Restore / install cataloged local skill <name> into this project"*.

* **Zero Global Bloat**: Keeps your global AI context clean and focused only on universal workflows.
* **Archived Bespoke Skills (`local-skills/`)**: Custom workflows built for specific projects are safely archived in `local-skills/` so they are version-controlled and never lost.
* **On-Demand Restore**: While working in any project, simply ask your agent to pull a cataloged local skill directly into `<workspace>/.agents/skills/`.

| Skill | Project | Path / Source | Description |
| :--- | :--- | :--- | :--- |
| *None yet* | *Project Name* | *local-skills/<name> or https://github.com/...* | *Ask your agent to bookmark project-specific skills here.* |

---

## 📂 Repository Structure

```text
curated-skills/
├── custom-skills/              # Workspace for your globally installed custom skills
│   ├── git-summary/            # 📊 Standup summary & dev activity aggregator
│   │   └── SKILL.md
│   ├── push/                   # Bundled utility: Autonomous conventional commit & push
│   │   └── SKILL.md
│   └── skill-manager/          # 🧠 CORE ENGINE: Universal autonomous skill manager agent
│       └── SKILL.md
├── local-skills/               # 📦 Archive for project-specific local custom skills
│   └── .gitkeep
├── .gitignore                  # Git ignore rules for logs, temp files & OS metadata
├── LICENSE                     # MIT open-source license
├── README.md                   # Documentation, setup guides, and skills catalog
├── README.template.md          # 🧼 Clean starter documentation for Clean Slate initialization
├── SCENARIOS.md                # 💡 Real-world usage scenarios & everyday workflows
├── install.bat                 # ⚡ Double-click interactive launcher for Windows
├── install.ps1                 # 🚀 Cross-platform installation & synchronization engine
├── skills.json                 # 📋 Active manifest: Tracks curated, custom & local skills
└── skills.template.json        # 🧼 Empty starter template for Clean Slate initialization
```

---

## 🤖 Using `skill-manager` with Your Agent

Once installed, you don't need to manually edit config files. Simply speak to your AI agent:

* *"Add the GitHub skill from `https://github.com/user/my-skill`"*
* *"Create a new skill for summarizing Kubernetes deployment logs"*
* *"Save / bookmark this project's local skill to my central curated repository"*
* *"Install the cataloged local skill 'stripe-flow' into this project"*
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
