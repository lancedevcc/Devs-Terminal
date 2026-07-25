# Advanced Universal Launcher - Enhanced PowerShell Version
# Run with: powershell -ExecutionPolicy Bypass -File LAUNCHER_ADVANCED.ps1
# Features: Auto-detect apps, frequency tracking, modern UI, 27+ apps & games

$ErrorActionPreference = "SilentlyContinue"
$appFrequency = @{}
$appFrequencyFile = "$PSScriptRoot\app_frequency.json"

# Load app frequency data
if (Test-Path $appFrequencyFile) {
    $appFrequency = Get-Content $appFrequencyFile | ConvertFrom-Json -AsHashtable
}

# Save app frequency data
function Save-AppFrequency {
    $appFrequency | ConvertTo-Json | Set-Content $appFrequencyFile
}

# Track app usage
function Track-App {
    param([string]$AppName)
    if ($appFrequency.ContainsKey($AppName)) {
        $appFrequency[$AppName]++
    } else {
        $appFrequency[$AppName] = 1
    }
    Save-AppFrequency
}

# Get most frequently used apps
function Get-FrequentApps {
    $appFrequency.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5 | ForEach-Object { $_.Key }
}

# Detect installed applications
function Get-InstalledApps {
    $apps = @()
    $programFiles = @("C:\Program Files", "C:\Program Files (x86)")
    
    foreach ($path in $programFiles) {
        if (Test-Path $path) {
            Get-ChildItem $path -Directory | ForEach-Object {
                $exeFiles = Get-ChildItem $_.FullName -Filter "*.exe" -Recurse -Depth 2 | Select-Object -First 1
                if ($exeFiles) {
                    $apps += @{Name = $_.Name; Path = $exeFiles.FullName}
                }
            }
        }
    }
    return $apps | Select-Object -Unique
}

function Show-Header {
    Clear-Host
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║             UNIVERSAL COMMAND LAUNCHER - ADVANCED              ║" -ForegroundColor Cyan
    Write-Host "║                  Auto-Detect Applications                       ║" -ForegroundColor Cyan
    Write-Host "║                  Usage Tracking Enabled                         ║" -ForegroundColor Cyan
    Write-Host "║                                                                ║" -ForegroundColor Cyan
    Write-Host "║          Type ANY app/game name or path to launch it!           ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Show-MainMenu {
    Show-Header
    Write-Host "┌─ MAIN MENU ─────────────────────────────────────────────────────┐" -ForegroundColor Yellow
    Write-Host "│  [1] Open Application          [7] Network Tools              │" -ForegroundColor Yellow
    Write-Host "│  [2] Open Website              [8] Developer Tools            │" -ForegroundColor Yellow
    Write-Host "│  [3] Run Command/Script        [9] Quick Start Apps           │" -ForegroundColor Yellow
    Write-Host "│  [4] File Manager              [10] Games AND Entertainment   │" -ForegroundColor Yellow
    Write-Host "│  [5] System Tools              [11] Settings                  │" -ForegroundColor Yellow
    Write-Host "│  [6] Process Management        [12] Exit                      │" -ForegroundColor Yellow
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Yellow
    Write-Host ""
}

