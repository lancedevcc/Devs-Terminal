@echo off
REM ============================================
REM   UNIVERSAL LAUNCHER - Main Entry Point
REM ============================================

setlocal enabledelayedexpansion

:menu
cls
echo.
echo ============================================
echo   UNIVERSAL COMMAND LAUNCHER
echo ============================================
echo.
echo Choose your interface:
echo.
echo [1] Command Interface (Recommended - Fast)
echo [2] GUI Interface (Modern, visual)
echo [3] Advanced PowerShell Interface
echo [4] Quick Menu
echo [5] View Help
echo [6] Exit
echo.

set /p choice="Select (1-6): "

if "%choice%"=="1" (
    cmd /k "LAUNCHER.bat"
    goto menu
)

if "%choice%"=="2" (
    powershell -ExecutionPolicy Bypass -File LAUNCHER_GUI.ps1
    goto menu
)

if "%choice%"=="3" (
    powershell -ExecutionPolicy Bypass -File LAUNCHER_ADVANCED.ps1
    goto menu
)

if "%choice%"=="4" (
    cmd /k "MENU.bat"
    goto menu
)

if "%choice%"=="5" (
    if exist README.txt (
        start "" notepad README.txt
    ) else (
        echo Help file not found
        timeout /t 2 /nobreak
    )
    goto menu
)

if "%choice%"=="6" (
    exit /b
)

echo Invalid choice
timeout /t 2 /nobreak
goto menu
