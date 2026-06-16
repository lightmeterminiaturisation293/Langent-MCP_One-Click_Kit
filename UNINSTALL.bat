@echo off
setlocal EnableDelayedExpansion
title Langent v3 - Clean Uninstaller

REM ============================================================
REM   Langent v3 - Clean Uninstaller
REM   시스템/다른 프로그램에 영향 없이 깔끔하게 삭제
REM   삭제 대상: venv, langent, data, logs, 설정 파일
REM   보존 대상: Python, Git, 시스템 환경변수 (건드리지 않음)
REM ============================================================

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
cd /d "%SCRIPT_DIR%"

cls
echo.
echo ============================================================
echo   Langent v3 - Clean Uninstaller
echo ============================================================
echo   Location : %SCRIPT_DIR%
echo ============================================================
echo.

REM ============================================================
REM   현재 상태 표시
REM ============================================================
echo --- 삭제 대상 스캔 ----------------------------------------
echo.

set "HAS_VENV=0"
set "HAS_SRC=0"
set "HAS_DATA=0"
set "HAS_WS=0"
set "HAS_LOGS=0"
set "HAS_MCP=0"

if exist "%SCRIPT_DIR%\venv" (
    set "HAS_VENV=1"
    echo   [O] venv            가상환경 (pip 패키지 포함)
) else (
    echo   [-] venv            없음
)

if exist "%SCRIPT_DIR%\langent" (
    set "HAS_SRC=1"
    echo   [O] langent         소스코드
) else (
    echo   [-] langent         없음
)

if exist "%SCRIPT_DIR%\data" (
    set "HAS_DATA=1"
    echo   [O] data            ChromaDB 벡터 데이터
) else (
    echo   [-] data            없음
)

if exist "%SCRIPT_DIR%\workspace" (
    set "HAS_WS=1"
    set "WS_COUNT=0"
    for /f %%A in ('dir /b /s "%SCRIPT_DIR%\workspace" 2^>nul ^| find /c /v ""') do set WS_COUNT=%%A
    echo   [O] workspace       사용자 문서 (!WS_COUNT!개 파일)
) else (
    echo   [-] workspace       없음
)

if exist "%SCRIPT_DIR%\logs" (
    set "HAS_LOGS=1"
    echo   [O] logs            로그 파일
) else (
    echo   [-] logs            없음
)

set "MCP_EXISTS=0"
if exist "%SCRIPT_DIR%\mcp_config_py.json" set "MCP_EXISTS=1"
if exist "%SCRIPT_DIR%\mcp_config_npx.json" set "MCP_EXISTS=1"
if exist "%SCRIPT_DIR%\mcp_config_snippet.json" set "MCP_EXISTS=1"
if "%MCP_EXISTS%"=="1" (
    set "HAS_MCP=1"
    echo   [O] mcp_config*.json  MCP 설정 파일
) else (
    echo   [-] mcp_config*.json  없음
)

echo.

if "%HAS_VENV%%HAS_SRC%%HAS_DATA%%HAS_WS%%HAS_LOGS%%HAS_MCP%"=="000000" (
    echo   [INFO] 삭제할 항목이 없습니다. 이미 깨끗한 상태입니다.
    echo.
    pause
    exit /b 0
)

REM ============================================================
REM   최종 확인
REM ============================================================
echo ============================================================
echo   [WARNING] 삭제하면 되돌릴 수 없습니다!
echo   시스템 Python, Git 등 다른 프로그램에는 영향 없습니다.
echo ============================================================
echo.
set /p CONFIRM="  삭제를 진행하시겠습니까? (Y/N): "
if /i not "%CONFIRM%"=="Y" (
    echo.
    echo   [INFO] 취소되었습니다. 아무것도 삭제되지 않았습니다.
    echo.
    pause
    exit /b 0
)
echo.

REM ============================================================
REM   [1/7] 실행 중인 Langent 프로세스 종료
REM ============================================================
echo [1/7] 실행 중인 Langent 프로세스 종료...

for /f "tokens=5" %%p in ('netstat -aon 2^>nul ^| findstr ":8000" ^| findstr "LISTENING"') do (
    taskkill /PID %%p /F >nul 2>&1
    echo   [OK] PID %%p 종료됨 (포트 8000)
)

if exist "%SCRIPT_DIR%\venv\Scripts\python.exe" (
    for /f "tokens=2" %%p in ('tasklist /FI "IMAGENAME eq python.exe" /FO LIST 2^>nul ^| findstr "PID"') do (
        wmic process where "ProcessId=%%p" get ExecutablePath 2>nul | findstr /i "%SCRIPT_DIR%" >nul 2>&1
        if !ERRORLEVEL! EQU 0 (
            taskkill /PID %%p /F >nul 2>&1
            echo   [OK] Python PID %%p 종료됨
        )
    )
)

call deactivate >nul 2>&1
echo   [OK] 프로세스 정리 완료

REM ============================================================
REM   [2/7] 가상환경 삭제
REM ============================================================
echo.
echo [2/7] 가상환경(venv) 삭제...

