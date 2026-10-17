---
name: git-summary
description: Generates clean, human-readable daily standup summaries, developer activity reports, and git status recaps. Triggers on requests like "Bugün neler yaptım", "Standup için günlük özet ver", "Son 24 saatteki commit'leri toparla", "What did I work on today?", or whenever the user requests a summary of recent commits and work.
---

# Git Daily Standup & Activity Summary Workflow

When the user asks for a daily development summary, standup recap, or an overview of recent work, execute the following workflow step-by-step:

---

## 1. Git Data Collection (Background Inspection)

Silently inspect the git repository state in the background without prompting for confirmation:

1. **Identify Git User & Author:**
   - Run `git config user.name` and `git config user.email` to determine the user identity.

2. **Fetch Completed Commits for Today:**
   - Execute:
     ```bash
     git log --since="midnight" --author="$(git config user.name)" --no-merges --oneline
     ```
   - **Bulletproof Fallback Strategy:**
     - *Encoding / Author Mismatch Fallback:* If filtering by author returns empty results (e.g. non-ASCII characters or email was used in commits), try filtering by email or run without author filter:
       ```bash
       git log --since="midnight" --author="$(git config user.email)" --no-merges --oneline
       ```
       *(or simply `git log --since="midnight" --no-merges --oneline` in single-contributor or current branch context)*
     - *No Commits Today Fallback:* If there are no commits since midnight (e.g., late-night development, weekend work, or early morning standup before starting the day), inspect recent activity:
       ```bash
       git log --since="24 hours ago" --no-merges --oneline
       ```
       *(If still empty, retrieve the latest 5 commits: `git log -n 5 --no-merges --oneline`)*

3. **Inspect Working Tree (In-Progress Work):**
   ```bash
   git status -s
   ```
   - Identifies uncommitted modifications (`M`), staged changes (`A`), deletions (`D`), and new untracked files (`??`).

4. **Inspect Branch & Remote Sync Status:**
   ```bash
   git status -sb
   ```
   - Checks the current branch name and whether local commits are ahead/behind the upstream tracking branch (e.g. `## main...origin/main [ahead 1]`).

---

## 2. Intelligent Synthesis & Grouping

Never output raw, unformatted git logs. Synthesize the collected data into a cohesive, professional developer digest:

1. **✅ Tamamlanan İşler (Done):**
   - Translate commit messages into clear, human-readable bullet points matching the user's language (Turkish if prompted in Turkish, or English).
   - Group related commits together (e.g., multiple doc fixes or iterative styling refactorings into a single cohesive bullet).
   - Highlight the business value, modules affected, and major improvements.

2. **⏳ Üzerinde Çalışılanlar (In Progress):**
   - Translate modified/untracked files into the actual features, fixes, or documentation currently being developed.
   - If the working directory is clean, clearly state that there are no pending changes.

3. **📌 Sonraki Adımlar / Notlar (Next Steps):**
   - Identify pending tasks derived from active working tree changes, unpushed branches, or logical follow-up tasks.

4. **🚀 Durum (Status):**
   - Summarize the current sync state (e.g., "Kodlar GitHub'a pushlandı, testler başarılı", "1 commit push bekliyor", or "Temiz çalışma dizini").

---

## 3. Output Presentation (Standup Format)

Present the summary in a sleek, beautifully formatted markdown block that is immediately ready to copy-paste into Slack, Microsoft Teams, WhatsApp, or agile standup meetings.

### Format Template:

> 📋 **Günlük Geliştirme Özeti (<Tarih / Date>)**
> 
> ✅ **Tamamlanan İşler:**
> * <Açık ve anlaşılır özet 1>
> * <Açık ve anlaşılır özet 2>
> 
> ⏳ **Üzerinde Çalışılanlar:**
> * <Şu anda üzerinde çalışılan dosya veya modül özeti>
> 
> 📌 **Sonraki Adımlar:**
> * <Varsa planlanan veya devam eden adım>
> 
> 🚀 **Durum:** <GitHub/Remote sync durumu, örn: "Kodlar GitHub'a pushlandı, testler başarılı" veya "1 commit push bekliyor">
