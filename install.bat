@echo off
chcp 65001 >nul
title Curated Skills Installer

echo ==========================================================
echo  Starting Curated Skills Auto-Installer...
echo ==========================================================
echo.

:: -------------------------------------------------------------------------
:: TARGET TOOL SELECTION:
:: To install to a different AI tool, remove the ":: " prefix from
:: your desired line below, and comment out the default line:
:: -------------------------------------------------------------------------

:: [1] Google Antigravity (Default):
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir "%USERPROFILE%\.gemini\config\skills"

:: [2] Claude Code (Global Installation):
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir "%USERPROFILE%\.claude\skills"

:: [3] Cursor / Codex (Current Project Level):
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir ".\.agents\skills"

:: [4] Windsurf / OpenCode (Global Installation):
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -TargetDir "%USERPROFILE%\.windsurf\skills"

echo.
echo ==========================================================
echo  Installation complete! Press any key to exit...
echo ==========================================================
pause >nul
