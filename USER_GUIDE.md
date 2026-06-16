# Langent MCP — Complete Beginner's Guide

> This guide is written for people who are **almost completely new to computers, smartphones, messengers, and AI**.
> It's okay if you don't know a word — everything is **spelled out** below.
> Just follow it one line at a time, top to bottom. Don't skip steps.

<div align="right">
  <a href="./USER_GUIDE.md">🇺🇸 English Guide</a> &nbsp;|&nbsp; <a href="./사용설명서.md">🇰🇷 한국어 가이드</a>
</div>

> 📄 If you just want a quick summary/reference, see **[README.md](./README.md)** (English) / **[README.ko.md](./README.ko.md)** (Korean). This document is a much more detailed **step-by-step, hand-holding manual**.

---

## 📖 How to read this guide (please read first)

- Read it **in order**: 1 → 2 → 3 … Skipping around may get you stuck.
- Don't panic if you see **English (or Korean)** on screen — this guide tells you "if you see this message, do this."
- Stuck? Jump to [**13. Troubleshooting**](#13-troubleshooting-all-errors) and [**14. FAQ**](#14-frequently-asked-questions-faq).
- **This program is safe.** It won't break your other programs or your system. ([12. Safety & Privacy](#12-safety--privacy))

### Table of Contents

| # | Title | One line |
|---|---|---|
| 1 | [What does this program do?](#1-what-does-this-program-do) | Explained with an analogy |
| 2 | [Words to know first (glossary)](#2-words-to-know-first-glossary) | Plain meanings |
| 3 | [Prerequisites checklist](#3-prerequisites-checklist) | What you need first |
| 4 | [Step 1 · Install Python](#4-step-1--install-python-required-programs) | Just once |
| 5 | [Step 2 · Download the kit](#5-step-2--download-the-kit) | Get the files |
| 6 | [Step 3 · Install (INSTALL.bat)](#6-step-3--install-installbat) | First install |
| 7 | [Step 4 · Add docs & run (RUN.bat)](#7-step-4--add-documents--run-runbat) | The main screen |
| 8 | [Menus 0–8 explained](#8-menus-0-to-8-explained-nothing-left-out) | What each does |
| 9 | [Real usage scenarios](#9-real-usage-scenarios-workflows) | Follow along |
| 10 | [Connect to AI tools (MCP)](#10-connect-to-ai-tools-mcp-setup) | Claude, Cursor, etc. |
| 11 | [Where files & docs live](#11-where-files--documents-live) | Location summary |
| 12 | [Safety & privacy](#12-safety--privacy) | Don't worry |
| 13 | [Troubleshooting](#13-troubleshooting-all-errors) | When stuck |
| 14 | [FAQ](#14-frequently-asked-questions-faq) | Common questions |
| 15 | [Update & uninstall](#15-update--uninstall) | Updating / removing |
| 16 | [Command reference (advanced)](#16-command-reference-advanced-optional) | Optional |

---

## 1. What does this program do?

**Langent** is a free program that turns the documents scattered on your computer (notes, PDFs, reports)
into a **"knowledge vault" that AI can read and search.**

> 📚 **Analogy:** It's like a librarian.
> Toss in a pile of books (documents), and the librarian **sorts them by topic** onto shelves,
> and when you ask "where are the AI books?" it **finds them instantly.**
> It even shows those shelves as a **3D star map (glowing points)**.

What you can do:
- **Search by meaning** — finds documents by similar meaning even when words don't match exactly.
- **See a 3D map** — view at a glance which topics your documents cluster around.
- **Let AI use your documents** — connect to AI tools like Claude or Cursor, and the AI references your documents like a memory when answering ("MCP" connection — explained later).

> This folder is a "remote control" (3 `.bat` files) that lets you use the public open-source program ([AlexAI-MCP/langent](https://github.com/AlexAI-MCP/langent)) **with just double-clicks.**

---

## 2. Words to know first (glossary)

Words you'll see on screen often. **No need to memorize.** Come back here when unsure.

| Word | Plain meaning |
|---|---|
| **Folder** | A drawer that holds files. Yellow folder icon. |
| **Double-click** | Click the left mouse button **twice quickly**. Opens a file. |
| **.bat file** | A Windows "auto-run file" that runs commands when double-clicked. (e.g. `INSTALL.bat`) |
| **Black window / cmd / console** | A black screen with only text. It just **shows progress as text**. Don't be scared. |
| **Ctrl+C** | The shortcut to **stop a running task** in the black window. (hold Ctrl, press C) |
| **Python** | The "engine" this program runs on. Install once. |
| **Git** | A tool that downloads program source from the internet. Needed at install. |
| **venv (virtual environment)** | A box that holds only Langent's parts, separate from everything else. |
| **Ingest** | The process of reading documents into a **searchable form** (think "register documents"). |
| **Vector** | A document's meaning expressed as numbers. Similar docs have close numbers. |
| **ChromaDB** | A small database that stores those numbers (vectors) so they're searchable. |
| **MCP** | A protocol that lets AI tools use an external program (here, Langent). |
| **Neo4j** | A program that stores "relationships" between documents. **Optional — not required.** |
| **workspace** | The folder where you **put documents** for the AI to read. |
| **Port 8000** | The internet "window number" where the 3D screen opens. URL: `http://localhost:8000` |
| **Enter / Y / N** | Enter = confirm/run, Y = Yes, N = No. |

> 💡 On-screen: `[OK]` = success, `[ERROR]` = problem, `[WARNING]` = caution.

---

## 3. Prerequisites checklist

Before starting, check that you have these.

| Item | Required? | Notes |
|---|---|---|
| 💻 **Windows PC** | ✅ Yes | Windows 10 or 11. |
| 🌐 **Internet** | ✅ For install | At install/update. After that, search & 3D work offline. |
| 🐍 **Python 3.10+** | ✅ Yes | Install in [Step 1](#4-step-1--install-python-required-programs). (3.12 recommended) |
| 🔧 **Git** | ✅ Yes | Used at install to download the source. |
| 🗄️ **Neo4j** | ⬜ Optional | For the document "relationship" feature. **All core features work without it.** |

> ✅ = must have / ⬜ = not required

**Easiest start:** install Python + Git → double-click INSTALL.bat → done. Don't worry about Neo4j.

---

## 4. Step 1 · Install Python (required programs)

> 🐍 Python is this program's "engine." Install it **just once.**
> If it's already installed, you can skip this. (Unsure? Just follow along.)

### Do this
1. In your browser (Edge, Chrome, etc.) open **https://www.python.org/downloads/**
2. Click the big yellow **"Download Python 3.xx.x"** button (3.10+ is fine, 3.12 recommended)
3. **Double-click** the downloaded installer
4. ⚠️ **Most important!** On the first screen, at the bottom,
   check ☑ **"Add python.exe to PATH"**.
   - If you don't, you'll later get `"Python 3.10 or higher is required"`.
   - Forgot? Run the installer again, check it, and reinstall.
5. Click **"Install Now"** → wait until done (1–2 min)
6. When **"Setup was successful"** appears, click **Close**

### Also install Git (to download the source)
1. Open **https://git-scm.com/download/win** → the installer downloads automatically
2. Double-click → keep clicking **Next** with the default options → Install → Finish

✅ Verify (optional): Windows key → `cmd` → Enter → type `python --version` → if `Python 3.xx.x` appears, success. (If `python` fails, try `py -3 --version`)

---

## 5. Step 2 · Download the kit

> If you can already see `INSTALL.bat` in the folder that contains this `USER_GUIDE.md`, the **download is done**. Go to [Step 3](#6-step-3--install-installbat).

This kit only needs the **3 `.bat` files**. The rest (source code, virtual environment) is downloaded automatically by INSTALL.bat.

- 📁 **Recommended location:** somewhere easy with a short path, like `Desktop` or `Documents`.
  Avoid very deep folders with spaces.

---

## 6. Step 3 · Install (INSTALL.bat)

> 🎯 Do this **just once.** After installing, just run [Step 4 (RUN.bat)](#7-step-4--add-documents--run-runbat) from then on.

### Do this
1. Open the kit folder. You'll see `INSTALL.bat`, `RUN.bat`, `UNINSTALL.bat`.
2. Double-click **`INSTALL.bat`**
3. A black window opens and runs 6 steps. (This window is normal. Don't close it. Takes **5–15 minutes**.)
   - `[1/6] Check Python` → find Python (`python`→`python3`→`py -3`, automatic)
   - `[2/6] Check source` → download (clone) langent from GitHub
   - `[3/6] Create venv` → make the dedicated box (venv)
   - `[4/6] Install dependencies` → install required parts (**this takes the longest. Please wait.**)
   - `[5/6] Configure environment` → create `.env`, `workspace`, `data` folders (sample docs copied too)
   - `[6/6] Generate MCP configs` → create `mcp_config_py.json`, `mcp_config_npx.json`
4. When **"Installation complete!"** appears, success.

### ⚠️ Common install errors
- `[ERROR] Python 3.10 or higher is required!` → (Re)install Python with **"Add to PATH"** checked. If already installed, **open a new cmd** and retry.
- `[ERROR] langent folder missing and Git not installed!` → Install Git (https://git-scm.com/download/win), then retry.
- `[ERROR] Installation failed!` → ① check internet ② `python -m pip install --upgrade pip` ③ else install Python 3.12 or Visual C++ Build Tools.

> 🏢 If a security prompt ("Do you want to allow this app to make changes?") appears, click **"Yes."** It's safe.

---

## 7. Step 4 · Add documents & run (RUN.bat)

### 7-1. First, add documents
Put documents for the AI to read into the **`workspace`** folder that was created.

| Type | Extension |
|---|---|
| Markdown | `.md` |
| Text | `.txt` |
| PDF | `.pdf` |
| Table data | `.csv` |
| Structured data | `.json` |
| Config/data | `.yaml` |

> Files in subfolders are found automatically. (Right after install, sample docs are already there for practice.)

### 7-2. Run RUN.bat
Double-click **`RUN.bat`** → this menu appears:

```
============================================================
  Langent v3 - Personal Ontology + 3D Knowledge Nebula
============================================================

    [1] Start Nebula server   http://localhost:8000
    [2] Ingest documents      scan the workspace folder
    [3] Start MCP server       connect MCP clients
    [4] Search knowledge (CLI) semantic search of the vector DB
    [5] System status          versions, packages
    [6] GitHub update          latest source + dependencies
    [7] Run tests              pytest + ruff + mypy
    [8] Uninstall              remove venv, data, etc.
    [0] Exit

============================================================
  Choice (0~8):
```

👉 **Type a number and press Enter.**

### 7-3. For your first time, do this order
1. **`2`** Enter → Ingest documents (reads workspace, registers + links relations)
2. **`1`** Enter → Start Nebula server → the 3D nebula opens in your browser (`http://localhost:8000`)
3. When done, press **Ctrl+C** in the black window → back to the menu → `0` to exit

> 💡 You must run `2` (ingest) first for content to appear in search / the 3D screen. Whenever you add documents, run `2` again.

---

## 8. Menus 0 to 8 explained (nothing left out)

### 🔢 1 · Start Nebula server
- **What:** see the 3D nebula in your browser. `http://localhost:8000` opens automatically.
- **Controls:** click a star = view doc / left-drag = rotate / wheel = zoom / top search bar + Enter = related docs glow.
- **Stop:** press **Ctrl+C** in the black window → back to menu.
- There's also an API page: `http://localhost:8000/docs`

### 🔢 2 · Ingest documents
- **What:** reads the `workspace` folder into a searchable form (ingest) and links relations between documents (link).
- **When:** once at first, and **every time you add/change documents.**
- **Note:** if workspace is empty you'll see `[WARNING] workspace folder is empty!` → add docs and retry.

### 🔢 3 · Start MCP server
- **What:** connects directly to AI tools like Claude Desktop, Antigravity, Claude Code, Cursor.
- **Usually** you don't start this manually. Register it in your AI tool's settings as in [Section 10](#10-connect-to-ai-tools-mcp-setup) and the AI tool starts it for you.
- **Stop:** Ctrl+C.

### 🔢 4 · Search knowledge (CLI)
- **What:** type search terms directly in the black window to find documents.
- **Use:** type a word at `Search:` → results show → keep searching → type `exit` to return to the menu.

### 🔢 5 · System status
- **What:** shows installed version, key packages, workspace file count, and whether MCP config files exist.
- **When:** to confirm "is it installed correctly?"

### 🔢 6 · GitHub update
- **What:** updates Langent to the latest version (`git pull` + reinstall). **Internet required.**

### 🔢 7 · Run tests
- **What:** developer code checks (pytest/ruff/mypy). **Regular users can skip.**

### 🔢 8 · Uninstall
- **What:** asks about and removes venv/data/source one by one. (For a thorough removal, use `UNINSTALL.bat`.)

### 🔢 0 · Exit
- Quits the program.

---

## 9. Real usage scenarios (workflows)

### 🅰️ "I want to search/visualize my documents"
1. Put documents in the `workspace` folder
2. `RUN.bat` → `2` (Ingest) Enter
3. `RUN.bat` → `1` (Nebula server) → check the 3D screen in your browser
4. Or use `4` (CLI search) to search right in the black window

### 🅱️ "I want AI (Claude, etc.) to reference my documents"
1. Register documents with `2` (Ingest) as above
2. Register in your AI tool per [Section 10 (MCP setup)](#10-connect-to-ai-tools-mcp-setup)
3. Tell the AI "find ○○ in my documents"

### 🅲 "I added new documents"
1. Add docs to `workspace`
2. `RUN.bat` → `2` (Ingest) again → done (reflected in search/3D/AI right away)

### 🅳 "I want to check it's installed correctly"
1. `RUN.bat` → `5` (System status) → check version, packages, file count

---

## 10. Connect to AI tools (MCP setup)

After install, the folder has **`mcp_config_py.json`** (recommended) and **`mcp_config_npx.json`**.
**Open the file in Notepad**, and paste the `"langent": { ... }` part into your AI tool's settings, inside `"mcpServers": { }`. (Paths are filled in automatically.)

### Claude Desktop
1. Claude Desktop → **Settings → Developer → Edit Config** (or `%APPDATA%\Claude\claude_desktop_config.json`)
2. Add `"langent": { ... }` inside `"mcpServers": { }`
3. **Fully quit** Claude Desktop (right-click tray icon → Quit) and reopen

### Google Antigravity
1. Chat panel → **... → MCP Servers → Manage MCP Servers → View raw config** (or `%USERPROFILE%\.gemini\antigravity\mcp_config.json`)
2. Add `"langent": { ... }` → **Refresh**

### Claude Code (terminal)
```
claude mcp add langent -- "your\path\venv\Scripts\python.exe" -m langent.server.mcp_server
```
> Confirm the exact path by opening `mcp_config_py.json` in Notepad.

### Cursor
1. **Settings → MCP → Add new MCP server**
2. Add using `mcp_config_py.json` as reference

### If you already have other MCP servers
Add a **comma (`,`)** after the existing entry, then add langent:
```json
{
  "mcpServers": {
    "existing-server": { ... },
    "langent": { ... }
  }
}
```

> ⚠️ In JSON, backslashes in paths must be written as `\\` (doubled). If you copy the auto-generated file as-is, it's already correct.

### After connecting
Tell the AI:
- "Find content about 'AI strategy' in my documents"
- "Ingest the new documents in my workspace"
- "Check the status of my knowledge base"

---

## 11. Where files & documents live

### Files present from the start (this kit)
```
Langent-MCP_One-Click_Kit\
├── INSTALL.bat       ← run once first (install)
├── RUN.bat           ← run every time (main)
├── UNINSTALL.bat     ← clean uninstall
├── README.md         ← English summary/reference (homepage)
├── README.ko.md      ← Korean summary/reference
├── USER_GUIDE.md     ← this document (full beginner guide, English)
├── 사용설명서.md      ← full beginner guide (Korean)
├── LICENSE           ← license (Apache License 2.0)
└── .gitignore        ← local-only files kept out of Git
```

### Created automatically at install
```
├── mcp_config_py.json   ← MCP config (Python method, recommended)
├── mcp_config_npx.json  ← MCP config (npx method)
├── langent/             ← program source code
│   ├── .env             ← config file
│   └── samples/         ← sample documents
├── venv/                ← virtual environment (parts box)
├── workspace/           ← put your documents here
└── data/chroma_db/      ← vector database (search data)
```

### .env config file (usually no need to touch)
Auto-created at `langent\.env`. Edit only to change the doc folder or port.

| Key | Meaning | Default |
|---|---|---|
| `LANGENT_WORKSPACE` | folder to read | install folder\workspace |
| `API_PORT` | 3D server port | 8000 |
| `CHROMA_DB_PATH` | search data location | install folder\data\chroma_db |
| `NEO4J_PASSWORD` | Neo4j password | (only if using Neo4j) |
| `LLM_MODE` | LLM mode | fake |

> ⚠️ **.env rule:** **do not put quotes (`"`) around values.** (`API_PORT=8000` ✓ / `API_PORT="8000"` ✗). Quotes cause a `python-dotenv could not parse` error.
> 🔐 `.env` may contain a password, so **don't share it or upload it online.**

---

## 12. Safety & privacy

- ✅ **Runs on your computer.** Documents are stored in a local vector DB (`data\chroma_db`). The default (`LLM_MODE=fake`) does search/3D without calling any external AI.
- ✅ **Doesn't touch your system.** It installs into a virtual environment (venv), so your other Python/programs are unaffected.
- ✅ **Clean uninstall.** UNINSTALL.bat removes only venv/source/data and leaves system Python, Git, and environment variables alone.
- ⚠️ **If you connect an AI tool (MCP),** that AI tool can read your document contents to answer. Think twice before adding sensitive documents.
- ⚠️ The **`.env`** file may hold things like a Neo4j password — don't share it.

---

## 13. Troubleshooting (all errors)

| Message / symptom | Cause | Fix |
|---|---|---|
| `Python 3.10 or higher is required` | Python missing or not on PATH | (Re)install Python with **"Add to PATH"** checked. If already done, open a new cmd |
| `Git not found` / `Git not installed` | Git missing | Install from https://git-scm.com/download/win and retry |
| `Virtual environment missing` | INSTALL.bat not run/failed | Run `INSTALL.bat` first |
| `Installation failed!` (pip) | No internet / incompatible package | Check internet → `python -m pip install --upgrade pip` → try Python 3.12 |
| `python-dotenv could not parse` | quotes (`"`) in a `.env` value | Open `.env`, remove all quotes, save |
| `Workspace: .` (odd path) | `.env` parse failure | Same — remove quotes |
| `Neo4j connection failed` | Neo4j not installed | **Normal** — ignore it |
| `http://localhost:8000` won't open | server not running | Did you start it with `RUN.bat → [1]`? |
| Port conflict (8000 in use) | another program uses 8000 | Change `API_PORT=8001` etc. in `.env` |
| `Found 0 files` | workspace is empty | Put docs in workspace and run `[2]` again |
| Langent not visible in AI tool | MCP config error | Check path in `mcp_config_py.json` (`\`→`\\`) + **restart** the AI tool |
| "langent command not found" | venv not active | Running via RUN.bat activates it automatically |
| Black window closes too fast | (rare) | Open cmd first, then drag the `.bat` into it so you can read all messages |

---

## 14. Frequently Asked Questions (FAQ)

**Q. Can I use it with no coding knowledge?**
A. Yes. Just press a number and Enter.

**Q. Do my documents leak out?**
A. By default it runs only on your PC. But **if you connect an AI tool (MCP),** that AI reads your docs to answer.

**Q. Do I really need internet?**
A. Only for **install/update.** After that, search & 3D work offline.

**Q. Does it cost money?**
A. It's free. Both this kit and the upstream Langent are **Apache License 2.0** open source (commercial use allowed — just keep the license notice).

**Q. Does it work on Mac or phones?**
A. This kit (.bat) is **Windows-only.** (On Mac/Linux you'd install the upstream source via commands.)

**Q. Do I have to install Neo4j?**
A. No. `Neo4j connection failed` is normal; search, 3D, and AI connection all work without it.

**Q. Are added documents reflected automatically?**
A. No. After adding, run `RUN.bat → [2]` (ingest) again to reflect them.

**Q. Do I need to run menu [7] tests?**
A. No, that's for developers. Regular users can skip it.

---

## 15. Update & uninstall

### Update to the latest version
1. `RUN.bat` → `6` Enter
2. Automatically fetches and updates the latest source (internet required)

### Full removal
1. Double-click **UNINSTALL.bat**
2. It shows the current install state → type `Y` to proceed
3. **workspace (your documents) is asked about separately** — choose whether to delete
4. Removed: virtual environment (venv), source code, search data, logs, MCP configs
5. **Not removed:** system Python, Git, environment variables, other programs

> The 3 `.bat` files can be deleted manually, or just delete the whole folder.

---

## 16. Command reference (advanced, optional)

> 🧑‍💻 Only for those who want to use commands directly. Regular users can rely on the [menu](#8-menus-0-to-8-explained-nothing-left-out).

```
# Daily use (what RUN.bat does automatically)
venv\Scripts\activate
langent ingest --workspace ./workspace   ← register documents
langent link                             ← link document relations
langent serve --host 0.0.0.0 --port 8000 ← start the 3D server

# Others
langent query "search term"               ← search
langent status                            ← check status
python -m langent.server.mcp_server       ← run the MCP server directly
```

---

## 🙋 Finally
- Stuck? Re-read [13. Troubleshooting](#13-troubleshooting-all-errors) and [14. FAQ](#14-frequently-asked-questions-faq).
- For your first try, practice gently with the sample docs: `2` (ingest) → `1` (3D screen). Nothing breaks.
- Slowly, one line at a time. Anyone can do this. 🙂

---

**License:** This kit (.bat + docs) is **Apache License 2.0 — Copyright 2025 SoDam AI Studio**. Commercial use, modification, and redistribution are allowed (keep the license notice). Full terms → [LICENSE](./LICENSE).
**Upstream program:** [AlexAI-MCP/langent](https://github.com/AlexAI-MCP/langent) is a separate open-source project (Apache License 2.0, © its original authors). This kit does not bundle it; it is downloaded at install time. · **MCP docs:** https://modelcontextprotocol.io/
