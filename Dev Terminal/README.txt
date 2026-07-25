Just Double Click START.bat and begin # 🚀 UNIVERSAL COMMAND LAUNCHER

A powerful, all-in-one launcher that lets you do **literally anything** from your computer!

## 🎯 What It Does

This launcher is your universal remote for Windows. Open it once and do everything:

✅ **Open any application** - Chrome, Firefox, VS Code, Notepad, etc.  
✅ **Open any website** - Quick buttons for Google, YouTube, GitHub, ChatGPT  
✅ **Run any command** - Execute system commands, scripts, batch files  
✅ **File operations** - Open folders, copy files, delete files, create folders  
✅ **System tools** - Task Manager, Settings, Device Manager, etc.  
✅ **Custom commands** - Add your own shortcuts and automation  
✅ **Completely extensible** - Edit files to add anything you want  

## 🚀 Quick Start

### Double-click to launch:
```
START.bat
```

Then choose:
- **[1] GUI Interface** - Modern, visual interface (recommended)
- **[2] Command Interface** - Fast, text-based interface

## 📋 Features

### Command Interface (LAUNCHER.bat)
```
Menu System:
├── [1] Open Application
│   ├── Chrome, Firefox, Notepad, Explorer
│   ├── VS Code, PowerShell, Calculator
│   └── Type any app name to launch
│
├── [2] Open Website
│   ├── Google, YouTube, GitHub
│   ├── ChatGPT, Reddit, Wikipedia
│   └── Enter any URL
│
├── [3] Run Command
│   ├── System Info
│   ├── Check Disk Space
│   ├── List Programs
│   ├── Network Status
│   └── Run custom command
│
├── [4] File Operations
│   ├── Open Desktop/Documents/Downloads/Pictures
│   ├── Create folders
│   ├── Copy files
│   └── Delete files
│
├── [5] System Tools
│   ├── Task Manager
│   ├── Device Manager
│   ├── Settings
│   ├── Network Configuration
│   └── Display/Sound/Update settings
│
└── [6] Custom Commands
    └── Add your own automation here
```

### GUI Interface (LAUNCHER_GUI.ps1)
- Clean, modern interface
- Quick buttons for popular apps and websites
- Text input for advanced commands
- System tools at your fingertips
- Real-time execution feedback

## 💡 Examples

### Open Applications
```
Chrome
Firefox
Notepad
calc (calculator)
taskmgr (task manager)
explorer (file explorer)
code (VS Code)
powershell (PowerShell)
Any installed program name
```

### Open Websites
```
https://google.com
https://youtube.com
https://github.com
https://chatgpt.com
Any URL
```

### Run Commands
```
systeminfo              # Display system information
ipconfig                # Show network info
wmic product list       # List installed software
dir C:\                 # List directory contents
mkdir NewFolder         # Create folder
copy file1 file2        # Copy file
del file                # Delete file
python script.py        # Run Python script
```

### File Operations
```
explorer                # Open file manager
start Desktop           # Open Desktop folder
start Documents         # Open Documents
mkdir C:\MyFolder       # Create folder
copy "C:\file.txt" "D:\" # Copy file
del "C:\file.txt"       # Delete file
```

### Custom Commands
Edit `CUSTOM.bat` to add your own:
```batch
REM Open your favorite document
start notepad C:\Users\YourName\Important.txt

REM Run a Python script
python C:\Scripts\automation.py

REM Open network drive
start \\server\share

REM Open custom website
start https://my-site.com
```

## 📝 Files

| File | Purpose |
|------|---------|
| **START.bat** | Main launcher (run this!) |
| **LAUNCHER.bat** | Text-based command interface |
| **LAUNCHER_GUI.ps1** | Modern GUI interface |
| **CUSTOM.bat** | Your custom commands go here |
| **README.txt** | This file |

## 🎮 How to Use Each Interface

### GUI Interface (Recommended)
1. Run `START.bat`
2. Choose `[1] GUI Interface`
3. Click buttons for quick access
4. Type in the text box to run any command
5. Click "Execute" to run the command

**Advantages:**
- Visual, easy to use
- Great for beginners
- Quick access buttons
- Modern interface

### Command Interface (Power Users)
1. Run `START.bat`
2. Choose `[2] Command Interface`
3. Navigate menus with numbers
4. Type app names or commands

**Advantages:**
- Very fast (no loading)
- Great for keyboard users
- Direct command execution
- Lower resource usage

## 🔧 Advanced Usage

### Add Custom Commands

Edit `CUSTOM.bat` and add your commands:

```batch
REM Open multiple programs
start notepad
start chrome
start code

REM Run scripts
python "C:\Scripts\my_automation.py"

REM Network commands
start \\server\share\folder

REM Website shortcuts
start https://my-internal-site.com
```

