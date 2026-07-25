# Universal Command Launcher - PowerShell GUI Version
# Run with: powershell -ExecutionPolicy Bypass -File LAUNCHER_GUI.ps1

try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
} catch {
    Write-Host "Error loading Windows Forms" -ForegroundColor Red
    Write-Host "Try running: powershell -ExecutionPolicy Bypass" -ForegroundColor Yellow
    exit 1
}

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Universal Command Launcher"
$form.Size = New-Object System.Drawing.Size(800, 600)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
$form.Font = New-Object System.Drawing.Font("Arial", 10)

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "UNIVERSAL COMMAND LAUNCHER - Do Anything!"
$titleLabel.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
$titleLabel.Size = New-Object System.Drawing.Size(750, 30)
$titleLabel.Location = New-Object System.Drawing.Point(20, 10)
$form.Controls.Add($titleLabel)

# Command Input
$cmdLabel = New-Object System.Windows.Forms.Label
$cmdLabel.Text = "Command or App:"
$cmdLabel.Size = New-Object System.Drawing.Size(100, 20)
$cmdLabel.Location = New-Object System.Drawing.Point(20, 50)
$form.Controls.Add($cmdLabel)

$cmdInput = New-Object System.Windows.Forms.TextBox
$cmdInput.Size = New-Object System.Drawing.Size(600, 25)
$cmdInput.Location = New-Object System.Drawing.Point(120, 50)
$cmdInput.Font = New-Object System.Drawing.Font("Courier", 10)
$form.Controls.Add($cmdInput)

# Execute Button
$executeBtn = New-Object System.Windows.Forms.Button
$executeBtn.Text = "Execute"
$executeBtn.Size = New-Object System.Drawing.Size(80, 25)
$executeBtn.Location = New-Object System.Drawing.Point(720, 50)
$executeBtn.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$executeBtn.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($executeBtn)

# Quick Actions Group
$quickGroup = New-Object System.Windows.Forms.GroupBox
$quickGroup.Text = "Quick Actions"
$quickGroup.Size = New-Object System.Drawing.Size(360, 250)
$quickGroup.Location = New-Object System.Drawing.Point(20, 90)
$quickGroup.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($quickGroup)

# Apps Section
$appLabel = New-Object System.Windows.Forms.Label
$appLabel.Text = "Applications:"
$appLabel.Size = New-Object System.Drawing.Size(100, 20)
$appLabel.Location = New-Object System.Drawing.Point(10, 20)
$quickGroup.Controls.Add($appLabel)

$appBtns = @(
    @{Name="Chrome"; Cmd="chrome"},
    @{Name="Firefox"; Cmd="firefox"},
    @{Name="Notepad"; Cmd="notepad"},
    @{Name="Explorer"; Cmd="explorer"},
    @{Name="VS Code"; Cmd="code"},
    @{Name="PowerShell"; Cmd="powershell"}
)

$appY = 40
foreach ($app in $appBtns) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $app.Name
    $btn.Size = New-Object System.Drawing.Size(100, 25)
    $btn.Location = New-Object System.Drawing.Point(10, $appY)
    $btn.Tag = $app.Cmd
    $btn.Add_Click({
        Start-Process $this.Tag
    })
    $quickGroup.Controls.Add($btn)
    
    if ($appY -eq 40) { $appY = 70 } else { $appY += 35; if ($appY -gt 100) { $appY = 40 } }
}

# Websites Group
$websiteGroup = New-Object System.Windows.Forms.GroupBox
$websiteGroup.Text = "Quick Websites"
$websiteGroup.Size = New-Object System.Drawing.Size(360, 250)
$websiteGroup.Location = New-Object System.Drawing.Point(400, 90)
$websiteGroup.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($websiteGroup)

$urlLabel = New-Object System.Windows.Forms.Label
$urlLabel.Text = "Popular Sites:"
$urlLabel.Size = New-Object System.Drawing.Size(100, 20)
$urlLabel.Location = New-Object System.Drawing.Point(10, 20)
$websiteGroup.Controls.Add($urlLabel)

