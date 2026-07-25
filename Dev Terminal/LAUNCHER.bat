@echo off
REM ============================================
REM   UNIVERSAL COMMAND LAUNCHER
REM   Do anything - open apps, websites, run commands
REM ============================================

setlocal enabledelayedexpansion

:main_menu
cls
echo.
echo ============================================
echo   UNIVERSAL COMMAND LAUNCHER
echo ============================================
echo.
echo Main Menu:
echo [1] Open Application
echo [2] Open Website
echo [3] Run Command/Script
echo [4] File Operations
echo [5] System Tools
echo [6] Custom Commands
echo [7] Settings/Help
echo [8] Exit
echo.

set /p choice="Select option (1-8): "

if "%choice%"=="1" goto open_app
if "%choice%"=="2" goto open_website
if "%choice%"=="3" goto run_command
if "%choice%"=="4" goto file_ops
if "%choice%"=="5" goto system_tools
if "%choice%"=="6" goto custom_cmd
if "%choice%"=="7" goto settings
if "%choice%"=="8" goto eof

echo Invalid choice. Please enter 1-8.
timeout /t 2 /nobreak
goto main_menu

:open_app
cls
echo.
echo ============================================
echo   OPEN APPLICATION
echo ============================================
echo.
echo Quick Apps:
echo [1] Chrome              [6] Command Prompt
echo [2] Firefox             [7] PowerShell
echo [3] Notepad             [8] Visual Studio Code
echo [4] File Explorer       [9] Calculator
echo [5] Settings           [10] Paint
echo.
echo [11] Custom App         [0] Back
echo.

set /p app="Enter choice or app name: "

if "%app%"=="0" goto main_menu
if "%app%"=="1" start "" chrome 2>nul
if "%app%"=="2" start "" firefox 2>nul
if "%app%"=="3" start "" notepad
if "%app%"=="4" start "" explorer
if "%app%"=="5" start "" ms-settings:
if "%app%"=="6" start "" cmd
if "%app%"=="7" start "" powershell
if "%app%"=="8" start "" code 2>nul
if "%app%"=="9" start "" calc
if "%app%"=="10" start "" mspaint

if "%app%"=="11" (
    set /p custom_app="Enter app name or path: "
    start "" !custom_app! 2>nul
    if errorlevel 1 echo App not found or error occurred
    timeout /t 2 /nobreak
    goto main_menu
)

echo Launching application...
timeout /t 1 /nobreak
goto main_menu

:open_website
cls
echo.
echo ============================================
echo   OPEN WEBSITE
echo ============================================
echo.
echo Popular Sites:
echo [1] Google              [6] Twitter/X
echo [2] YouTube             [7] Reddit
echo [3] GitHub              [8] Wikipedia
echo [4] Stack Overflow      [9] LinkedIn
echo [5] ChatGPT            [10] Gmail
echo.
echo [11] Custom URL         [0] Back
echo.

set /p site="Enter choice: "

if "%site%"=="0" goto main_menu
if "%site%"=="1" start "" https://google.com
if "%site%"=="2" start "" https://youtube.com
if "%site%"=="3" start "" https://github.com
if "%site%"=="4" start "" https://stackoverflow.com
if "%site%"=="5" start "" https://chatgpt.com
if "%site%"=="6" start "" https://x.com
if "%site%"=="7" start "" https://reddit.com
if "%site%"=="8" start "" https://wikipedia.org
if "%site%"=="9" start "" https://linkedin.com
if "%site%"=="10" start "" https://mail.google.com

if "%site%"=="11" (
    set /p url="Enter URL (with https:// or http://): "
    if "!url:~0,4!" NEQ "http" (
        set url=https://!url!
    )
    start "" !url!
)

echo Opening website...
timeout /t 1 /nobreak
goto main_menu