### Create Shortcuts

Create a shortcut to `LAUNCHER_GUI.ps1` on your desktop:
1. Right-click desktop
2. New → Shortcut
3. Paste: `powershell -ExecutionPolicy Bypass -File "C:\Users\YourName\Desktop\LAUNCHER_GUI.ps1"`
4. Name it "Launcher"

### Pin to Start Menu

1. Right-click `START.bat`
2. Send to → Desktop (create shortcut)
3. Right-click the shortcut
4. Pin to Start

## 🌐 What You Can Do

### Launch Applications
- Any installed program
- Office apps (Word, Excel, Outlook)
- Multimedia apps (VLC, Spotify, Discord)
- Development tools (VS Code, Git Bash, Python)
- Games

### Browse Internet
- Popular websites (buttons)
- Any URL you type
- Bookmarks and favorites
- Online services

### Run Commands
- System diagnostics
- Network troubleshooting
- File management
- Program execution
- Script automation

### Manage System
- Open Settings
- Device Manager
- Services
- Network settings
- Display settings
- Sound settings
- Update settings

### File Operations
- Browse folders
- Create/copy/delete files
- Manage directories
- Launch from any location

## ⚙️ Customization

### Change Quick Apps

Edit `LAUNCHER.bat` (around line 50):
```batch
if "%app%"=="1" start YOUR_APP_HERE
```

Replace `YOUR_APP_HERE` with app name or path.

### Add Websites

Edit `LAUNCHER.bat` (around line 100):
```batch
if "%site%"=="1" start https://your-website.com
```

### Create Menu Sections

Add new sections in `LAUNCHER.bat`:
```batch
:my_custom_section
cls
echo.
echo YOUR SECTION
echo [1] Option 1
echo [2] Option 2
set /p choice="Choose: "
if "%choice%"=="1" start myprogram
goto eof
```

## 🆘 Troubleshooting

### "PowerShell script not found"
- Make sure `LAUNCHER_GUI.ps1` is in the same folder as `START.bat`
- Try right-clicking → "Run as administrator"

### "App/command not found"
- Make sure the app is installed and in your PATH
- Use the full path: `"C:\Program Files\AppName\app.exe"`
- Check spelling and capitalization

### "Access denied" errors
- Right-click and select "Run as administrator"
- Some operations require elevated privileges

### GUI doesn't open
- Try the command interface instead (`[2]` option)
- Make sure PowerShell execution policy allows scripts

## 🎓 Tips & Tricks

### Speed It Up
- Use `[2] Command Interface` for faster launching
- Create keyboard shortcuts for frequently used apps
- Pin START.bat to your taskbar

### Extend It
- Add your own commands to `CUSTOM.bat`
- Create batch scripts and call them from the launcher
- Use environment variables for dynamic paths

### Automate It
- Chain commands together: `notepad && explorer && calc`
- Run background tasks
- Schedule tasks to run via launcher

## 📱 Examples for Different Users

### For Developers
Add to CUSTOM.bat:
```batch
code C:\MyProject
start https://github.com
start https://stackoverflow.com
```

### For Office Workers
Add to CUSTOM.bat:
```batch
start https://outlook.office.com
start https://teams.microsoft.com
start https://docs.google.com
```

### For Students
Add to CUSTOM.bat:
```batch
start https://chatgpt.com
start https://stackoverflow.com
start https://github.com
code C:\School\Projects
```

### For Gamers
Add to CUSTOM.bat:
```batch
start https://steam.com
start https://epicgames.com
start https://discord.com
taskmgr
```

## 🔐 Security Notes

- This launcher runs whatever you ask it to
- Only add commands from trusted sources
- Be careful with file deletion commands
- Don't share malicious shortcuts
- Keep sensitive commands in CUSTOM.bat (not shared)

## 📞 Support

### Common Issues

**Q: Can I use this on macOS/Linux?**  
A: These scripts are Windows-specific. For Linux/Mac, create bash equivalents.

**Q: Can I make it start on boot?**  
A: Yes, add a shortcut to your Startup folder.

**Q: Can I run this without admin rights?**  
A: Most features work without admin, but some need elevation.

**Q: How do I uninstall?**  
A: Just delete the files. Nothing is added to Windows registry.

## 🎉 Conclusion

You now have a universal launcher that can do anything on your Windows PC!

- **Open apps instantly**
- **Browse websites quickly**
- **Run commands easily**
- **Manage files efficiently**
- **Automate tasks**
- **Completely customizable**

Have fun! 🚀

---

**Made with ❤️ for Windows Power Users**

*Last Updated: 2026-07-25*