function Open-Application {
    Show-Header
    Write-Host "┌─ APPLICATIONS ──────────────────────────────────────────────────┐" -ForegroundColor Green
    Write-Host "│ 26 Popular Apps and Games:                                       │" -ForegroundColor Green
    
    $popularApps = @(
        @{Name="Chrome"; Path="chrome"},
        @{Name="Firefox"; Path="firefox"},
        @{Name="Edge"; Path="msedge"},
        @{Name="Discord"; Path="Discord.exe"},
        @{Name="Roblox"; Path="Roblox.exe"},
        @{Name="Steam"; Path="steam.exe"},
        @{Name="Epic Games"; Path="EpicGamesLauncher.exe"},
        @{Name="Notepad"; Path="notepad"},
        @{Name="Notepad Plus Plus"; Path="notepad++"},
        @{Name="VS Code"; Path="code"},
        @{Name="Visual Studio"; Path="devenv"},
        @{Name="PowerShell"; Path="powershell"},
        @{Name="Command Prompt"; Path="cmd"},
        @{Name="Task Manager"; Path="taskmgr"},
        @{Name="Settings"; Path="ms-settings:"},
        @{Name="File Explorer"; Path="explorer"},
        @{Name="Paint"; Path="mspaint"},
        @{Name="Calculator"; Path="calc"},
        @{Name="WordPad"; Path="write"},
        @{Name="Control Panel"; Path="control"},
        @{Name="Outlook"; Path="outlook.exe"},
        @{Name="Teams"; Path="Teams.exe"},
        @{Name="VLC Media Player"; Path="vlc"},
        @{Name="Spotify"; Path="Spotify.exe"},
        @{Name="Photos"; Path="ms-photos:"},
        @{Name="Movies AND TV"; Path="ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"}
    )
    
    $i = 1
    foreach ($app in $popularApps) {
        Write-Host "│  [$($i.ToString('D2'))]  $($app.Name)" -ForegroundColor Green
        $i++
    }
    
    Write-Host "│                                                                  │" -ForegroundColor Green
    Write-Host "│  [A] Show All Installed Applications                             │" -ForegroundColor Green
    Write-Host "│  [F] Frequently Used Apps                                        │" -ForegroundColor Green
    Write-Host "│  [C] Custom (type app name)                                      │" -ForegroundColor Green
    Write-Host "│  [0] Back                                                        │" -ForegroundColor Green
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Green
    Write-Host ""
    
    $choice = Read-Host "Select app"
    
    if ($choice -eq "0") { return }
    
    if ($choice -eq "A") {
        Write-Host ""
        Write-Host "Scanning for installed applications..." -ForegroundColor Yellow
        $installed = Get-InstalledApps
        if ($installed.Count -gt 0) {
            $installed | Select-Object -First 30 | ForEach-Object {
                Write-Host "  * $($_.Name)" -ForegroundColor Cyan
            }
            Write-Host "  ... and more" -ForegroundColor Gray
        } else {
            Write-Host "  No additional applications found" -ForegroundColor Gray
        }
        Write-Host ""
        Read-Host "Press Enter to continue"
        return
    }
    
    if ($choice -eq "F") {
        Write-Host ""
        Write-Host "Your Frequently Used Apps:" -ForegroundColor Yellow
        $freq = Get-FrequentApps
        if ($freq) {
            $freq | ForEach-Object { Write-Host "  * $_" -ForegroundColor Cyan }
        } else {
            Write-Host "  No usage history yet" -ForegroundColor Gray
        }
        Write-Host ""
        Read-Host "Press Enter to continue"
        return
    }
    
    if ($choice -eq "C") {
        $customApp = Read-Host "Enter application name or path"
        if ($customApp) {
            Try {
                Start-Process $customApp -ErrorAction Stop
                Track-App $customApp
                Write-Host "SUCCESS: Launching $customApp" -ForegroundColor Green
                Start-Sleep -Milliseconds 500
            } Catch {
                Write-Host "ERROR: Could not launch $customApp" -ForegroundColor Red
                Read-Host "Press Enter to continue"
            }
        }
        return
    }
    
    if ($choice -match "^\d+$") {
        $index = [int]$choice - 1
        if ($index -ge 0 -and $index -lt $popularApps.Count) {
            $app = $popularApps[$index]
            Track-App $app.Name
            Try {
                if ($app.Path -like "ms-*") {
                    Start-Process $app.Path -ErrorAction Stop
                } else {
                    Start-Process $app.Path -ErrorAction Stop
                }
                Write-Host "SUCCESS: Launching $($app.Name)" -ForegroundColor Green
                Start-Sleep -Milliseconds 500
            } Catch {
                Write-Host "ERROR: Application not found or not installed" -ForegroundColor Red
                Read-Host "Press Enter to continue"
            }
        }
    }
}