$urls = @(
    @{Name="Google"; URL="https://google.com"},
    @{Name="YouTube"; URL="https://youtube.com"},
    @{Name="GitHub"; URL="https://github.com"},
    @{Name="ChatGPT"; URL="https://chatgpt.com"},
    @{Name="Reddit"; URL="https://reddit.com"},
    @{Name="Wikipedia"; URL="https://wikipedia.org"}
)

$webY = 40
foreach ($site in $urls) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $site.Name
    $btn.Size = New-Object System.Drawing.Size(100, 25)
    $btn.Location = New-Object System.Drawing.Point(10, $webY)
    $btn.Tag = $site.URL
    $btn.Add_Click({
        Start-Process $this.Tag
    })
    $websiteGroup.Controls.Add($btn)
    
    if ($webY -eq 40) { $webY = 70 } else { $webY += 35; if ($webY -gt 100) { $webY = 40 } }
}

# Tools Group
$toolsGroup = New-Object System.Windows.Forms.GroupBox
$toolsGroup.Text = "System Tools"
$toolsGroup.Size = New-Object System.Drawing.Size(360, 150)
$toolsGroup.Location = New-Object System.Drawing.Point(20, 350)
$toolsGroup.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($toolsGroup)

$tools = @(
    @{Name="Task Manager"; Cmd="taskmgr"},
    @{Name="Device Manager"; Cmd="devmgmt.msc"},
    @{Name="Settings"; Cmd="ms-settings:"},
    @{Name="Control Panel"; Cmd="control"},
    @{Name="System Info"; Cmd="msinfo32"},
    @{Name="Network Settings"; Cmd="ncpa.cpl"}
)

$toolY = 20
$toolX = 10
foreach ($tool in $tools) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $tool.Name
    $btn.Size = New-Object System.Drawing.Size(100, 25)
    $btn.Location = New-Object System.Drawing.Point($toolX, $toolY)
    $btn.Tag = $tool.Cmd
    $btn.Add_Click({
        Start-Process $this.Tag
    })
    $toolsGroup.Controls.Add($btn)
    
    $toolX += 110
    if ($toolX -gt 230) {
        $toolX = 10
        $toolY += 35
    }
}

# Output/Help Group
$helpGroup = New-Object System.Windows.Forms.GroupBox
$helpGroup.Text = "Help & Info"
$helpGroup.Size = New-Object System.Drawing.Size(360, 150)
$helpGroup.Location = New-Object System.Drawing.Point(400, 350)
$helpGroup.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($helpGroup)

$helpLabel = New-Object System.Windows.Forms.Label
$helpLabel.Text = @"
Examples:
• Open app: notepad, chrome, code
• Open URL: https://example.com
• Run command: ipconfig, systeminfo
• File ops: explorer, mkdir myfolder
• System: taskmgr, services.msc

Type anything and click Execute!
"@
$helpLabel.Size = New-Object System.Drawing.Size(340, 120)
$helpLabel.Location = New-Object System.Drawing.Point(10, 20)
$helpLabel.Font = New-Object System.Drawing.Font("Courier", 9)
$helpGroup.Controls.Add($helpLabel)

# Execute Button Click Handler
$executeBtn.Add_Click({
    $input = $cmdInput.Text.Trim()
    if ($input -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Please enter a command or app name", "Empty Input", [System.Windows.Forms.MessageBoxButtons]::OK)
        return
    }
    
    try {
        # Check if it's a URL
        if ($input -match "^https?://") {
            Start-Process $input
        }
        # Check if it's a file path
        elseif ($input -match "\\") {
            Start-Process $input
        }
        # Otherwise treat as command
        else {
            Invoke-Expression $input
        }
        $cmdInput.Text = ""
        [System.Windows.Forms.MessageBox]::Show("Executed: $input", "Success", [System.Windows.Forms.MessageBoxButtons]::OK)
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error: $_", "Execution Failed", [System.Windows.Forms.MessageBoxButtons]::OK)
    }
})

# Show form and handle errors
try {
    $form.ShowDialog() | Out-Null
} catch {
    Write-Host "Error displaying form: $_" -ForegroundColor Red
}