if "%HAS_VENV%"=="1" (
    rmdir /s /q "%SCRIPT_DIR%\venv" 2>nul
    if exist "%SCRIPT_DIR%\venv" (
        echo   [WARNING] 파일 잠김. 재시도...
        timeout /t 2 /nobreak >nul
        rmdir /s /q "%SCRIPT_DIR%\venv" 2>nul
    )
    if not exist "%SCRIPT_DIR%\venv" (
        echo   [OK] venv 삭제 완료
    ) else (
        echo   [WARNING] 수동 삭제 필요: %SCRIPT_DIR%\venv
    )
) else (
    echo   [SKIP]
)

REM ============================================================
REM   [3/7] 소스코드 삭제
REM ============================================================
echo.
echo [3/7] 소스코드(langent) 삭제...

if "%HAS_SRC%"=="1" (
    rmdir /s /q "%SCRIPT_DIR%\langent" 2>nul
    if not exist "%SCRIPT_DIR%\langent" (
        echo   [OK] langent 삭제 완료
    ) else (
        echo   [WARNING] 수동 삭제 필요: %SCRIPT_DIR%\langent
    )
) else (
    echo   [SKIP]
)

REM ============================================================
REM   [4/7] ChromaDB 데이터 삭제
REM ============================================================
echo.
echo [4/7] ChromaDB 벡터 데이터(data) 삭제...

if "%HAS_DATA%"=="1" (
    rmdir /s /q "%SCRIPT_DIR%\data" 2>nul
    if not exist "%SCRIPT_DIR%\data" (
        echo   [OK] data 삭제 완료
    ) else (
        echo   [WARNING] 수동 삭제 필요: %SCRIPT_DIR%\data
    )
) else (
    echo   [SKIP]
)

REM ============================================================
REM   [5/7] 워크스페이스 (사용자 선택)
REM ============================================================
echo.
if "%HAS_WS%"=="1" (
    echo [5/7] workspace 폴더에 사용자 문서 %WS_COUNT%개가 있습니다.
    set /p DEL_WS="  workspace도 삭제하시겠습니까? (Y/N): "
    if /i "!DEL_WS!"=="Y" (
        rmdir /s /q "%SCRIPT_DIR%\workspace" 2>nul
        if not exist "%SCRIPT_DIR%\workspace" (
            echo   [OK] workspace 삭제 완료
        ) else (
            echo   [WARNING] 수동 삭제 필요: %SCRIPT_DIR%\workspace
        )
    ) else (
        echo   [SKIP] workspace 보존됨
    )
) else (
    echo [5/7] workspace 없음 [SKIP]
)

REM ============================================================
REM   [6/7] 로그 및 설정 파일 삭제
REM ============================================================
echo.
echo [6/7] 로그 및 설정 파일 삭제...

if exist "%SCRIPT_DIR%\logs" (
    rmdir /s /q "%SCRIPT_DIR%\logs" 2>nul
    echo   [OK] logs 삭제됨
)

if exist "%SCRIPT_DIR%\mcp_config_py.json" (
    del /f /q "%SCRIPT_DIR%\mcp_config_py.json" 2>nul
    echo   [OK] mcp_config_py.json 삭제됨
)
if exist "%SCRIPT_DIR%\mcp_config_npx.json" (
    del /f /q "%SCRIPT_DIR%\mcp_config_npx.json" 2>nul
    echo   [OK] mcp_config_npx.json 삭제됨
)
if exist "%SCRIPT_DIR%\mcp_config_snippet.json" (
    del /f /q "%SCRIPT_DIR%\mcp_config_snippet.json" 2>nul
    echo   [OK] mcp_config_snippet.json 삭제됨
)

echo   [OK] 정리 완료

REM ============================================================
REM   [7/7] 삭제 확인
REM ============================================================
echo.
echo [7/7] 삭제 결과 확인...
echo.

set "REMAIN=0"
if exist "%SCRIPT_DIR%\venv"      (echo   [!] venv 잔존 & set "REMAIN=1")
if exist "%SCRIPT_DIR%\langent"   (echo   [!] langent 잔존 & set "REMAIN=1")
if exist "%SCRIPT_DIR%\data"      (echo   [!] data 잔존 & set "REMAIN=1")
if exist "%SCRIPT_DIR%\logs"      (echo   [!] logs 잔존 & set "REMAIN=1")

if "%REMAIN%"=="0" (
    echo   [OK] 모든 항목이 깔끔하게 삭제되었습니다.
)

echo.
echo ============================================================
echo   삭제 완료!
echo ============================================================
echo.
echo   삭제된 항목:
echo     - Python 가상환경 (venv)
echo     - Langent 소스코드
echo     - ChromaDB 벡터 데이터
echo     - 로그 및 MCP 설정 파일
echo.
echo   영향 없는 항목:
echo     - 시스템 Python            그대로
echo     - 시스템 pip 패키지        그대로
echo     - Git                      그대로
echo     - 환경변수 / 레지스트리    변경 없음
echo     - 다른 프로그램            영향 없음
echo.
echo   BAT 파일(INSTALL/RUN/UNINSTALL)은 수동으로 삭제해 주세요.
echo   이 폴더 전체를 삭제해도 안전합니다.
echo ============================================================
echo.
pause
exit /b 0
