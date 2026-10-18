# 🚀 My Agent Skills & Autonomous Skill Manager

> **A single source of truth to consolidate, version-control, and effortlessly synchronize all your AI agent skills across machines, projects, and coding assistants.**

A modular, lightweight, and cross-platform **Dotfiles & Management Framework** for AI coding agent skills ([Google Antigravity](https://antigravity.google), [Claude Code](https://claude.ai), [Cursor](https://cursor.com), [Windsurf](https://codeium.com/windsurf), Codex, etc.).

> 💡 **New here?** Read [**Real-World Scenarios & Everyday Workflows (`SCENARIOS.md`)**](./SCENARIOS.md) to see how this system automates your AI agent skills across machines, projects, and coding assistants without manual configuration.

---

### 🎯 The Core Purpose

This repository acts as your personal **central skill hub**:

* 📦 **Consolidate:** Bring all your external and custom skills together in one clean, lightweight manifest without bloating project repositories.
* 🔄 **Synchronize:** Keep your local AI agents continuously updated across tools in a single click or command.
* ☁️ **Backup & Portability:** Version-control your entire agent skillset to your own GitHub repository, so you can spin up your ideal AI workflow on any new machine instantly.
* 🧠 **Autonomous Management:** [`skill-manager`](./custom-skills/skill-manager/) empowers your AI assistant to fetch external skills from GitHub, generate custom skills, and manage installation scopes (Global vs. Local) automatically.

---

## ⚡ Quick Start

### 1. Installation

#### Method 1: Double-Click (Easiest - Windows)
Double-click **`install.bat`**. You will be guided through a simple 2-step setup:
1. **Target AI Environment:** Choose `[1] Auto-Detect and Sync ALL` (Recommended) or pick a specific tool.
2. **Installation Mode:** Choose `[1] Full Curated Pack` or `[2] Clean Slate`.

*(💡 **Quick Tip:** Pressing Enter twice automatically detects all installed AI agents and synchronizes your skills with zero configuration!).*

#### Method 2: Command Line / PowerShell
Run the installer via PowerShell:

```powershell
# Auto-detect all installed AI tools & synchronize:
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

> **✨ Zero-Config Auto-Location:**
> No matter where you clone this repository or what you name it, the installer (`install.bat` / `install.ps1`) automatically binds the repository's path into `skill-manager` (`repo-config.json`). You never need to manually edit configuration paths.

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
```

### 💾 Preference Persistence
The installer saves your chosen host selection (`targetHost`) in `repo-config.json`. Whenever `skill-manager` adds or authors skills in the future, it automatically respects your preference. You can change your preference at any time simply by re-running `install.bat` / `install.ps1` or telling your AI assistant.

---

## 📦 What's Inside

### 1. The Core Engine (Built-in)

| Skill | Role | Description |
| :--- | :--- | :--- |
| **`skill-manager`** | **Core Engine** | The autonomous brain of this repository. Allows your AI assistant to add, inspect, create, scope (Global vs. Local), and remove skills dynamically. |

### 2. External Skills

*(No external skills installed yet. Ask your AI agent to add any open-source skill from GitHub!)*

| Skill | Source | Description |
| :--- | :--- | :--- |
| *Empty* | *Add via agent* | *Run: "Add skill from https://github.com/..."* |

### 3. Custom / Personal Skills (`custom-skills/`)

Place your custom reusable skills in [`custom-skills/`](./custom-skills/):

| Skill | Author | Description |
| :--- | :--- | :--- |
| *Empty* | *You* | *Create custom skills in custom-skills/<name>/SKILL.md* |

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
│   └── skill-manager/          # 🧠 CORE ENGINE: Universal autonomous skill manager agent
│       └── SKILL.md
├── local-skills/               # 📦 Archive for project-specific local custom skills
│   └── .gitkeep
├── .gitignore                  # Git ignore rules for logs, temp files & OS metadata
├── LICENSE                     # MIT open-source license
├── README.md                   # Documentation, setup guides, and skills catalog
├── README.template.md          # 🧼 Clean starter documentation for Clean Slate mode
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

## 📄 License

This project is licensed under the [MIT License](./LICENSE). Feel free to use, fork, and adapt it for your own AI development workflows.
