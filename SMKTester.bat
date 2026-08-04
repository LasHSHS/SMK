@echo off
REM Launch SMK from source (run this from the project folder).
REM This black console window is intentional (python.exe): closing it closes SMK.
REM Minimize it if you don't want to see it.
set "SMK_ROOT=%~dp0"
cd /d "%SMK_ROOT%"
title Snapchat Memories Keeper

if not exist ".venv\Scripts\python.exe" (
    echo Creating virtual environment...
    py -3 -m venv .venv
    .venv\Scripts\python.exe -m pip install -q -r requirements.txt 2>nul
)

echo.
echo Starting SMK from source...
echo Log: smk_gui.log
echo.
echo Keep this window open while you use SMK. Minimize it if you want it out of the way.
echo Closing this window will close SMK ^(this SMK only - not other Python programs^).
echo.

".venv\Scripts\python.exe" "%SMK_ROOT%desktop_gui_pyqt.py"
set "ERR=%ERRORLEVEL%"

if not "%ERR%"=="0" (
    echo.
    echo SMK exited with an error ^(%ERR%^). Last log lines:
    echo.
    if exist "%SMK_ROOT%smk_gui.log" (
        powershell -NoProfile -Command "Get-Content '%SMK_ROOT%smk_gui.log' -Tail 30"
    ) else (
        echo ^(no log file yet^)
    )
    echo.
    pause
)
exit /b %ERR%