function Open-Website {
    Show-Header
    Write-Host "┌─ WEBSITES ──────────────────────────────────────────────────────┐" -ForegroundColor Green
    
    $sites = @(
        @{Name="Google"; URL="https://google.com"},
        @{Name="YouTube"; URL="https://youtube.com"},
        @{Name="GitHub"; URL="https://github.com"},
        @{Name="Stack Overflow"; URL="https://stackoverflow.com"},
        @{Name="ChatGPT"; URL="https://chatgpt.com"},
        @{Name="Reddit"; URL="https://reddit.com"},
        @{Name="Twitter/X"; URL="https://x.com"},
        @{Name="Wikipedia"; URL="https://wikipedia.org"},
        @{Name="LinkedIn"; URL="https://linkedin.com"},
        @{Name="Facebook"; URL="https://facebook.com"},
        @{Name="Instagram"; URL="https://instagram.com"},
        @{Name="Gmail"; URL="https://mail.google.com"},
        @{Name="Twitch"; URL="https://twitch.tv"},
        @{Name="Spotify"; URL="https://spotify.com"},
        @{Name="Netflix"; URL="https://netflix.com"},
        @{Name="IMDb"; URL="https://imdb.com"},
        @{Name="Google Drive"; URL="https://drive.google.com"},
        @{Name="Pinterest"; URL="https://pinterest.com"},
        @{Name="Amazon"; URL="https://amazon.com"},
        @{Name="eBay"; URL="https://ebay.com"}
    )
    
    $i = 1
    foreach ($site in $sites) {
        Write-Host "│  [$($i.ToString('D2'))]  $($site.Name)" -ForegroundColor Green
        $i++
    }
    
    Write-Host "│                                                                  │" -ForegroundColor Green
    Write-Host "│  [C] Custom URL                                                  │" -ForegroundColor Green
    Write-Host "│  [0] Back                                                        │" -ForegroundColor Green
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Green
    Write-Host ""
    
    $choice = Read-Host "Select website"
    
    if ($choice -eq "0") { return }
    
    if ($choice -eq "C") {
        $url = Read-Host "Enter URL"
        if ($url -notmatch "^https?://") {
            $url = "https://$url"
        }
        Start-Process $url
        Write-Host "SUCCESS: Opening website..." -ForegroundColor Green
        return
    }
    
    if ($choice -match "^\d+$") {
        $index = [int]$choice - 1
        if ($index -ge 0 -and $index -lt $sites.Count) {
            Start-Process $sites[$index].URL
            Write-Host "SUCCESS: Opening $($sites[$index].Name)" -ForegroundColor Green
        }
    }
}

