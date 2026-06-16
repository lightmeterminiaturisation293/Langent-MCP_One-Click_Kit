@echo off
setlocal EnableDelayedExpansion
title Langent v3 - One-Click Installer

REM ============================================================
REM   Langent v3 - One-Click Installer
REM   https://github.com/AlexAI-MCP/langent
REM ============================================================

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
cd /d "%SCRIPT_DIR%"

cls
echo.
echo ============================================================
echo   Langent v3 - Personal Ontology + 3D Knowledge Nebula
echo   ONE-CLICK INSTALLER
echo ============================================================
echo   Location : %SCRIPT_DIR%
echo   Date     : %DATE% %TIME%
echo ============================================================
echo.

REM ============================================================
REM   [1/6] PYTHON CHECK
REM ============================================================
echo [1/6] Python 확인 중...

set "PYTHON_CMD="

REM --- Try: python ---
python -c "import sys; exit(0 if sys.version_info>=(3,10) else 1)" >nul 2>&1 && set "PYTHON_CMD=python"

REM --- Try: python3 ---
if not defined PYTHON_CMD (
    python3 -c "import sys; exit(0 if sys.version_info>=(3,10) else 1)" >nul 2>&1 && set "PYTHON_CMD=python3"
)

REM --- Try: py -3 (Windows Python Launcher) ---
if not defined PYTHON_CMD (
    py -3 -c "import sys; exit(0 if sys.version_info>=(3,10) else 1)" >nul 2>&1 && set "PYTHON_CMD=py -3"
)

if not defined PYTHON_CMD (
    echo.
    echo   [ERROR] Python 3.10 이상이 필요합니다!
    echo.
    echo   확인 사항:
    echo     1. https://www.python.org/downloads/ 에서 설치
    echo     2. 설치 시 "Add Python to PATH" 반드시 체크
    echo     3. 이미 설치했다면 cmd를 새로 열고 다시 시도
    echo     4. python --version 명령으로 직접 확인
    echo.
    pause
    exit /b 2
)

for /f "tokens=*" %%v in ('%PYTHON_CMD% --version 2^>^&1') do set "PY_VER_STR=%%v"
echo   [OK] !PY_VER_STR! (%PYTHON_CMD%)

REM ============================================================
REM   [2/6] CLONE OR DETECT SOURCE
REM ============================================================
echo.
echo [2/6] 소스코드 확인 중...

set "LANGENT_DIR=%SCRIPT_DIR%\langent"

if exist "%LANGENT_DIR%\pyproject.toml" (
    echo   [OK] Langent 소스코드 발견
    goto :SKIP_CLONE
)

where git >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [WAIT] GitHub에서 클론 중...
    git clone https://github.com/AlexAI-MCP/langent.git "%LANGENT_DIR%"
    if !ERRORLEVEL! NEQ 0 (
        echo   [ERROR] 클론 실패! 인터넷 연결을 확인하세요.
        pause
        exit /b 3
    )
    echo   [OK] 클론 완료
) else (
    echo   [ERROR] langent 폴더가 없고 Git도 미설치!
    echo   Git 설치 후 재실행, 또는 GitHub ZIP 다운로드 후
    echo   이 폴더에 langent 이름으로 압축 해제하세요.
    pause
    exit /b 3
)

:SKIP_CLONE

REM ============================================================
REM   [3/6] CREATE VIRTUAL ENVIRONMENT
REM ============================================================
echo.
echo [3/6] 가상환경 생성 중...

set "VENV_DIR=%SCRIPT_DIR%\venv"

if exist "%VENV_DIR%\Scripts\activate.bat" (
    echo   [OK] 기존 가상환경 사용
    goto :SKIP_VENV
)

set "USE_UV=0"
where uv >nul 2>&1 && set "USE_UV=1"

if "!USE_UV!"=="1" (
    uv venv "%VENV_DIR%"
) else (
    %PYTHON_CMD% -m venv "%VENV_DIR%"
)

if not exist "%VENV_DIR%\Scripts\activate.bat" (
    echo   [ERROR] 가상환경 생성 실패!
    pause
    exit /b 3
)
echo   [OK] 생성 완료

:SKIP_VENV

call "%VENV_DIR%\Scripts\activate.bat"

REM ============================================================
REM   [4/6] INSTALL DEPENDENCIES
REM ============================================================
echo.
echo [4/6] 의존성 설치 중... (최초 5~15분 소요)

cd /d "%LANGENT_DIR%"

