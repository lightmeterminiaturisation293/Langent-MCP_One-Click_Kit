@echo off
setlocal EnableDelayedExpansion
title Langent v3 - Launcher

REM ============================================================
REM   Langent v3 - Unified Launcher (All-in-One)
REM   https://github.com/AlexAI-MCP/langent
REM ============================================================

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
cd /d "%SCRIPT_DIR%"

REM === VENV CHECK ===
if not exist "%SCRIPT_DIR%\venv\Scripts\activate.bat" (
    echo.
    echo   [ERROR] 가상환경이 없습니다!
    echo   INSTALL.bat를 먼저 실행해 주세요.
    echo.
    pause
    exit /b 1
)
call "%SCRIPT_DIR%\venv\Scripts\activate.bat"

:MENU
cls
echo.
echo ============================================================
echo   Langent v3 - Personal Ontology + 3D Knowledge Nebula
echo ============================================================
echo.
echo     [1] Nebula 서버 시작      http://localhost:8000
echo     [2] 문서 인제스트         workspace 폴더 스캔
echo     [3] MCP 서버 시작         MCP 클라이언트 연동
echo     [4] 지식 검색 (CLI)       벡터 DB 시맨틱 검색
echo     [5] 시스템 상태           버전, 패키지 확인
echo     [6] GitHub 업데이트       최신 소스 + 의존성 갱신
echo     [7] 테스트 실행           pytest + ruff + mypy
echo     [8] 삭제 (Uninstall)      venv, data 등 정리
echo     [0] 종료
echo.
echo ============================================================
echo.

set /p CHOICE="  선택 (0~8): "

if "%CHOICE%"=="1" goto :SERVE
if "%CHOICE%"=="2" goto :INGEST
if "%CHOICE%"=="3" goto :MCP
if "%CHOICE%"=="4" goto :QUERY
if "%CHOICE%"=="5" goto :STATUS
if "%CHOICE%"=="6" goto :UPDATE
if "%CHOICE%"=="7" goto :TEST
if "%CHOICE%"=="8" goto :UNINSTALL
if "%CHOICE%"=="0" goto :EXIT

echo   [ERROR] 0~8 사이 숫자를 입력해 주세요.
timeout /t 2 /nobreak >nul
goto :MENU

REM ============================================================
REM   [1] NEBULA SERVER
REM ============================================================
:SERVE
cls
echo.
echo ============================================================
echo   Langent v3 - 3D Knowledge Nebula Server
echo ------------------------------------------------------------
echo   Dashboard : http://localhost:8000
echo   API Docs  : http://localhost:8000/docs
echo   Ctrl+C 로 종료
echo ============================================================
echo.

cd /d "%SCRIPT_DIR%\langent"
start "" cmd /c "timeout /t 3 /nobreak >nul & start http://localhost:8000"
langent serve --host 0.0.0.0 --port 8000
cd /d "%SCRIPT_DIR%"

echo.
echo   [INFO] 서버가 종료되었습니다.
pause
goto :MENU

REM ============================================================
REM   [2] INGEST
REM ============================================================
:INGEST
cls
echo.
echo ============================================================
echo   Langent v3 - 문서 인제스트
echo ============================================================
echo.

set "WS_DIR=%SCRIPT_DIR%\workspace"
if not exist "%WS_DIR%" mkdir "%WS_DIR%" 2>nul

set "FC=0"
for /f %%A in ('dir /b "%WS_DIR%" 2^>nul ^| find /c /v ""') do set FC=%%A
if %FC% EQU 0 (
    echo   [WARNING] workspace 폴더가 비어있습니다!
    echo   경로: %WS_DIR%
    echo   문서를 넣은 후 다시 시도하세요.
    echo.
    pause
    goto :MENU
)

echo   [INFO] %FC%개 항목 발견
echo.

cd /d "%SCRIPT_DIR%\langent"

echo   [1/2] 문서 인제스트...
langent ingest --workspace "%WS_DIR%"
echo.

echo   [2/2] 지식 연결(Link)...
langent link
echo.

cd /d "%SCRIPT_DIR%"

echo   [OK] 완료! 메뉴 [1]에서 Nebula 서버를 시작하세요.
echo.
pause
goto :MENU

REM ============================================================
REM   [3] MCP SERVER
REM ============================================================
:MCP
cls
echo.
echo ============================================================
echo   Langent v3 - MCP Server (stdio)
echo ------------------------------------------------------------
echo   지원 MCP 클라이언트:
echo     - Claude Desktop
echo     - Google Antigravity
echo     - Claude Code
echo     - Cursor
echo     - 기타 MCP 호환 도구
echo ------------------------------------------------------------
echo   설정 방법:
echo     mcp_config_py.json 또는 mcp_config_npx.json 내용을
echo     사용 중인 MCP 클라이언트의 설정에 추가하세요.
echo   Ctrl+C 로 종료
echo ============================================================
echo.

cd /d "%SCRIPT_DIR%\langent"
python -m langent.server.mcp_server
cd /d "%SCRIPT_DIR%"

echo.
echo   [INFO] MCP 서버가 종료되었습니다.
pause
goto :MENU

REM ============================================================
REM   [4] QUERY
REM ============================================================
:QUERY
cls
echo.
echo ============================================================
echo   Langent v3 - 지식 검색 (CLI)
echo   'exit' 입력 시 메뉴로 복귀
echo ============================================================
echo.

cd /d "%SCRIPT_DIR%\langent"

:QUERY_LOOP
set "QI="
set /p QI="  검색어: "
if /i "!QI!"=="exit" goto :QUERY_END
if /i "!QI!"=="quit" goto :QUERY_END
if "!QI!"=="" goto :QUERY_LOOP

echo.
langent query "!QI!"
echo.
echo ------------------------------------------------------------
echo.
goto :QUERY_LOOP

