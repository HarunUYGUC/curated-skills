@echo off
chcp 65001 >nul
title Curated Skills & Agent Manager Setup

echo ==========================================================
echo   🚀 Curated Skills & Agent Manager Setup
echo ==========================================================
echo.
echo Choose your installation mode:
echo.
echo   [1] Full Curated Pack (Recommended)
echo       Installs skill-manager + 7 curated skills + push utility.
echo.
echo   [2] Clean Slate (Empty Template)
echo       Installs ONLY the core skill-manager engine.
echo       Start with an empty catalog to build your own skills.
echo.
set /p mode="Enter choice [1 or 2] (Default: 1): "

set "EXTRA_FLAGS="
if "%mode%"=="2" (
    set "EXTRA_FLAGS=-CleanTemplate"
    echo.
    echo Selected: Clean Slate Mode
) else (
    echo.
    echo Selected: Full Curated Pack
)
echo.

:: -------------------------------------------------------------------------
:: TARGET TOOL SELECTION:
:: To install to a different AI tool, remove the ":: " prefix from
:: your desired line below, and comment out the default line:
:: -------------------------------------------------------------------------

:: [1] Google Antigravity (Default):
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir "%USERPROFILE%\.gemini\config\skills" %EXTRA_FLAGS%

:: [2] Claude Code (Global Installation):
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir "%USERPROFILE%\.claude\skills" %EXTRA_FLAGS%

:: [3] Cursor / Codex (Current Project Level):
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir ".\.agents\skills" %EXTRA_FLAGS%

:: [4] Windsurf / OpenCode (Global Installation):
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir "%USERPROFILE%\.windsurf\skills" %EXTRA_FLAGS%

echo.
echo ==========================================================
echo  Setup complete! Press any key to exit...
echo ==========================================================
pause >nul