set "USE_UV=0"
where uv >nul 2>&1 && set "USE_UV=1"
if "!USE_UV!"=="1" (
    uv pip install -e ".[dev]"
) else (
    pip install --upgrade pip >nul 2>&1
    pip install -e ".[dev]"
)

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo   [ERROR] 설치 실패!
    echo   1. 인터넷 연결 확인
    echo   2. pip 업그레이드: python -m pip install --upgrade pip
    echo   3. Visual C++ Build Tools 필요할 수 있음
    pause
    exit /b 3
)
echo   [OK] 의존성 설치 완료

cd /d "%SCRIPT_DIR%"

REM ============================================================
REM   [5/6] CONFIGURE ENVIRONMENT
REM ============================================================
echo.
echo [5/6] 환경 설정 중...

set "WORKSPACE_DIR=%SCRIPT_DIR%\workspace"
set "ENV_FILE=%LANGENT_DIR%\.env"

if not exist "%WORKSPACE_DIR%" mkdir "%WORKSPACE_DIR%" 2>nul
if not exist "%SCRIPT_DIR%\data" mkdir "%SCRIPT_DIR%\data" 2>nul

if not exist "%ENV_FILE%" (
    (
        echo LANGENT_WORKSPACE=%WORKSPACE_DIR%
        echo NEO4J_URI=bolt://localhost:7687
        echo NEO4J_USER=neo4j
        echo NEO4J_PASSWORD=password
        echo CHROMA_DB_PATH=%SCRIPT_DIR%\data\chroma_db
        echo EMBEDDING_MODEL=all-MiniLM-L6-v2
        echo API_HOST=0.0.0.0
        echo API_PORT=8000
        echo LLM_MODE=fake
    ) > "%ENV_FILE%"
    echo   [OK] .env 생성됨
) else (
    echo   [OK] .env 이미 존재
)

for /f %%A in ('dir /b "%WORKSPACE_DIR%" 2^>nul ^| find /c /v ""') do set WS_COUNT=%%A
if %WS_COUNT% EQU 0 (
    if exist "%LANGENT_DIR%\samples" (
        xcopy /s /y "%LANGENT_DIR%\samples\*" "%WORKSPACE_DIR%\" >nul 2>&1
        echo   [OK] 샘플 데이터 복사됨
    )
)

REM ============================================================
REM   [6/6] GENERATE MCP CONFIGS (py + npx)
REM ============================================================
echo.
echo [6/6] MCP 설정 생성 중...

set "VP=%VENV_DIR%\Scripts\python.exe"
set "VP_JSON=%VP:\=\\%"
set "WS_JSON=%WORKSPACE_DIR:\=\\%"
set "WS_FWD=%WORKSPACE_DIR:\=/%"

REM --- py type: venv python.exe ---
(
    echo {
    echo   "mcpServers": {
    echo     "langent": {
    echo       "command": "%VP_JSON%",
    echo       "args": ["-m", "langent.server.mcp_server"],
    echo       "env": {
    echo         "LANGENT_WORKSPACE": "%WS_JSON%"
    echo       }
    echo     }
    echo   }
    echo }
) > "%SCRIPT_DIR%\mcp_config_py.json"
echo   [OK] mcp_config_py.json 생성됨 (Python venv 방식)

REM --- npx type ---
(
    echo {
    echo   "mcpServers": {
    echo     "langent": {
    echo       "command": "npx",
    echo       "args": ["-y", "langent-mcp"],
    echo       "env": {
    echo         "LANGENT_WORKSPACE": "%WS_FWD%"
    echo       }
    echo     }
    echo   }
    echo }
) > "%SCRIPT_DIR%\mcp_config_npx.json"
echo   [OK] mcp_config_npx.json 생성됨 (npx 방식)

REM ============================================================
REM   VERIFY
REM ============================================================
echo.
call "%VENV_DIR%\Scripts\activate.bat"
cd /d "%LANGENT_DIR%"
python -c "import langent; print(f'  [OK] Langent v{langent.__version__}')" 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [OK] 패키지 설치 확인됨
)
cd /d "%SCRIPT_DIR%"

echo.
echo ============================================================
echo   설치 완료!
echo ============================================================
echo.
echo   다음 단계:
echo     1. workspace 폴더에 문서를 넣으세요 (MD, PDF, TXT, CSV 등)
echo     2. RUN.bat 더블클릭 - 메뉴에서 원하는 기능 선택
echo.
echo   MCP 연동 (AI 도구에 아래 JSON 내용 추가):
echo     - mcp_config_py.json  : Python venv 방식 (권장)
echo     - mcp_config_npx.json : npx 방식
echo.
echo   지원 MCP 클라이언트:
echo     Claude Desktop, Antigravity, Claude Code, Cursor 등
echo ============================================================
echo.
pause
exit /b 0
