---
name: push
description: Inspects project git changes, stages files, generates a conventional commit message in English, proposes the commit command, and pushes to GitHub.
---

# Git Commit & Push Workflow

When the user runs `/push` or requests to commit and push changes, execute the following workflow step-by-step:

## 1. Inspection & Safety Check (Do NOT ask for permission)
- Automatically run `git status` and `git diff` to inspect changes.
- If there are no changes (`working tree clean`), notify the user and stop execution.
- Check for sensitive or untracked files that should not be committed (e.g., `.env`, credentials, secret keys, build artifacts). Exclude them from staging and warn the user.

## 2. Staging (Do NOT ask for permission)
- Directly run `git add .` (or specific safe files) to stage all appropriate changes.

## 3. Invoke Commit Command (`git commit`)
- Craft a concise commit message adhering strictly to these rules:
  - **Always in English:** Write all commit messages strictly in English using the imperative mood (e.g., `feat: add ...`, `fix: resolve ...`).
  - **Conventional Types:**
    - `feat`: New feature or user-facing behavior
    - `fix`: Bug fix or correcting unintended UI/UX behavior
    - `refactor`: Code refactoring that neither fixes a bug nor adds a feature
    - `perf`: Performance improvement
    - `docs`: Documentation changes only
    - `build` / `ci`: Dependencies, build scripts, or CI/CD configurations
    - `chore`: Routine maintenance, tooling, or repository config
  - **Important Rule for UI/CSS:** Never use `style` for CSS or UI adjustments (`style` is strictly reserved for code formatting, whitespace, and linters). Use `fix` for UI fixes/cleanups and `feat` for new UI elements.
  - **Scope (Parentheses) Rule:** Use a scope (e.g., `fix(sidebar):`, `feat(auth):`) ONLY when changes are isolated to a single specific module or component. For broad, multi-component, or cross-cutting changes, omit the scope entirely (e.g., `fix:`, `feat:`).
  - **Commit Body (When Needed):**
    - For straightforward or routine changes: Use a single concise subject line (`git commit -m "<subject>"`).
    - For complex, multi-faceted, or architectural changes: Add a brief explanatory body using a second `-m` flag explaining the why/context (`git commit -m "<subject>" -m "<body explaining why/context>"`).
  - **Direct Tool Call:** Do NOT ask for permission in conversational chat text. Immediately propose the commit by invoking `git commit -m "<subject>"` (or with an additional `-m "<body>"` when appropriate) as a command tool call. (The IDE interface will present the interactive approval card to the user for one-click approval or editing).

## 4. Push to GitHub
- Immediately after the commit completes, run `git push` (or `git push -u origin <branch>` if the upstream tracking branch is not yet set).

## 5. Result Summary
- Briefly report the outcome to the user:
  - Commit hash and message
  - Target branch and push status
