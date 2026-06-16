# Langent MCP — One-Click Install/Run Kit (Windows)

> **Make the documents on your PC (PDF, TXT, MD, etc.) readable and searchable by AI, and see them clustered as stars in a 3D "knowledge nebula."**
> Install with one double-click, then connect it to AI tools (Claude Desktop, Antigravity, Claude Code, Cursor) and say "find ○○ in my documents."

<div align="right">
  <a href="./README.md">🇺🇸 English</a> &nbsp;|&nbsp; <a href="./README.ko.md">🇰🇷 한국어</a>
</div>

[![Python](https://img.shields.io/badge/Python-3.10%2B-yellow?logo=python)](https://www.python.org/downloads/)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-0078D4?logo=windows)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue)](./LICENSE)

> ### 📘 New to computers or AI?
> This README is a **quick summary + reference**. There are full **beginner walkthroughs** that explain every term:
> - 🇺🇸 English: 👉 **[USER_GUIDE.md](./USER_GUIDE.md)** (glossary · every menu · every error fix · FAQ)
> - 🇰🇷 Korean: 👉 **[사용설명서.md](./사용설명서.md)** (same content in Korean)
>
> If this is your first time, we strongly recommend reading a guide first.

---

## 📑 Table of Contents

1. [What is Langent?](#what-is-langent)
2. [How it works (at a glance)](#how-it-works-at-a-glance)
3. [File layout](#file-layout)
4. [Requirements (what you need)](#requirements-what-you-need)
5. [⬇️ How to download](#️-how-to-download)
6. [⚡ Quick Start](#-quick-start)
7. [RUN.bat menu reference](#runbat-menu-reference)
8. [MCP setup (connect to AI tools)](#mcp-setup-connect-to-ai-tools)
9. [.env configuration file](#env-configuration-file)
10. [3D nebula controls](#3d-nebula-controls)
11. [About Neo4j](#about-neo4j)
12. [Uninstall](#uninstall)
13. [Folder structure after install](#folder-structure-after-install)
14. [Troubleshooting](#troubleshooting)
15. [Full command reference (advanced)](#full-command-reference-advanced)
16. [Glossary](#glossary) · [License](#license) · [Links](#links)

---

## What is Langent?

Langent makes the documents on your computer (PDF, TXT, MD, etc.) readable by AI. Drop documents in, and it clusters similar content together and shows them as stars (points) in a **3D nebula screen**.

Connect it to AI tools (Claude Desktop, Antigravity, Claude Code, Cursor) and you can say "find ○○ in my documents."

In short:
- **Document vault + semantic search** — finds documents by *meaning*, even when the words don't match exactly.
- **3D knowledge map** — see at a glance which topics your documents cluster around.
- **AI long-term memory** — connect via MCP and your AI tool can reference your documents like a memory.

> ℹ️ This folder is a **Windows one-click launcher (3 `.bat` files)** layered on top of the open-source project [`AlexAI-MCP/langent`](https://github.com/AlexAI-MCP/langent) (Apache-2.0). It lets you use it with double-clicks and number choices instead of complex commands.

---

## How it works (at a glance)

```
[ Double-click INSTALL.bat (first time only) ]
        │  Check Python → clone langent source from GitHub → create venv
        │  → install packages → create .env → generate 2 MCP configs
        ▼
[ Put your documents in the workspace folder (MD/PDF/TXT/CSV/JSON/YAML) ]
        │
        ▼
[ Double-click RUN.bat (every time) → pick a number from the menu ]
        │
        ├─ [2] Ingest: read docs into the vector DB (ChromaDB) + link relations
        ├─ [1] Nebula server: 3D screen in your browser (http://localhost:8000)
        ├─ [3] MCP server: connect to AI tools (Claude Desktop, Antigravity, ...)
        └─ [4] CLI search: search by keyword right in the black window
```

- **Runs locally:** documents are stored in a vector DB on your PC. (Default `LLM_MODE=fake` — search/visualization work without calling any external AI.)
- **Optional connections:** Neo4j (document-relationship DB) and AI tools (MCP) are **optional**. Core features (search, 3D, ingest) work without them.

---

## File layout

This folder only needs the 3 BAT files:

| File              | Description                                      | When        |
| ----------------- | ------------------------------------------------ | ----------- |
| **INSTALL.bat**   | One-click install — one double-click and done    | First time  |
| **RUN.bat**       | One-click run — pick a feature from the menu      | Daily use   |
| **UNINSTALL.bat** | Safe removal — clean uninstall, no system impact  | When removing |

After installing, these are created automatically (all excluded by `.gitignore`):

| File / folder           | Description                                   |
| ----------------------- | --------------------------------------------- |
| **langent/**            | Program source code (auto-downloaded from GitHub) |
| **venv/**               | Python virtual environment (Langent's own parts)  |
| **workspace/**          | Put your documents here                        |
| **data/**               | Vector database (auto-created)                 |
| **langent/.env**        | Configuration file                            |
| **mcp_config_py.json**  | MCP config — Python method (recommended)       |
| **mcp_config_npx.json** | MCP config — npx method                        |

> If workspace is empty at install time, langent's sample documents are copied in so you can practice right away.

---

## Requirements (what you need)

| Software | Version               | Required? | Download                          |
| -------- | --------------------- | --------- | --------------------------------- |
| Python   | 3.10+ (3.12 recommended) | ✅ Yes  | https://www.python.org/downloads/ |
| Git      | any version           | ✅ Yes (to clone source at install) | https://git-scm.com/download/win |
| Internet | —                     | ✅ For install/update | — |
| Neo4j    | —                     | ⬜ Optional (relationship graph) | https://neo4j.com/download/ |

> **Important**: When installing Python, check **"Add python.exe to PATH"** on the first screen. (Otherwise you get "Python 3.10 or higher is required".)

Check if Python is already installed:
1. Windows key → search `cmd` → Enter
2. Type `python --version` → Enter
3. If `Python 3.xx.x` appears, it's installed (if `python` fails, try `py -3 --version`)

> 💡 INSTALL.bat auto-detects in the order `python` → `python3` → `py -3`, and uses the faster `uv` if it's installed.

---

## ⬇️ How to download

> If `INSTALL.bat` etc. are already in this folder, the download is done. **Go to [Quick Start](#-quick-start).**

### Option A — Download as ZIP (easiest, no Git needed)
1. Open the kit's GitHub page: **https://github.com/sodam-ai/Langent-MCP_One-Click_Kit**
2. Click the green **`Code`** button → **`Download ZIP`**
3. Right-click the ZIP → **"Extract All"**
4. You should see `INSTALL.bat` and `RUN.bat` in the extracted folder
   - 📁 **Recommended location:** somewhere easy with a short path, like `Desktop` or `Documents`. Avoid very deep paths with spaces.

> The rest (source code, virtual environment) is downloaded automatically by INSTALL.bat.

### Option B — Clone with Git (if you have Git)
```bash
git clone https://github.com/sodam-ai/Langent-MCP_One-Click_Kit.git
```

---

## ⚡ Quick Start

### Step 1. Install (first time only)

1. Double-click **INSTALL.bat**
2. It proceeds automatically (5–15 minutes):
   - `[1/6]` Check Python version (`python` → `python3` → `py -3`, auto-detect)
   - `[2/6]` Download (clone) the source from GitHub
   - `[3/6]` Create the virtual environment (venv)
   - `[4/6]` Install packages (`pip install -e ".[dev]"`)
   - `[5/6]` Create the config file (.env) and the workspace / data folders
   - `[6/6]` Generate 2 MCP config files
3. When "Installation complete!" appears, you're done

### Step 2. Add documents

Put the documents you want AI to read into the **workspace** folder.

| Type     | Extension | Examples                |
| -------- | --------- | ----------------------- |
| Markdown | .md       | notes, docs, wikis      |
| Text     | .txt      | plain text files        |
| PDF      | .pdf      | papers, reports, manuals |
| CSV      | .csv      | tables, spreadsheets    |
| JSON     | .json     | structured data         |
| YAML     | .yaml     | config files, data      |

> Files in subfolders are found and read automatically.

### Step 3. Run (every day)

1. Double-click **RUN.bat**
2. The menu appears:

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
```

3. Type a number and press Enter

**Recommended order for first use:**
1. First `[2]` Ingest documents → reads the workspace folder (also links relationships automatically)
2. Then `[1]` Start Nebula server → check the 3D nebula in your browser
3. Stop: press **Ctrl+C** in the black window → back to the menu

---

## RUN.bat menu reference

| # | Feature            | Details                                                      | Internet |
| --- | ---------------- | ----------------------------------------------------------- | -------- |
| **1** | Start Nebula server | See the 3D nebula in your browser. http://localhost:8000 opens automatically (Ctrl+C to stop) | No |
| **2** | Ingest documents | Read the workspace folder into a searchable form + link relations | No |
| **3** | Start MCP server | Connect directly to AI tools (Claude Desktop, Antigravity, ...) (Ctrl+C to stop) | No |
| **4** | Search (CLI)     | Type search terms in the black window (type `exit` to return) | No |
| **5** | System status    | Installed package versions, workspace file count, MCP config files | No |
| **6** | GitHub update    | Auto-update Langent to the latest version (`git pull` + reinstall) | Yes |
| **7** | Run tests        | Developer-only code checks (pytest/ruff/mypy). Regular users can skip | No |
| **8** | Uninstall        | Simple removal (for a thorough one use UNINSTALL.bat)        | No |
| **0** | Exit             | Quit the program                                            | — |

---

## MCP setup (connect to AI tools)

INSTALL.bat generates two MCP config files automatically. Copy their contents into your AI tool's settings to connect.

### Generated MCP config file

**mcp_config_py.json** (Python venv method — recommended):

```json
{
  "mcpServers": {
    "langent": {
      "command": "(install path)\\venv\\Scripts\\python.exe",
      "args": ["-m", "langent.server.mcp_server"],
      "env": {
        "LANGENT_WORKSPACE": "(install path)\\workspace"
      }
    }
  }
}
```

> The real paths are filled in to match your install location. Open it in Notepad and copy as-is.

### Connect to Google Antigravity
1. **Open the config** (one of):
   - Antigravity editor → chat panel → **...** → **MCP Servers** → **Manage MCP Servers** → **View raw config**
   - or open `%USERPROFILE%\.gemini\antigravity\mcp_config.json` in File Explorer
2. Add the `"langent": { ... }` part from **mcp_config_py.json** inside `"mcpServers": { }`
3. Click **Refresh** in the MCP Servers panel

### Connect to Claude Desktop
1. **Open the config** (one of):
   - Claude Desktop → **Settings** → **Developer** → **Edit Config**
   - or open `%APPDATA%\Claude\claude_desktop_config.json` in Notepad
2. Add the `"langent": { ... }` part inside `"mcpServers": { }`
3. **Fully quit** Claude Desktop (right-click tray icon → Quit) and reopen

### Connect to Claude Code (terminal)
```
claude mcp add langent -- "your\path\venv\Scripts\python.exe" -m langent.server.mcp_server
```
> Confirm the exact path by opening **mcp_config_py.json** in Notepad.

### Connect to Cursor
1. Cursor → **Settings** → **MCP** → **Add new MCP server**
2. Add using **mcp_config_py.json** as reference

### If you already have other MCP servers
Add a **comma (`,`)** after the existing entry, then add the langent snippet:
```json
{
  "mcpServers": {
    "existing-server": { ... },
    "langent": { ... }
  }
}
```

### After connecting
Just tell the AI:
- "Find content about 'AI strategy' in my documents"
- "Ingest the new documents in my workspace"
- "Check the status of my knowledge base"

---

## .env configuration file

Auto-created at `langent/.env` during install. Usually no need to edit.

### Settings

| Key                 | Meaning             | Default                  | Need to edit?           |
| ------------------- | ------------------- | ------------------------ | ----------------------- |
| `LANGENT_WORKSPACE` | Folder AI reads     | install folder\workspace | **Only to change doc folder** |
| `CHROMA_DB_PATH`    | Vector DB location  | install folder\data\chroma_db | Usually not        |
| `EMBEDDING_MODEL`   | Doc→vector model    | all-MiniLM-L6-v2         | Usually not             |
| `API_HOST`          | Server host         | 0.0.0.0                  | Usually not             |
| `API_PORT`          | Server port         | 8000                     | Only on port conflict   |
| `NEO4J_URI` / `NEO4J_USER` / `NEO4J_PASSWORD` | Neo4j credentials | bolt://localhost:7687 / neo4j / password | Only if using Neo4j |
| `LLM_MODE`          | LLM mode            | fake                     | Usually not             |

### .env rules (important!)

```
Correct:
LANGENT_WORKSPACE=D:\MyDocs\my-knowledge
API_PORT=8000

Wrong (quotes cause errors):
LANGENT_WORKSPACE="D:\MyDocs\my-knowledge"
API_PORT="8000"
```

- **Do not put quotes (`"`) around values** — the most common cause of errors
- **No spaces** before/after the equals sign (`=`)

### How to edit .env
1. Open `.env` in the langent folder with Notepad (`notepad .env`)
2. Edit and save with **Ctrl+S**
3. Re-run RUN.bat

> 🔐 **Security:** `.env` may hold things like a Neo4j password. Do not share it online or in messengers, and don't upload it to GitHub. (This kit's `.gitignore` excludes `.env` automatically.)

---

## 3D nebula controls

Starting `[1]` Nebula server in RUN.bat opens the 3D screen in your browser. (URL: http://localhost:8000, API docs: http://localhost:8000/docs)

| Action                       | Effect              |
| ---------------------------- | ------------------- |
| Click a star (point)         | View that document  |
| Left mouse + drag            | Rotate the view     |
| Mouse wheel scroll           | Zoom in / out       |
| Type in the top search bar + Enter | Related docs glow |

---

## About Neo4j

The `Neo4j connection failed` message is **normal**. You can ignore it.

Neo4j stores "relationships" between documents, but **even without installing it** Langent's core features (document search, 3D visualization, MCP connection) all work.

To use Neo4j:
1. Download from https://neo4j.com/download/
2. Run Neo4j Desktop → New → Create project
3. Add → Local DBMS → set a password → Create → Start
4. Change `NEO4J_PASSWORD` in `.env` to the password you set

---

## Uninstall

### Simple removal (RUN.bat menu [8])
Asks about and selectively removes venv, data, and source code.

### Full removal (UNINSTALL.bat recommended)
1. Double-click **UNINSTALL.bat**
2. It shows the current install state (what's present/absent)
3. Type `Y` to proceed (it first stops any running server on port 8000 / Python processes)
4. The workspace folder is **asked about separately** (it holds your documents)
5. Done — your system Python, Git, and other programs are unaffected

Removed:
- Python virtual environment (venv)
- Langent source code
- ChromaDB vector data
- Logs and MCP config files (mcp_config_py.json, mcp_config_npx.json)

Not removed (safe):
- System Python, Git
- Environment variables, registry
- Other programs

> The 3 BAT files (INSTALL/RUN/UNINSTALL) can be deleted manually, or just delete the whole folder.

---

## Folder structure after install

```
Langent-MCP_One-Click_Kit/
├── INSTALL.bat               ← install (first time)
├── RUN.bat                   ← run (daily)
├── UNINSTALL.bat             ← uninstall
├── README.md                 ← English summary/reference (homepage)
├── README.ko.md              ← Korean summary/reference
├── 사용설명서.md              ← full beginner guide (Korean)
├── USER_GUIDE.md             ← full beginner guide (English)
├── LICENSE                   ← license (Apache License 2.0)
├── .gitignore                ← local-only files kept out of Git
│
│  (created by INSTALL.bat — excluded by .gitignore)
├── mcp_config_py.json        ← MCP config (Python method)
├── mcp_config_npx.json       ← MCP config (npx method)
├── langent/                  ← program source (auto-downloaded)
│   ├── .env                  ← config file
│   ├── langent/              ← Python package
│   ├── samples/              ← sample documents
│   └── ...
├── venv/                     ← Python virtual environment
├── workspace/                ← put your documents here
└── data/
    └── chroma_db/            ← vector database (auto-created)
```

---

## Troubleshooting

| Problem                          | Cause                            | Fix                                                         |
| -------------------------------- | -------------------------------- | ---------------------------------------------------------- |
| "Python 3.10 or higher required" | Python missing or not on PATH    | Reinstall Python with **"Add to PATH"** checked. If already installed, open a new cmd |
| "Git not found"                  | Git not installed                | Install from https://git-scm.com/download/win              |
| "Virtual environment missing"    | INSTALL.bat not run or failed    | Run INSTALL.bat first                                       |
| `python-dotenv could not parse`  | Quotes (`"`) in a `.env` value   | Open `.env`, remove all quotes, save                       |
| `Workspace: .`                   | `.env` parse failure             | Same as above — remove quotes                              |
| `pip install` failed             | No internet / incompatible package / missing build tools | Check internet → `python -m pip install --upgrade pip` → else install Python 3.12 or Visual C++ Build Tools |
| `Neo4j connection failed`        | Neo4j not installed              | **Normal** — ignore it                                     |
| http://localhost:8000 won't open | Server isn't running             | Start it with RUN.bat → [1]                                |
| Langent missing in AI tool       | MCP config error                 | Check the path in mcp_config_py.json (`\` → `\\`). Restart the AI tool |
| "langent command not found"      | venv not activated               | Running via RUN.bat activates it automatically             |
| Found 0 files                    | workspace is empty               | Put files in the workspace folder                          |
| Port conflict (8000 in use)      | Another program uses port 8000   | Change `API_PORT=8001` etc. in `.env`                      |

> For detailed fixes for every error, see **[USER_GUIDE.md → Troubleshooting](./USER_GUIDE.md)**.

---

## Full command reference (advanced)

Regular users only need the BAT files. The below is for reference.

```
# Manual install (what INSTALL.bat does automatically)
git clone https://github.com/AlexAI-MCP/langent.git
python -m venv venv
venv\Scripts\activate
pip install -e ".[dev]"

# Daily use (what RUN.bat does automatically)
venv\Scripts\activate
langent ingest --workspace ./workspace   ← read documents in
langent link                             ← link document relations
langent serve --host 0.0.0.0 --port 8000 ← start the 3D server

# Others
langent query "search term"               ← search from the terminal
langent status                            ← check system status
python -m langent.server.mcp_server       ← run the MCP server directly
```

---

## Glossary

| Term                  | Meaning                                                       |
| --------------------- | ------------------------------------------------------------ |
| **Black screen (cmd)**| The window where you type commands. Windows key → search cmd |
| **Python**            | A programming language. Langent is written in it             |
| **Git**               | A tool to download program source code from the internet     |
| **pip**               | A tool to install Python parts (packages)                    |
| **venv**              | A box that keeps Langent's parts separate. No impact on system Python |
| **MCP**               | A protocol that lets AI tools use external programs          |
| **JSON**              | A config file format using `{ }` braces and commas           |
| **Neo4j**             | A program that stores relationships between docs (optional)   |
| **ChromaDB**          | A DB that turns docs into vectors so they're searchable      |
| **Ingest**            | The process of reading docs into a searchable form           |
| **Vector**            | A document's meaning as numbers. Similar docs have close numbers |

---

## License

**Apache License 2.0** — Copyright 2025 SoDam AI Studio

This kit (the `INSTALL/RUN/UNINSTALL.bat` scripts and documentation) is a **Windows launcher and guide** created by SoDam AI Studio and distributed under the **Apache License 2.0**. Commercial use, modification, and redistribution are permitted, provided the license notice is retained. See [LICENSE](./LICENSE) for full terms.

> **Upstream notice:** The actual scan/visualization engine, [`AlexAI-MCP/langent`](https://github.com/AlexAI-MCP/langent), is a **separate open-source project (Apache License 2.0, © its original authors)**. This kit does **not bundle** langent; INSTALL.bat downloads it directly from GitHub onto your computer at install time. SoDam AI Studio claims no ownership of langent, and your use of langent is governed by its original authors' license.

> ⚠️ **No warranty:** This software is provided "AS IS"; you use it at your own risk (Apache License 2.0, Sections 7–8).

---

## Links

- Langent GitHub (upstream): https://github.com/AlexAI-MCP/langent
- Python download: https://www.python.org/downloads/
- Git download: https://git-scm.com/download/win
- Neo4j download: https://neo4j.com/download/
- MCP official docs: https://modelcontextprotocol.io/