:run_command
cls
echo.
echo ============================================
echo   RUN COMMAND
echo ============================================
echo.
echo [1] System Info         [5] Check RAM Usage
echo [2] Disk Space          [6] List Installed Apps
echo [3] IP Configuration    [7] Network Status
echo [4] List Processes      [8] Custom Command
echo.
echo [0] Back
echo.

set /p cmd="Enter choice: "

if "%cmd%"=="0" goto main_menu

if "%cmd%"=="1" (
    cls
    echo System Information:
    echo.
    systeminfo | findstr /C:"Computer Name" /C:"OS Name" /C:"System Boot Time" /C:"Total Physical Memory"
    echo.
    timeout /t 5 /nobreak
    goto main_menu
)

if "%cmd%"=="2" (
    cls
    echo Disk Space:
    echo.
    wmic logicaldisk get name,size,freespace 2>nul || (
        echo Disk info not available
    )
    echo.
    timeout /t 5 /nobreak
    goto main_menu
)

if "%cmd%"=="3" (
    cls
    echo IP Configuration:
    echo.
    ipconfig
    echo.
    timeout /t 10 /nobreak
    goto main_menu
)

if "%cmd%"=="4" (
    cls
    echo Running Processes:
    echo.
    tasklist | more
    echo.
    timeout /t 10 /nobreak
    goto main_menu
)

if "%cmd%"=="5" (
    cls
    echo Memory Usage:
    echo.
    wmic OS get TotalVisibleMemorySize,FreePhysicalMemory 2>nul || (
        echo Memory info not available
    )
    echo.
    timeout /t 5 /nobreak
    goto main_menu
)

if "%cmd%"=="6" (
    cls
    echo Installed Applications:
    echo.
    wmic product list brief 2>nul | more || (
        echo Application list not available
    )
    echo.
    timeout /t 10 /nobreak
    goto main_menu
)

if "%cmd%"=="7" (
    cls
    echo Network Status:
    echo.
    ipconfig /all | findstr /C:"Ethernet" /C:"WiFi" /C:"IPv4" /C:"Physical Address"
    echo.
    timeout /t 5 /nobreak
    goto main_menu
)

if "%cmd%"=="8" (
    set /p custom_cmd="Enter command: "
    cls
    echo Running: !custom_cmd!
    echo.
    !custom_cmd! 2>nul || echo Error executing command
    echo.
    timeout /t 5 /nobreak
    goto main_menu
)

goto main_menu

:file_ops
cls
echo.
echo ============================================
echo   FILE OPERATIONS
echo ============================================
echo.
echo [1] Open Desktop        [6] Create Folder
echo [2] Open Documents      [7] Open File
echo [3] Open Downloads      [8] Delete File
echo [4] Open Pictures       [9] Copy File
echo [5] Open Custom Folder [10] Navigate Drive
echo.
echo [0] Back
echo.

set /p fop="Enter choice: "

if "%fop%"=="0" goto main_menu
if "%fop%"=="1" (start "" "%USERPROFILE%\Desktop" & goto main_menu)
if "%fop%"=="2" (start "" "%USERPROFILE%\Documents" & goto main_menu)
if "%fop%"=="3" (start "" "%USERPROFILE%\Downloads" & goto main_menu)
if "%fop%"=="4" (start "" "%USERPROFILE%\Pictures" & goto main_menu)

if "%fop%"=="5" (
    set /p folder="Enter folder path: "
    start "" !folder! 2>nul || echo Folder not found
    timeout /t 2 /nobreak
    goto main_menu
)

if "%fop%"=="6" (
    set /p newfolder="Enter folder path and name (e.g., C:\MyFolder): "
    mkdir !newfolder! 2>nul
    if errorlevel 1 (
        echo Error creating folder
    ) else (
        echo Folder created: !newfolder!
    )
    timeout /t 2 /nobreak
    goto main_menu
)

if "%fop%"=="7" (
    set /p filepath="Enter file path to open: "
    start "" !filepath! 2>nul || echo File not found
    timeout /t 2 /nobreak
    goto main_menu
)

