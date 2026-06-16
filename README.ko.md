# Langent MCP — 원클릭 설치/실행 키트 (Windows)

> **내 컴퓨터의 문서(PDF·TXT·MD 등)를 AI가 읽고 검색할 수 있게 만들고, 비슷한 문서끼리 모아 3D 우주(별) 화면으로 보여주는 프로그램.**
> 더블클릭 한 번으로 설치하고, AI 도구(Claude Desktop·Antigravity·Claude Code·Cursor)에 연결해 "내 문서에서 ○○ 찾아줘"라고 시킬 수 있습니다.

<div align="right">
  <a href="./README.md">🇺🇸 English</a> &nbsp;|&nbsp; <a href="./README.ko.md">🇰🇷 한국어</a>
</div>

[![Python](https://img.shields.io/badge/Python-3.10%2B-yellow?logo=python)](https://www.python.org/downloads/)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-0078D4?logo=windows)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue)](./LICENSE)

> ### 📘 컴퓨터·AI가 처음이세요?
> 이 README는 **핵심 요약 + 참조용**입니다. 단어 하나하나까지 풀어 설명한 **왕초보 완전 가이드**가 따로 있습니다.
> - 🇰🇷 한국어: 👉 **[사용설명서.md](./사용설명서.md)** (용어 사전·모든 메뉴·모든 오류 대처·FAQ)
> - 🇺🇸 영어: 👉 **[USER_GUIDE.md](./USER_GUIDE.md)** (동일 내용 영어판)
>
> 처음이라면 위 가이드를 먼저 보시는 걸 강력히 권합니다.

---

## 📑 목차

1. [Langent이 뭔가요?](#langent이-뭔가요)
2. [작동 방법 (한눈에)](#작동-방법-한눈에)
3. [파일 구성](#파일-구성)
4. [사전 준비물 (필요 프로그램)](#사전-준비물-필요-프로그램)
5. [⬇️ 다운로드 방법](#️-다운로드-방법)
6. [⚡ 빠른 시작](#-빠른-시작)
7. [RUN.bat 메뉴 설명](#runbat-메뉴-설명)
8. [MCP 설정 (AI 도구에 연결)](#mcp-설정-ai-도구에-연결하기)
9. [.env 설정 파일](#env-설정-파일)
10. [3D 우주 화면 조작법](#3d-우주-화면-조작법)
11. [Neo4j에 대하여](#neo4j에-대하여)
12. [삭제 방법](#삭제-방법)
13. [설치 후 폴더 구조](#설치-후-폴더-구조)
14. [문제·오류 해결](#문제오류-해결)
15. [전체 명령어 참조 (고급)](#전체-명령어-참조-고급-사용자용)
16. [용어 설명](#용어-설명) · [라이선스](#라이선스) · [출처 및 링크](#출처-및-링크)

---

## Langent이 뭔가요?

내 컴퓨터에 있는 문서(PDF, TXT, MD 등)를 AI가 읽을 수 있게 만들어주는 프로그램입니다. 문서들을 넣으면 비슷한 내용끼리 모아서 **3D 우주 화면**에 별(점)으로 보여줍니다.

AI 도구(Claude Desktop, Antigravity, Claude Code, Cursor 등)에 연결하면 "내 문서에서 ○○ 찾아줘"라고 말할 수 있습니다.

쉽게 말해:
- **문서 보관함 + 의미 검색** — 단어가 정확히 일치하지 않아도 "비슷한 뜻"으로 찾아줍니다(시맨틱 검색).
- **3D 지식 지도** — 내 문서들이 어떤 주제로 뭉쳐 있는지 한눈에 봅니다.
- **AI 장기 기억** — MCP로 AI 도구에 연결하면, AI가 내 문서를 "기억"처럼 참고합니다.

> ℹ️ 이 폴더는 오픈소스 프로젝트 [`AlexAI-MCP/langent`](https://github.com/AlexAI-MCP/langent)(Apache-2.0) 위에 얹은 **Windows 원클릭 런처(.bat 3개)**입니다. 복잡한 명령어 대신 더블클릭과 번호 선택으로 쓰게 해 줍니다.

---

## 작동 방법 (한눈에)

```
[ INSTALL.bat 더블클릭 (처음 1번) ]
        │  Python 확인 → GitHub에서 langent 소스 clone → venv 생성
        │  → 패키지 설치 → .env 생성 → MCP 설정 2개 생성
        ▼
[ workspace 폴더에 내 문서 넣기 (MD/PDF/TXT/CSV/JSON/YAML) ]
        │
        ▼
[ RUN.bat 더블클릭 (매번) → 메뉴에서 번호 선택 ]
        │
        ├─ [2] 인제스트: 문서를 읽어 벡터 DB(ChromaDB)에 저장 + 관계 연결
        ├─ [1] Nebula 서버: 브라우저에 3D 우주 화면 (http://localhost:8000)
        ├─ [3] MCP 서버: Claude Desktop·Antigravity 등 AI 도구와 연결
        └─ [4] CLI 검색: 검은 창에서 바로 검색어로 찾기
```

- **로컬 동작:** 문서는 내 컴퓨터의 벡터 DB에 저장됩니다. (LLM_MODE 기본값 `fake` — 외부 AI 호출 없이 검색/시각화 동작)
- **선택 연결:** Neo4j(문서 간 관계 DB)와 AI 도구(MCP)는 **선택**입니다. 없어도 핵심 기능(검색·3D·인제스트)은 작동합니다.

---

## 파일 구성

이 폴더에는 BAT 파일 3개만 있으면 됩니다:

| 파일              | 설명                                         | 사용 시점  |
| ----------------- | -------------------------------------------- | ---------- |
| **INSTALL.bat**   | 원클릭 설치 — 더블클릭 한 번이면 끝          | 처음 1번만 |
| **RUN.bat**       | 원클릭 실행 — 메뉴에서 원하는 기능 선택      | 매일 사용  |
| **UNINSTALL.bat** | 안전 삭제 — 시스템에 영향 없이 깨끗하게 제거 | 삭제할 때  |

설치가 완료되면 아래 파일/폴더가 자동으로 생성됩니다 (모두 `.gitignore`로 깃 추적 제외):

| 파일/폴더               | 설명                                         |
| ----------------------- | -------------------------------------------- |
| **langent/**            | 프로그램 소스코드 (GitHub에서 자동 다운로드) |
| **venv/**               | Python 가상환경 (Langent 전용 부품 보관)     |
| **workspace/**          | 여기에 내 문서를 넣으면 됨                   |
| **data/**               | 벡터 데이터베이스 (자동 생성)                |
| **langent/.env**        | 설정 파일                                    |
| **mcp_config_py.json**  | MCP 설정 — Python 방식 (권장)                |
| **mcp_config_npx.json** | MCP 설정 — npx 방식                          |

> 설치 시 workspace가 비어 있으면 langent의 예시 문서(samples)를 자동 복사해 둡니다. 바로 연습해 볼 수 있습니다.

---

## 사전 준비물 (필요 프로그램)

| 소프트웨어 | 버전                  | 필요 여부 | 다운로드                          |
| ---------- | --------------------- | --------- | --------------------------------- |
| Python     | 3.10 이상 (3.12 권장) | ✅ 필수   | https://www.python.org/downloads/ |
| Git        | 아무 버전             | ✅ 필수(설치 시 소스 clone) | https://git-scm.com/download/win  |
| 인터넷     | —                     | ✅ 설치·업데이트 시 | — |
| Neo4j      | —                     | ⬜ 선택(문서 관계 그래프) | https://neo4j.com/download/ |

> **중요**: Python 설치 시 첫 화면의 **"Add python.exe to PATH"** 체크박스를 **반드시 체크**하세요. (안 하면 "Python 3.10 이상이 필요합니다" 오류)

Python이 이미 설치돼 있는지 확인:
1. Windows 키 → `cmd` 검색 → 엔터
2. `python --version` 입력 → 엔터
3. `Python 3.xx.x` 가 나오면 이미 설치됨 (`python`이 안 되면 `py -3 --version`도 시도)

> 💡 INSTALL.bat은 `python` → `python3` → `py -3` 순서로 자동 감지하고, `uv`가 설치돼 있으면 더 빠른 `uv`로 설치합니다.

---

## ⬇️ 다운로드 방법

> 이미 이 폴더에 `INSTALL.bat` 등이 있다면 다운로드는 끝났습니다. **[빠른 시작](#-빠른-시작)으로 가세요.**

### 방법 A — ZIP으로 받기 (가장 쉬움, Git 불필요)
1. 이 키트의 GitHub 페이지: **https://github.com/sodam-ai/Langent-MCP_One-Click_Kit**
2. 초록색 **`Code`** 버튼 → **`Download ZIP`** 클릭
3. 받은 ZIP **우클릭 → "압축 풀기"(모두 압축 해제)**
4. 풀린 폴더에 `INSTALL.bat`·`RUN.bat`이 보이면 성공
   - 📁 **추천 위치:** `바탕화면`·`문서`처럼 **찾기 쉽고 경로가 짧은 곳**. 한글·공백이 섞인 아주 깊은 경로는 피하세요.

> 나머지(원본 소스·가상환경)는 INSTALL.bat이 인터넷에서 자동으로 받아옵니다.

### 방법 B — Git으로 받기 (Git이 있는 경우)
```bash
git clone https://github.com/sodam-ai/Langent-MCP_One-Click_Kit.git
```

---

## ⚡ 빠른 시작

### 1단계. 설치 (처음 1번만)

1. **INSTALL.bat** 더블클릭
2. 자동으로 진행됨 (5~15분 소요):
   - `[1/6]` Python 버전 확인 (`python` → `python3` → `py -3` 순서로 자동 감지)
   - `[2/6]` GitHub에서 소스코드 다운로드(clone)
   - `[3/6]` 가상환경(venv) 생성
   - `[4/6]` 패키지 설치 (`pip install -e ".[dev]"`)
   - `[5/6]` 환경 설정 파일(.env)·workspace·data 폴더 생성
   - `[6/6]` MCP 설정 파일 2개 생성
3. "설치 완료!" 메시지가 나오면 끝

### 2단계. 문서 넣기

**workspace** 폴더에 AI가 읽을 문서를 넣으세요.

| 종류     | 확장자 | 예시                    |
| -------- | ------ | ----------------------- |
| 마크다운 | .md    | 메모, 문서, 위키        |
| 텍스트   | .txt   | 일반 텍스트 파일        |
| PDF      | .pdf   | 논문, 보고서, 매뉴얼    |
| CSV      | .csv   | 표 데이터, 스프레드시트 |
| JSON     | .json  | 구조화된 데이터         |
| YAML     | .yaml  | 설정 파일, 데이터       |

> 하위 폴더에 있는 파일도 자동으로 찾아 읽습니다.

### 3단계. 실행 (매일)

1. **RUN.bat** 더블클릭
2. 메뉴 화면이 나타남:

```
============================================================
  Langent v3 - Personal Ontology + 3D Knowledge Nebula
============================================================

    [1] Nebula 서버 시작      http://localhost:8000
    [2] 문서 인제스트         workspace 폴더 스캔
    [3] MCP 서버 시작         MCP 클라이언트 연동
    [4] 지식 검색 (CLI)       벡터 DB 시맨틱 검색
    [5] 시스템 상태           버전, 패키지 확인
    [6] GitHub 업데이트       최신 소스 + 의존성 갱신
    [7] 테스트 실행           pytest + ruff + mypy
    [8] 삭제 (Uninstall)      venv, data 등 정리
    [0] 종료

============================================================
```

3. 번호 입력 후 엔터

**처음 사용할 때 권장 순서:**
1. 먼저 `[2]` 문서 인제스트 → workspace 폴더의 문서를 읽어들임 (자동으로 관계 연결까지 수행)
2. 그 다음 `[1]` Nebula 서버 시작 → 브라우저에서 3D 우주 화면 확인
3. 끄기: 검은 창에서 **Ctrl+C** → 메뉴로 돌아감

---

## RUN.bat 메뉴 설명

| 번호  | 기능             | 상세 설명                                                    | 인터넷 |
| ----- | ---------------- | ----------------------------------------------------------- | ------ |
| **1** | Nebula 서버 시작 | 3D 우주 화면을 브라우저에서 봄. http://localhost:8000 자동 열림 (Ctrl+C로 종료) | 불필요 |
| **2** | 문서 인제스트    | workspace 폴더의 문서를 읽어 검색 가능하게 만듦 + 관계 연결(link) | 불필요 |
| **3** | MCP 서버 시작    | AI 도구(Claude Desktop, Antigravity 등)와 직접 연결 (Ctrl+C로 종료) | 불필요 |
| **4** | 지식 검색 (CLI)  | 검은 창에서 직접 검색어 입력해 문서 찾기 (`exit` 입력 시 메뉴 복귀) | 불필요 |
| **5** | 시스템 상태      | 설치된 패키지 버전, workspace 파일 수, MCP 설정 파일 확인    | 불필요 |
| **6** | GitHub 업데이트  | Langent 최신 버전으로 자동 업데이트 (`git pull` + 재설치)   | 필요   |
| **7** | 테스트 실행      | 개발자용 — 코드 검사(pytest/ruff/mypy). 일반 사용자는 안 해도 됨 | 불필요 |
| **8** | 삭제             | 간단 삭제 (더 철저한 삭제는 UNINSTALL.bat 사용)             | 불필요 |
| **0** | 종료             | 프로그램 끝내기                                              | —      |

---

## MCP 설정 (AI 도구에 연결하기)

INSTALL.bat이 MCP 설정 파일 2개를 자동으로 만들어 줍니다. 이 파일의 내용을 AI 도구의 설정에 복사하면 연결됩니다.

### 생성되는 MCP 설정 파일

**mcp_config_py.json** (Python venv 방식 — 권장):

```json
{
  "mcpServers": {
    "langent": {
      "command": "(설치경로)\\venv\\Scripts\\python.exe",
      "args": ["-m", "langent.server.mcp_server"],
      "env": {
        "LANGENT_WORKSPACE": "(설치경로)\\workspace"
      }
    }
  }
}
```

> 실제 경로는 설치 위치에 맞게 자동으로 채워집니다. 메모장으로 열어서 그대로 복사하세요.

### Google Antigravity에 연결하기
1. **설정 파일 열기** (아래 중 하나):
   - Antigravity 에디터 → 채팅 패널 → **...** → **MCP Servers** → **Manage MCP Servers** → **View raw config**
   - 또는 파일 탐색기에서 `%USERPROFILE%\.gemini\antigravity\mcp_config.json` 열기
2. **mcp_config_py.json** 내용 중 `"langent": { ... }` 부분을 `"mcpServers": { }` 안에 추가
3. MCP Servers 패널에서 **Refresh** 클릭

### Claude Desktop에 연결하기
1. **설정 파일 열기** (아래 중 하나):
   - Claude Desktop → **Settings** → **Developer** → **Edit Config**
   - 또는 `%APPDATA%\Claude\claude_desktop_config.json` 메모장으로 열기
2. **mcp_config_py.json** 내용 중 `"langent": { ... }` 부분을 `"mcpServers": { }` 안에 추가
3. Claude Desktop **완전 종료** 후 다시 실행 (트레이 아이콘 우클릭 → 종료)

### Claude Code에 연결하기 (터미널)
```
claude mcp add langent -- "내경로\venv\Scripts\python.exe" -m langent.server.mcp_server
```
> 정확한 경로는 **mcp_config_py.json**을 메모장으로 열어 확인하세요.

### Cursor에 연결하기
1. Cursor → **Settings** → **MCP** → **Add new MCP server**
2. **mcp_config_py.json** 내용 참고하여 추가

### 이미 다른 MCP 서버가 있는 경우
기존 내용 뒤에 **쉼표(`,`)**를 넣고 langent 스니펫을 추가하세요:
```json
{
  "mcpServers": {
    "기존서버": { ... },
    "langent": { ... }
  }
}
```

### 연결 후 사용법
AI에게 이렇게 말하면 됩니다:
- "내 문서에서 'AI 전략'에 대한 내용을 찾아줘"
- "워크스페이스의 새 문서를 읽어들여줘"
- "내 지식 베이스 상태를 확인해줘"

---

## .env 설정 파일

설치 시 `langent/.env`에 자동 생성됩니다. 보통은 수정할 필요 없습니다.

### 설정 항목

| 항목                | 뜻                  | 기본값                   | 수정 필요?              |
| ------------------- | ------------------- | ------------------------ | ----------------------- |
| `LANGENT_WORKSPACE` | AI가 읽을 문서 폴더 | 설치 폴더\workspace      | **문서 폴더 바꿀 때만** |
| `CHROMA_DB_PATH`    | 벡터 DB 저장 위치   | 설치 폴더\data\chroma_db | 보통 불필요             |
| `EMBEDDING_MODEL`   | 문서→벡터 변환 모델 | all-MiniLM-L6-v2         | 보통 불필요             |
| `API_HOST`          | 서버 호스트         | 0.0.0.0                  | 보통 불필요             |
| `API_PORT`          | 서버 포트 번호      | 8000                     | 포트 충돌 시만          |
| `NEO4J_URI` / `NEO4J_USER` / `NEO4J_PASSWORD` | Neo4j 접속 정보 | bolt://localhost:7687 / neo4j / password | Neo4j 설치 시만 |
| `LLM_MODE`          | LLM 모드            | fake                     | 보통 불필요             |

### .env 작성 규칙 (중요!)

```
올바른 예시:
LANGENT_WORKSPACE=D:\MyDocs\my-knowledge
API_PORT=8000

잘못된 예시 (따옴표 넣으면 에러):
LANGENT_WORKSPACE="D:\MyDocs\my-knowledge"
API_PORT="8000"
```

- 값에 **따옴표(`"`)를 넣지 마세요** — 에러의 가장 흔한 원인
- 등호(`=`) 앞뒤에 **공백을 넣지 마세요**

### .env 수정 방법
1. langent 폴더에서 `.env` 파일을 메모장으로 열기 (`notepad .env`)
2. 수정 후 **Ctrl+S**로 저장
3. RUN.bat 재실행

> 🔐 **보안:** `.env`에 Neo4j 비밀번호 등이 들어갈 수 있습니다. 이 파일을 인터넷·메신저로 공유하거나 GitHub에 올리지 마세요. (이 키트의 `.gitignore`가 `.env`를 자동 제외합니다.)

---

## 3D 우주 화면 조작법

RUN.bat에서 `[1]` Nebula 서버를 시작하면 브라우저에서 3D 화면이 열립니다. (주소: http://localhost:8000, API 문서: http://localhost:8000/docs)

| 조작                     | 기능              |
| ------------------------ | ----------------- |
| 별(점) 클릭              | 그 문서 내용 보기 |
| 마우스 왼쪽 + 드래그     | 화면 돌리기       |
| 마우스 휠 스크롤         | 확대 / 축소       |
| 상단 검색바 입력 + Enter | 관련 문서가 빛남  |

---

## Neo4j에 대하여

`Neo4j connection failed` 메시지는 **정상**입니다. 무시해도 됩니다.

Neo4j는 문서 간 "관계"를 저장하는 프로그램인데, **설치하지 않아도** Langent의 핵심 기능(문서 검색, 3D 시각화, MCP 연결)은 모두 작동합니다.

Neo4j를 사용하고 싶다면:
1. https://neo4j.com/download/ 에서 다운로드
2. 설치 후 Neo4j Desktop 실행 → New → Create project
3. Add → Local DBMS → 비밀번호 설정 → Create → Start
4. `.env` 파일의 `NEO4J_PASSWORD`를 설정한 비밀번호로 수정

---

## 삭제 방법

### 간단 삭제 (RUN.bat 메뉴 [8])
venv, data, 소스코드를 각각 물어보며 선택적으로 삭제합니다.

### 완전 삭제 (UNINSTALL.bat 권장)
1. **UNINSTALL.bat** 더블클릭
2. 현재 설치 상태를 보여줌 (뭐가 있고 없는지)
3. `Y` 입력으로 삭제 진행 (실행 중인 8000 포트 서버·Python 프로세스를 먼저 종료)
4. workspace 폴더는 **별도로 물어봄** (내 문서가 들어있으므로)
5. 삭제 완료 — 시스템 Python, Git, 다른 프로그램에는 영향 없음

삭제되는 것:
- Python 가상환경 (venv)
- Langent 소스코드
- ChromaDB 벡터 데이터
- 로그 및 MCP 설정 파일 (mcp_config_py.json, mcp_config_npx.json)

삭제 안 되는 것 (안전):
- 시스템 Python, Git
- 환경변수, 레지스트리
- 다른 프로그램

> BAT 파일 3개(INSTALL/RUN/UNINSTALL)는 수동으로 삭제하거나, 폴더 전체를 삭제해도 됩니다.

---

## 설치 후 폴더 구조

```
Langent-MCP_One-Click_Kit/
├── INSTALL.bat               ← 설치 (처음 1번)
├── RUN.bat                   ← 실행 (매일 사용)
├── UNINSTALL.bat             ← 삭제
├── README.md                 ← 영어 요약·참조 (홈 화면)
├── README.ko.md              ← 한국어 요약·참조 (이 문서)
├── 사용설명서.md              ← 왕초보 완전 가이드 (한국어)
├── USER_GUIDE.md             ← 왕초보 완전 가이드 (영어)
├── LICENSE                   ← 라이선스 (Apache License 2.0)
├── .gitignore                ← 깃에 올리지 않을 로컬 파일 목록
│
│  (아래는 INSTALL.bat 실행 시 자동 생성 — .gitignore로 제외)
├── mcp_config_py.json        ← MCP 설정 (Python 방식)
├── mcp_config_npx.json       ← MCP 설정 (npx 방식)
├── langent/                  ← 프로그램 소스코드 (자동 다운로드)
│   ├── .env                  ← 설정 파일
│   ├── langent/              ← Python 패키지
│   ├── samples/              ← 예시 문서
│   └── ...
├── venv/                     ← Python 가상환경
├── workspace/                ← 여기에 내 문서 넣기
└── data/
    └── chroma_db/            ← 벡터 데이터베이스 (자동 생성)
```

---

## 문제·오류 해결

| 문제                            | 원인                            | 해결                                                         |
| ------------------------------- | ------------------------------- | ------------------------------------------------------------ |
| "Python 3.10 이상이 필요합니다" | Python 미설치 또는 PATH 미등록  | Python 설치 시 **"Add to PATH"** 체크. 이미 설치했다면 cmd 새로 열기 |
| "Git not found"                 | Git 미설치                      | https://git-scm.com/download/win 에서 설치                   |
| "가상환경이 없습니다"           | INSTALL.bat을 안 했거나 실패    | INSTALL.bat 먼저 실행                                        |
| `python-dotenv could not parse` | .env 파일 값에 따옴표(`"`) 포함 | .env 열어서 모든 따옴표 제거 후 저장                         |
| `Workspace: .`                  | .env 파싱 실패로 경로 미인식    | 위와 동일 — .env 따옴표 제거                                 |
| `pip install` 실패              | 인터넷 끊김 / 패키지 비호환 / 빌드도구 부족 | 인터넷 확인 → `python -m pip install --upgrade pip` → 그래도 안 되면 Python 3.12 또는 Visual C++ Build Tools 설치 |
| `Neo4j connection failed`       | Neo4j 미설치                    | **정상** — 무시해도 됨                                       |
| localhost:8000 안 열림          | 서버가 안 돌아가고 있음         | RUN.bat → [1]로 서버 시작했는지 확인                         |
| AI 도구에서 Langent 안 됨       | MCP 설정 오류                   | mcp_config_py.json 경로 확인(`\`는 `\\`). AI 도구 재시작     |
| "langent" 명령어를 찾을 수 없음 | 가상환경 미활성화               | RUN.bat으로 실행하면 자동 활성화됨                           |
| Found 0 files                   | 문서 폴더가 비어있음            | workspace 폴더에 파일 넣기                                   |
| 포트 충돌 (8000 사용 중)        | 다른 프로그램이 8000 포트 사용  | .env에서 `API_PORT=8001` 등으로 변경                         |

> 모든 오류의 더 자세한 대처는 **[사용설명서.md → 문제 대처](./사용설명서.md)** 참고.

---

## 전체 명령어 참조 (고급 사용자용)

일반 사용자는 BAT 파일만 사용하면 됩니다. 아래는 참고용입니다.

```
# 수동 설치 (INSTALL.bat이 자동으로 실행하는 내용)
git clone https://github.com/AlexAI-MCP/langent.git
python -m venv venv
venv\Scripts\activate
pip install -e ".[dev]"

# 매일 사용 (RUN.bat이 자동으로 실행하는 내용)
venv\Scripts\activate
langent ingest --workspace ./workspace   ← 문서 읽어들이기
langent link                             ← 문서 간 관계 연결
langent serve --host 0.0.0.0 --port 8000 ← 3D 서버 시작

# 기타
langent query "검색어"                    ← 터미널에서 검색
langent status                            ← 시스템 상태 확인
python -m langent.server.mcp_server       ← MCP 서버 직접 실행
```

---

## 용어 설명

| 용어                  | 뜻                                                           |
| --------------------- | ------------------------------------------------------------ |
| **검은 화면 (cmd)**   | 글자로 명령을 내리는 창. Windows 키 → cmd 검색               |
| **Python**            | 프로그래밍 언어. Langent이 이 언어로 만들어짐                |
| **Git**               | 인터넷에서 프로그램 소스코드를 다운로드하는 도구             |
| **pip**               | Python 부품(패키지)을 설치하는 도구                          |
| **가상환경 (venv)**   | Langent 전용 부품을 분리 보관하는 상자. 시스템 Python에 영향 없음 |
| **MCP**               | AI 도구가 외부 프로그램을 사용할 수 있게 하는 연결 규약      |
| **JSON**              | 설정 파일 형식. `{ }` 중괄호와 쉼표로 구성                   |
| **Neo4j**             | 문서 간 관계를 저장하는 프로그램 (선택사항, 없어도 됨)       |
| **ChromaDB**          | 문서를 벡터로 변환해 검색 가능하게 하는 DB                   |
| **인제스트 (Ingest)** | 문서를 읽어서 검색 가능한 형태로 변환하는 과정               |
| **벡터 (Vector)**     | 문서의 의미를 숫자로 표현한 것. 비슷한 문서끼리 가까운 숫자를 가짐 |

---

## 라이선스

**Apache License 2.0** — Copyright 2025 SoDam AI Studio

이 키트(설치·실행 스크립트 `INSTALL/RUN/UNINSTALL.bat`와 문서)는 SoDam AI Studio가 만든 **Windows 런처/안내서**이며, **Apache License 2.0**으로 배포됩니다. 상업적 사용·수정·재배포가 허용되며, 사용 시 라이선스 고지를 유지해야 합니다. 전체 조건은 [LICENSE](./LICENSE) 참조.

> **원본 프로그램 고지:** 실제 검사·시각화 엔진인 [`AlexAI-MCP/langent`](https://github.com/AlexAI-MCP/langent)는 **별도의 오픈소스 프로젝트(Apache License 2.0, 저작권 원저작자)**입니다. 이 키트는 langent를 **번들로 포함하지 않고**, INSTALL.bat 실행 시 사용자의 컴퓨터로 GitHub에서 직접 내려받습니다. SoDam AI Studio는 langent에 대한 소유권을 주장하지 않으며, langent의 사용은 원저작자의 라이선스를 따릅니다.

> ⚠️ **보증 안 함:** 이 소프트웨어는 "있는 그대로(AS IS)" 제공되며, 사용에 따른 책임은 사용자에게 있습니다 (Apache License 2.0 제7·8조).

---

## 출처 및 링크

- Langent GitHub (원본): https://github.com/AlexAI-MCP/langent
- Python 다운로드: https://www.python.org/downloads/
- Git 다운로드: https://git-scm.com/download/win
- Neo4j 다운로드: https://neo4j.com/download/
- MCP 공식 문서: https://modelcontextprotocol.io/
