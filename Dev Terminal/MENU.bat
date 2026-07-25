@echo off
REM ============================================
REM   QUICK START GUIDE
REM ============================================

:menu
cls
echo.
echo ============================================
echo   UNIVERSAL LAUNCHER - QUICK START
echo ============================================
echo.
echo What would you like to do?
echo.
echo [1] Launch GUI Interface (Recommended)
echo [2] Launch Command Interface
echo [3] Launch Advanced PowerShell Interface
echo [4] View Documentation
echo [5] Edit Custom Commands
echo [6] Exit
echo.

set /p choice="Select (1-6): "

if "%choice%"=="1" (
    powershell -ExecutionPolicy Bypass -File LAUNCHER_GUI.ps1
    goto menu
)

if "%choice%"=="2" (
    call LAUNCHER.bat
    goto menu
)

if "%choice%"=="3" (
    powershell -ExecutionPolicy Bypass -File LAUNCHER_ADVANCED.ps1
    goto menu
)

if "%choice%"=="4" (
    start notepad README.txt
    goto menu
)

if "%choice%"=="5" (
    start notepad CUSTOM.bat
    goto menu
)

if "%choice%"=="6" (
    exit /b
)

echo Invalid choice
timeout /t 2
goto menu
