@echo off
chcp 65001 >nul
title Curated Skills & Agent Manager Setup

echo ==========================================================
echo   🚀 Curated Skills & Agent Manager Setup
echo ==========================================================
echo.
echo [Step 1/2] Select Target AI Environment:
echo.
echo   [1] Auto-Detect & Sync ALL (Recommended)
echo       Automatically finds and installs to all installed AI tools:
echo       Google Antigravity, Claude Code, Cursor, and Windsurf.
echo.
echo   [2] Google Antigravity only  (%USERPROFILE%\.gemini\config\skills)
echo   [3] Claude Code only         (%USERPROFILE%\.claude\skills)
echo   [4] Cursor / Codex only      (%USERPROFILE%\.cursor\skills)
echo   [5] Windsurf only            (%USERPROFILE%\.windsurf\skills)
echo.
set "hostChoice="
set /p hostChoice="Select target [1-5] (Default: 1 - Auto-Detect): "

set "HOST_FLAG=-HostChoice auto"
if "%hostChoice%"=="2" set "HOST_FLAG=-HostChoice gemini"
if "%hostChoice%"=="3" set "HOST_FLAG=-HostChoice claude"
if "%hostChoice%"=="4" set "HOST_FLAG=-HostChoice cursor"
if "%hostChoice%"=="5" set "HOST_FLAG=-HostChoice windsurf"

echo.
echo ----------------------------------------------------------
echo [Step 2/2] Select Installation Mode:
echo.
echo   [1] Full Curated Pack (Recommended)
echo       Installs skill-manager + 8 curated skills + custom utilities.
echo.
echo   [2] Clean Slate (Empty Template)
echo       Installs ONLY the core skill-manager engine.
echo       Start with an empty catalog to build your own skills.
echo.
set "mode="
set /p mode="Select mode [1 or 2] (Default: 1): "

set "MODE_FLAG="
if "%mode%"=="2" (
    set "MODE_FLAG=-CleanTemplate"
    echo.
    echo Selected: Clean Slate Mode
) else (
    echo.
    echo Selected: Full Curated Pack
)
echo.
echo ==========================================================
echo Starting installation...
echo ==========================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" %HOST_FLAG% %MODE_FLAG%

echo.
echo ==========================================================
echo  Setup complete! Press any key to exit...
echo ==========================================================
pause >nul