if "%fop%"=="8" (
    set /p delfile="Enter file to delete: "
    del !delfile! 2>nul
    if errorlevel 1 (
        echo Error deleting file or file not found
    ) else (
        echo File deleted
    )
    timeout /t 2 /nobreak
    goto main_menu
)

if "%fop%"=="9" (
    set /p source="Enter source file: "
    set /p dest="Enter destination: "
    copy "!source!" "!dest!" 2>nul
    if errorlevel 1 (
        echo Error copying file
    ) else (
        echo File copied
    )
    timeout /t 2 /nobreak
    goto main_menu
)

if "%fop%"=="10" (
    set /p drive="Enter drive letter (C, D, E, etc.): "
    start "" !drive!:\ 2>nul || echo Drive not found
    timeout /t 2 /nobreak
    goto main_menu
)

goto main_menu

:system_tools
cls
echo.
echo ============================================
echo   SYSTEM TOOLS
echo ============================================
echo.
echo [1] Task Manager         [7] Display Settings
echo [2] Device Manager       [8] Sound Settings
echo [3] Services             [9] Update Settings
echo [4] System Properties   [10] Network Settings
echo [5] Settings            [11] Storage Settings
echo [6] Control Panel       [12] Power Settings
echo.
echo [0] Back
echo.

set /p tool="Enter choice: "

if "%tool%"=="0" goto main_menu
if "%tool%"=="1" (taskmgr & goto main_menu)
if "%tool%"=="2" (devmgmt.msc & goto main_menu)
if "%tool%"=="3" (services.msc & goto main_menu)
if "%tool%"=="4" (sysdm.cpl & goto main_menu)
if "%tool%"=="5" (start "" ms-settings: & goto main_menu)
if "%tool%"=="6" (control & goto main_menu)
if "%tool%"=="7" (start "" ms-settings:display & goto main_menu)
if "%tool%"=="8" (start "" ms-settings:sound & goto main_menu)
if "%tool%"=="9" (start "" ms-settings:windowsupdate & goto main_menu)
if "%tool%"=="10" (ncpa.cpl & goto main_menu)
if "%tool%"=="11" (start "" ms-settings:storagesense & goto main_menu)
if "%tool%"=="12" (start "" ms-settings:powersleep & goto main_menu)

goto main_menu

:custom_cmd
cls
echo.
echo ============================================
echo   CUSTOM COMMANDS
echo ============================================
echo.
echo Edit CUSTOM.bat to add your own commands!
echo.
echo [1] Edit Custom Commands
echo [2] Run Custom Commands (if any)
echo [0] Back
echo.

set /p custom="Enter choice: "

if "%custom%"=="0" goto main_menu
if "%custom%"=="1" (start "" notepad "CUSTOM.bat" & goto main_menu)
if "%custom%"=="2" (
    if exist CUSTOM.bat (
        cls
        echo Running custom commands...
        call CUSTOM.bat
        timeout /t 2 /nobreak
    ) else (
        echo No custom commands file found
        timeout /t 2 /nobreak
    )
)

goto main_menu

:settings
cls
echo.
echo ============================================
echo   HELP & SETTINGS
echo ============================================
echo.
echo [1] View Documentation
echo [2] View Quick Start
echo [3] Edit Launcher
echo [4] Check System Info
echo [0] Back
echo.

set /p setting="Enter choice: "

if "%setting%"=="0" goto main_menu
if "%setting%"=="1" (start "" notepad README.txt & goto main_menu)
if "%setting%"=="2" (start "" notepad QUICKSTART.txt & goto main_menu)
if "%setting%"=="3" (start "" notepad LAUNCHER.bat & goto main_menu)
if "%setting%"=="4" (
    cls
    echo Windows System Information:
    echo.
    ver
    echo.
    timeout /t 3 /nobreak
    goto main_menu
)

goto main_menu

goto main_menu

:eof
echo.
echo Goodbye!
timeout /t 1 /nobreak
exit /b