:QUERY_END
cd /d "%SCRIPT_DIR%"
goto :MENU

REM ============================================================
REM   [5] STATUS
REM ============================================================
:STATUS
cls
echo.
echo ============================================================
echo   Langent v3 - 시스템 상태
echo ============================================================
echo.

cd /d "%SCRIPT_DIR%\langent"
langent status
echo.

echo --- 주요 패키지 -------------------------------------------
pip list 2>nul | findstr /i "langent chromadb neo4j langchain langgraph mcp fastapi sentence-transformers"
echo.

echo --- 워크스페이스 ------------------------------------------
set "WS=%SCRIPT_DIR%\workspace"
if exist "%WS%" (
    for /f %%A in ('dir /b "%WS%" 2^>nul ^| find /c /v ""') do echo   %WS%: %%A 항목
) else (
    echo   [WARNING] workspace 없음
)

echo.
echo --- MCP 설정 파일 -----------------------------------------
if exist "%SCRIPT_DIR%\mcp_config_py.json" (
    echo   [O] mcp_config_py.json   Python venv 방식
) else (
    echo   [-] mcp_config_py.json   없음
)
if exist "%SCRIPT_DIR%\mcp_config_npx.json" (
    echo   [O] mcp_config_npx.json  npx 방식
) else (
    echo   [-] mcp_config_npx.json  없음
)

cd /d "%SCRIPT_DIR%"
echo.
pause
goto :MENU

REM ============================================================
REM   [6] UPDATE
REM ============================================================
:UPDATE
cls
echo.
echo ============================================================
echo   Langent v3 - GitHub 업데이트
echo ============================================================
echo.

where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo   [ERROR] Git이 설치되지 않았습니다!
    pause
    goto :MENU
)

if not exist "%SCRIPT_DIR%\langent\.git" (
    echo   [ERROR] langent 폴더가 Git 저장소가 아닙니다.
    pause
    goto :MENU
)

cd /d "%SCRIPT_DIR%\langent"

echo   [1/2] 최신 소스 가져오는 중...
git pull origin main
echo.

echo   [2/2] 의존성 업데이트 중...
pip install -e ".[dev]"
echo.

echo   [OK] 업데이트 완료!
langent status

cd /d "%SCRIPT_DIR%"
echo.
pause
goto :MENU

REM ============================================================
REM   [7] TEST
REM ============================================================
:TEST
cls
echo.
echo ============================================================
echo   Langent v3 - 테스트 실행
echo ============================================================
echo.

cd /d "%SCRIPT_DIR%\langent"

echo --- pytest ------------------------------------------------
pytest tests/ -v --tb=short
set "R1=%ERRORLEVEL%"
echo.

echo --- ruff --------------------------------------------------
ruff check langent/ tests/
set "R2=%ERRORLEVEL%"
echo.

echo --- mypy --------------------------------------------------
mypy langent/
set "R3=%ERRORLEVEL%"
echo.

echo ============================================================
if %R1% EQU 0 (echo   pytest: PASS) else (echo   pytest: FAIL)
if %R2% EQU 0 (echo   ruff:   PASS) else (echo   ruff:   FAIL)
if %R3% EQU 0 (echo   mypy:   PASS) else (echo   mypy:   FAIL)
echo ============================================================

cd /d "%SCRIPT_DIR%"
echo.
pause
goto :MENU

REM ============================================================
REM   [8] UNINSTALL
REM ============================================================
:UNINSTALL
cls
echo.
echo ============================================================
echo   Langent v3 - 삭제
echo   [WARNING] 되돌릴 수 없습니다!
echo ============================================================
echo.

set /p CF="  정말로 삭제하시겠습니까? (Y/N): "
if /i not "%CF%"=="Y" (
    echo   [INFO] 취소됨
    pause
    goto :MENU
)
echo.

call deactivate 2>nul

echo   [1/3] 가상환경 삭제...
if exist "%SCRIPT_DIR%\venv" (
    rmdir /s /q "%SCRIPT_DIR%\venv"
    echo   [OK]
) else (echo   [SKIP])

echo.
set /p DD="  ChromaDB 데이터도 삭제? (Y/N): "
if /i "%DD%"=="Y" (
    echo   [2/3] 데이터 삭제...
    if exist "%SCRIPT_DIR%\data" rmdir /s /q "%SCRIPT_DIR%\data"
    echo   [OK]
) else (echo   [2/3] 데이터 보존)

echo.
set /p DS="  소스코드(langent)도 삭제? (Y/N): "
if /i "%DS%"=="Y" (
    echo   [3/3] 소스코드 삭제...
    if exist "%SCRIPT_DIR%\langent" rmdir /s /q "%SCRIPT_DIR%\langent"
    echo   [OK]
) else (echo   [3/3] 소스코드 보존)

if exist "%SCRIPT_DIR%\logs" rmdir /s /q "%SCRIPT_DIR%\logs" 2>nul
if exist "%SCRIPT_DIR%\mcp_config_py.json" del /f "%SCRIPT_DIR%\mcp_config_py.json" 2>nul
if exist "%SCRIPT_DIR%\mcp_config_npx.json" del /f "%SCRIPT_DIR%\mcp_config_npx.json" 2>nul
if exist "%SCRIPT_DIR%\mcp_config_snippet.json" del /f "%SCRIPT_DIR%\mcp_config_snippet.json" 2>nul

echo.
echo   [OK] 삭제 완료! workspace 폴더는 보존됨.
echo   더 철저한 삭제는 UNINSTALL.bat을 사용하세요.
echo.
pause
exit /b 0

REM ============================================================
REM   [0] EXIT
REM ============================================================
:EXIT
echo.
echo   Goodbye!
exit /b 0