function Run-Command {
    Show-Header
    Write-Host "┌─ RUN COMMAND ───────────────────────────────────────────────────┐" -ForegroundColor Yellow
    Write-Host "│  Examples: Get-Process, ipconfig, dir, systeminfo, wmic          │" -ForegroundColor Yellow
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Yellow
    Write-Host ""
    
    $cmd = Read-Host "Enter command"
    
    if ($cmd -eq "") { return }
    
    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host "OUTPUT:" -ForegroundColor Yellow
    Write-Host "────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host ""
    
    try {
        Invoke-Expression $cmd | Out-Host
    } catch {
        Write-Host "ERROR: $_" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function File-Manager {
    Show-Header
    Write-Host "┌─ FILE MANAGER ──────────────────────────────────────────────────┐" -ForegroundColor Cyan
    Write-Host "│  [1] This PC / C Drive                                           │" -ForegroundColor Cyan
    Write-Host "│  [2] Home / User Profile                                         │" -ForegroundColor Cyan
    Write-Host "│  [3] Desktop                                                     │" -ForegroundColor Cyan
    Write-Host "│  [4] Documents                                                   │" -ForegroundColor Cyan
    Write-Host "│  [5] Downloads                                                   │" -ForegroundColor Cyan
    Write-Host "│  [6] Pictures                                                    │" -ForegroundColor Cyan
    Write-Host "│  [7] Music                                                       │" -ForegroundColor Cyan
    Write-Host "│  [8] Videos                                                      │" -ForegroundColor Cyan
    Write-Host "│  [9] Custom Folder                                               │" -ForegroundColor Cyan
    Write-Host "│  [0] Back                                                        │" -ForegroundColor Cyan
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
    Write-Host ""
    
    $choice = Read-Host "Select"
    
    $paths = @{
        "1" = "C:\"
        "2" = "$env:USERPROFILE"
        "3" = "$env:USERPROFILE\Desktop"
        "4" = "$env:USERPROFILE\Documents"
        "5" = "$env:USERPROFILE\Downloads"
        "6" = "$env:USERPROFILE\Pictures"
        "7" = "$env:USERPROFILE\Music"
        "8" = "$env:USERPROFILE\Videos"
    }
    
    if ($choice -eq "9") {
        $folder = Read-Host "Enter folder path"
        if (Test-Path $folder) {
            Start-Process explorer $folder
            Write-Host "SUCCESS: Opening folder..." -ForegroundColor Green
        } else {
            Write-Host "ERROR: Folder not found" -ForegroundColor Red
            Read-Host "Press Enter to continue"
        }
    } elseif ($paths.Contains($choice)) {
        Start-Process explorer $paths[$choice]
        Write-Host "SUCCESS: Opening folder..." -ForegroundColor Green
    }
}

function System-Tools {
    Show-Header
    Write-Host "┌─ SYSTEM TOOLS ──────────────────────────────────────────────────┐" -ForegroundColor Magenta
    Write-Host "│  [1] System Information             [7] Display Settings        │" -ForegroundColor Magenta
    Write-Host "│  [2] Task Manager                   [8] Sound Settings          │" -ForegroundColor Magenta
    Write-Host "│  [3] Device Manager                 [9] Update Settings         │" -ForegroundColor Magenta
    Write-Host "│  [4] Services                      [10] Network Settings        │" -ForegroundColor Magenta
    Write-Host "│  [5] Disk Management               [11] Security Settings       │" -ForegroundColor Magenta
    Write-Host "│  [6] Event Viewer                  [12] Power Settings          │" -ForegroundColor Magenta
    Write-Host "│  [0] Back                                                       │" -ForegroundColor Magenta
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Magenta
    Write-Host ""
    
    $choice = Read-Host "Select"
    
    switch ($choice) {
        "1" { msinfo32 }
        "2" { taskmgr }
        "3" { devmgmt.msc }
        "4" { services.msc }
        "5" { diskmgmt.msc }
        "6" { eventvwr.msc }
        "7" { Start-Process "ms-settings:display" }
        "8" { Start-Process "ms-settings:sound" }
        "9" { Start-Process "ms-settings:windowsupdate" }
        "10" { ncpa.cpl }
        "11" { Start-Process "ms-settings:privacy" }
        "12" { Start-Process "ms-settings:powersleep" }
    }
}

function Process-Manager {
    Show-Header
    Write-Host "┌─ PROCESS MANAGEMENT ────────────────────────────────────────────┐" -ForegroundColor Yellow
    Write-Host "│  [1] List Running Processes                                     │" -ForegroundColor Yellow
    Write-Host "│  [2] Kill Process by Name                                       │" -ForegroundColor Yellow
    Write-Host "│  [3] System Performance                                         │" -ForegroundColor Yellow
    Write-Host "│  [4] Memory Usage                                               │" -ForegroundColor Yellow
    Write-Host "│  [0] Back                                                       │" -ForegroundColor Yellow
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Yellow
    Write-Host ""
    
    $choice = Read-Host "Select"
    
    switch ($choice) {
        "1" {
            Write-Host ""
            Write-Host "Top 30 Running Processes:" -ForegroundColor Green
            Write-Host ""
            Get-Process | Select-Object Name, Id, @{Name="Memory (MB)"; Expression={[math]::Round($_.WorkingSet64/1MB, 2)}} | Sort-Object "Memory (MB)" -Descending | Select-Object -First 30 | Format-Table -AutoSize
            Read-Host "Press Enter to continue"
        }
        "2" {
            $name = Read-Host "Enter process name (or part of it)"
            $procs = Get-Process -Name "*$name*" -ErrorAction SilentlyContinue
            if ($procs) {
                $procs | ForEach-Object {
                    Write-Host "Stopping: $($_.Name) (PID: $($_.Id))" -ForegroundColor Yellow
                    Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
                }
                Write-Host "SUCCESS: Process(es) stopped" -ForegroundColor Green
            } else {
                Write-Host "ERROR: Process not found" -ForegroundColor Red
            }
            Read-Host "Press Enter to continue"
        }
        "3" {
            Write-Host ""
            Write-Host "System Performance:" -ForegroundColor Green
            $cpuUsage = (Get-WmiObject Win32_Processor).LoadPercentage
            $memUsage = Get-WmiObject Win32_LogicalMemoryConfiguration | Select-Object @{Name="MemoryUsage"; Expression={[math]::Round((Get-WmiObject Win32_OperatingSystem).TotalVisibleMemorySize - (Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory) / (Get-WmiObject Win32_LogicalMemoryConfiguration).TotalPhysicalMemory * 100, 2)}}
            Write-Host "  CPU Usage: $cpuUsage%" -ForegroundColor Cyan
            Write-Host "  Memory: See output above" -ForegroundColor Cyan
            Read-Host "Press Enter to continue"
        }
        "4" {
            Write-Host ""
            Write-Host "Memory Information:" -ForegroundColor Green
            $os = Get-WmiObject Win32_OperatingSystem
            $totalMemory = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
            $freeMemory = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
            $usedMemory = $totalMemory - $freeMemory
            Write-Host "  Total Memory: $totalMemory MB" -ForegroundColor Cyan
            Write-Host "  Used Memory: $usedMemory MB" -ForegroundColor Yellow
            Write-Host "  Free Memory: $freeMemory MB" -ForegroundColor Green
            Write-Host "  Usage: $([math]::Round(($usedMemory / $totalMemory) * 100, 2))%" -ForegroundColor White
            Read-Host "Press Enter to continue"
        }
    }
}

function Network-Tools {
    Show-Header
    Write-Host "┌─ NETWORK TOOLS ─────────────────────────────────────────────────┐" -ForegroundColor Blue
    Write-Host "│  [1] IP Configuration                                            │" -ForegroundColor Blue
    Write-Host "│  [2] Ping Host                                                   │" -ForegroundColor Blue
    Write-Host "│  [3] Network Settings                                            │" -ForegroundColor Blue
    Write-Host "│  [4] Network Adapters                                            │" -ForegroundColor Blue
    Write-Host "│  [5] Network Statistics                                          │" -ForegroundColor Blue
    Write-Host "│  [0] Back                                                        │" -ForegroundColor Blue
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Blue
    Write-Host ""
    
    $choice = Read-Host "Select"
    
    switch ($choice) {
        "1" {
            Write-Host ""
            Write-Host "IP Configuration:" -ForegroundColor Green
            ipconfig /all | Out-Host
            Read-Host "Press Enter to continue"
        }
        "2" {
            $host = Read-Host "Enter hostname or IP to ping"
            Write-Host ""
            Test-Connection $host -Count 4 | Out-Host
            Read-Host "Press Enter to continue"
        }
        "3" {
            ncpa.cpl
        }
        "4" {
            Write-Host ""
            Write-Host "Network Adapters:" -ForegroundColor Green
            Get-NetAdapter -Physical | Select-Object Name, Status, LinkSpeed, MediaConnectionState | Format-Table -AutoSize | Out-Host
            Read-Host "Press Enter to continue"
        }
        "5" {
            Write-Host ""
            Write-Host "Network Statistics:" -ForegroundColor Green
            netstat -an | Select-Object -First 20 | Out-Host
            Read-Host "Press Enter to continue"
        }
    }
}

function Developer-Tools {
    Show-Header
    Write-Host "┌─ DEVELOPER TOOLS ───────────────────────────────────────────────┐" -ForegroundColor Magenta
    Write-Host "│  [1] VS Code                        [6] PowerShell Version       │" -ForegroundColor Magenta
    Write-Host "│  [2] GitHub                        [7] Git Status               │" -ForegroundColor Magenta
    Write-Host "│  [3] Stack Overflow                [8] NPM Packages             │" -ForegroundColor Magenta
    Write-Host "│  [4] Node.js Info                  [9] Python Version           │" -ForegroundColor Magenta
    Write-Host "│  [5] .NET Info                    [10] Environment Variables    │" -ForegroundColor Magenta
    Write-Host "│  [0] Back                                                       │" -ForegroundColor Magenta
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Magenta
    Write-Host ""
    
    $choice = Read-Host "Select"
    
    switch ($choice) {
        "1" { Start-Process "code" }
        "2" { Start-Process "https://github.com" }
        "3" { Start-Process "https://stackoverflow.com" }
        "4" {
            Write-Host ""
            node --version
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        "5" {
            Write-Host ""
            dotnet --version
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        "6" {
            Write-Host ""
            $PSVersionTable.PSVersion
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        "7" {
            Write-Host ""
            git status 2>$null || Write-Host "Git not installed or not in PATH"
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        "8" {
            Write-Host ""
            npm list -g --depth=0 2>$null || Write-Host "NPM not installed"
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        "9" {
            Write-Host ""
            python --version 2>$null || Write-Host "Python not installed"
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
        "10" {
            Write-Host ""
            Write-Host "Key Environment Variables:" -ForegroundColor Green
            Write-Host "  Path: $env:PATH" -ForegroundColor Cyan
            Write-Host "  Username: $env:USERNAME" -ForegroundColor Cyan
            Write-Host "  Computer: $env:COMPUTERNAME" -ForegroundColor Cyan
            Write-Host "  OS: $env:OS" -ForegroundColor Cyan
            Write-Host ""
            Read-Host "Press Enter to continue"
        }
    }
}

function Quick-Start-Apps {
    Show-Header
    Write-Host "┌─ QUICK START APPS ──────────────────────────────────────────────┐" -ForegroundColor Cyan
    Write-Host "│ Most Used Applications                                           │" -ForegroundColor Cyan
    Write-Host "│                                                                  │" -ForegroundColor Cyan
    
    $freq = Get-FrequentApps
    if ($freq.Count -gt 0) {
        $i = 1
        foreach ($app in $freq) {
            Write-Host "│  [$i] FAVORITE: $app" -ForegroundColor Cyan
            $i++
        }
        Write-Host "│                                                                  │" -ForegroundColor Cyan
    } else {
        Write-Host "│  No usage history yet. Use other sections to build history.      │" -ForegroundColor Gray
        Write-Host "│                                                                  │" -ForegroundColor Cyan
    }
    
    Write-Host "│  [0] Back                                                        │" -ForegroundColor Cyan
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
    Write-Host ""
    
    $choice = Read-Host "Select app"
    
    if ($choice -eq "0") { return }
    
    if ($choice -match "^\d+$") {
        $index = [int]$choice - 1
        if ($index -ge 0 -and $index -lt $freq.Count) {
            try {
                Start-Process $freq[$index] -ErrorAction Stop
            } catch {
                Write-Host "ERROR: Could not launch app" -ForegroundColor Red
            }
        }
    }
}

function Games-Entertainment {
    Show-Header
    Write-Host "┌─ GAMES AND ENTERTAINMENT ───────────────────────────────────────┐" -ForegroundColor Cyan
    Write-Host "│  [1] Roblox                        [6] Movies AND TV            │" -ForegroundColor Cyan
    Write-Host "│  [2] Discord                       [7] Spotify                  │" -ForegroundColor Cyan
    Write-Host "│  [3] Steam                         [8] Netflix                  │" -ForegroundColor Cyan
    Write-Host "│  [4] Epic Games                    [9] Twitch                   │" -ForegroundColor Cyan
    Write-Host "│  [5] VLC Media Player             [10] Gamepass                 │" -ForegroundColor Cyan
    Write-Host "│  [C] Custom Game/App                                             │" -ForegroundColor Cyan
    Write-Host "│  [0] Back                                                        │" -ForegroundColor Cyan
    Write-Host "└──────────────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
    Write-Host ""
    
    $games = @(
        @{Name="Roblox"; Path="Roblox.exe"},
        @{Name="Discord"; Path="Discord.exe"},
        @{Name="Steam"; Path="steam.exe"},
        @{Name="Epic Games"; Path="EpicGamesLauncher.exe"},
        @{Name="VLC"; Path="vlc"},
        @{Name="Movies AND TV"; Path="ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"},
        @{Name="Spotify"; Path="Spotify.exe"},
        @{Name="Netflix"; Path="https://netflix.com"},
        @{Name="Twitch"; Path="https://twitch.tv"},
        @{Name="Gamepass"; Path="ms-windows-store://pdp/?ProductId=9PMZSX1VB6MT"}
    )
    
    $choice = Read-Host "Select"
    
    if ($choice -eq "0") { return }
    
    if ($choice -eq "C") {
        $customGame = Read-Host "Enter game/app name or path"
        if ($customGame) {
            try {
                Start-Process $customGame -ErrorAction Stop
                Track-App $customGame
                Write-Host "SUCCESS: Launching $customGame" -ForegroundColor Green
            } catch {
                Write-Host "ERROR: Could not launch" -ForegroundColor Red
            }
        }
        return
    }
    
    if ($choice -match "^\d+$") {
        $index = [int]$choice - 1
        if ($index -ge 0 -and $index -lt $games.Count) {
            $game = $games[$index]
            Track-App $game.Name
            try {
                Start-Process $game.Path -ErrorAction Stop
                Write-Host "SUCCESS: Launching $($game.Name)" -ForegroundColor Green
            } catch {
                Write-Host "ERROR: Not found or not installed" -ForegroundColor Red
                Read-Host "Press Enter to continue"
            }
        }
    }
}

# Main loop
$running = $true
while ($running) {
    Show-MainMenu
    $choice = Read-Host "Select option"
    
    switch ($choice) {
        "1" { Open-Application }
        "2" { Open-Website }
        "3" { Run-Command }
        "4" { File-Manager }
        "5" { System-Tools }
        "6" { Process-Manager }
        "7" { Network-Tools }
        "8" { Developer-Tools }
        "9" { Quick-Start-Apps }
        "10" { Games-Entertainment }
        "11" { Start-Process "ms-settings:" }
        "12" { $running = $false }
        default { Write-Host "Invalid choice" -ForegroundColor Red }
    }
    
    Clear-Host
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                                                ║" -ForegroundColor Cyan
Write-Host "║                      Goodbye! See you soon!                    ║" -ForegroundColor Cyan
Write-Host "║                                                                ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
