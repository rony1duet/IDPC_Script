@echo off
setlocal enabledelayedexpansion
title Contest Setup - Toph.co Firewall and CP Lab

set "ROOT=%~dp0"
set "CB_EXE=%ROOT%software\codeblocks.exe"
set "VS_EXE=%ROOT%software\VSCode.exe"
set "CR_VSIX=%ROOT%software\code-runner.vsix"
set "MINGW_ZIP=%ROOT%software\MinGW.zip"
set "RESTORE_BAT=%ROOT%.SYSTEM\restore.bat"
set "RESTORE_BAT_C=C:\.SYSTEM\restore.bat"
set "CONTEST_DIR=%USERPROFILE%\Desktop\Contest"
set "ARG=%~1"

:: Command-line parameter routing
if /i "%ARG%"=="/auto" goto full_setup
if /i "%ARG%"=="full" goto full_setup
if /i "%ARG%"=="1" goto full_setup
if /i "%ARG%"=="clean" goto clean_only
if /i "%ARG%"=="2" goto clean_only
if /i "%ARG%"=="ai" goto remove_ai_only
if /i "%ARG%"=="remove-ai" goto remove_ai_only
if /i "%ARG%"=="3" goto remove_ai_only
if /i "%ARG%"=="mingw" goto mingw_only
if /i "%ARG%"=="4" goto mingw_only
if /i "%ARG%"=="reinstall" goto reinstall_only
if /i "%ARG%"=="5" goto reinstall_only
if /i "%ARG%"=="security" goto security_only
if /i "%ARG%"=="6" goto security_only
if /i "%ARG%"=="lock" goto lock_only
if /i "%ARG%"=="7" goto lock_only
if /i "%ARG%"=="status" goto status_only
if /i "%ARG%"=="8" goto status_only
if /i "%ARG%"=="cp" goto cp_only
if /i "%ARG%"=="configure-cp" goto cp_only
if /i "%ARG%"=="unlock" goto call_restore
if /i "%ARG%"=="restore" goto call_restore

:menu
cls
echo ==================================================
echo   CONTEST SETUP - TOPH.CO FIREWALL and CP LAB
echo ==================================================
echo   [1] Full Contest Setup (Extract, Install, Lock)
echo   [2] Clean Profile Folders (Keep IDPC_Script)
echo   [3] Remove Offline AI Tools (Ollama, LM Studio)
echo   [4] Extract MinGW and Clean Environment Paths
echo   [5] Reinstall VS Code, Code::Blocks and Code Runner
echo   [6] Apply Admin Security and High UAC Policy
echo   [7] Lock Internet (Allow ONLY toph.co)
echo   [8] Check Status (Firewall, MinGW, Tools, Security)
echo   [9] Exit
echo ==================================================
set /p choice="Select option [1-9]: "

if "%choice%"=="1" goto full_setup
if "%choice%"=="2" goto clean_only
if "%choice%"=="3" goto remove_ai_only
if "%choice%"=="4" goto mingw_only
if "%choice%"=="5" goto reinstall_only
if "%choice%"=="6" goto security_only
if "%choice%"=="7" goto lock_only
if "%choice%"=="8" goto status_only
if "%choice%"=="9" exit /b
goto menu


:: =============================================================
:: 1. FULL SETUP
:: =============================================================
:full_setup
call :require_admin
cls
echo ==================================================
echo   AUTOMATED CONTEST ENVIRONMENT SETUP
echo ==================================================
echo.

echo [1/8] Cleaning user folders (Desktop, Downloads, etc.)...
call :clean_user_folders
echo       Done.

echo [2/8] Checking for and removing offline AI tools (Ollama, etc.)...
call :remove_offline_ai
echo       Done.

echo [3/8] Extracting MinGW (bits/stdc++.h support) and configuring PATH...
call :extract_mingw
call :clean_environment_paths
echo       Done.

echo [4/8] Installing Code::Blocks IDE...
call :install_codeblocks
echo       Done.

echo [5/8] Installing Visual Studio Code and Code Runner Extension...
call :install_vscode
call :install_coderunner
call :configure_cp
echo       Done.

echo [6/8] Deploying Hidden Recovery Utility to C:\.SYSTEM...
call :deploy_recovery
echo       Done.

echo [7/8] Applying Admin Security and High UAC Policy...
call :apply_security_policy
echo       Done.

echo [8/8] Locking Firewall (Allow ONLY toph.co)...
call :apply_firewall
echo       Done.

echo.
echo ==================================================
echo   CONTEST SETUP COMPLETE
echo   Workspace:    "%CONTEST_DIR%"
echo   Compiler:     C:\MinGW\bin\g++.exe (bits/stdc++.h READY)
echo   Code Runner:  Installed and Configured (Terminal: ON)
echo   Security:     Admin Password configured, High UAC active
echo   Firewall:     LOCKED - ONLY https://toph.co is accessible
echo   Recovery:     Deployed to C:\.SYSTEM\restore.bat (Hidden)
echo ==================================================
echo.

echo [*] Automatically launching Contest Workspace in VS Code and Code::Blocks...
call :open_ides

if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 2. CLEAN PROFILE FOLDERS ONLY
:: =============================================================
:clean_only
cls
echo Cleaning user folders (Desktop, Downloads, Documents, Pictures, etc.)...
call :clean_user_folders
echo.
echo [OK] User profile folders cleaned (IDPC_Script safely preserved).
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 3. REMOVE OFFLINE AI TOOLS ONLY
:: =============================================================
:remove_ai_only
cls
echo Checking for offline AI tools (Ollama, LM Studio, Jan, etc.)...
call :remove_offline_ai
echo.
echo [OK] Offline AI scan and uninstallation completed.
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 4. EXTRACT MINGW AND CLEAN PATHS
:: =============================================================
:mingw_only
call :require_admin
cls
echo Extracting MinGW and cleaning environment paths...
call :extract_mingw
call :clean_environment_paths
echo.
echo [OK] MinGW configured at C:\MinGW\bin with bits/stdc++.h support.
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 5. REINSTALL VS CODE, CODE::BLOCKS AND CODE RUNNER
:: =============================================================
:reinstall_only
cls
echo Reinstalling Code::Blocks, VS Code, and Code Runner...
call :clean_environment_paths
call :install_codeblocks
call :install_vscode
call :install_coderunner
call :configure_cp
echo.
echo [*] Opening Contest Workspace in VS Code and Code::Blocks...
call :open_ides
echo.
echo [OK] IDEs and extensions reinstalled and configured for CP.
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 6. APPLY ADMIN SECURITY AND HIGH UAC POLICY
:: =============================================================
:security_only
call :require_admin
cls
echo Applying Admin Security and High UAC policy...
call :apply_security_policy
echo.
echo [OK] Security lockdown applied. High UAC credentials required for admin actions.
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 7. LOCK FIREWALL (TOPH.CO ONLY)
:: =============================================================
:lock_only
call :require_admin
cls
echo Locking firewall (Allow ONLY toph.co)...
call :apply_firewall
echo.
echo [OK] Firewall locked - all websites blocked except toph.co.
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: CALL RESTORE SCRIPT FROM HIDDEN .SYSTEM FOLDER
:: =============================================================
:call_restore
if exist "%RESTORE_BAT_C%" (
    call "%RESTORE_BAT_C%"
) else if exist "%RESTORE_BAT%" (
    call "%RESTORE_BAT%"
) else (
    echo [ERROR] Restore script not found in C:\.SYSTEM\restore.bat or .SYSTEM\restore.bat
    pause
)
exit /b 0


:: =============================================================
:: 8. CHECK STATUS
:: =============================================================
:status_only
cls
echo ==================================================
echo   CONTEST STATUS and ENVIRONMENT INSPECTION
echo ==================================================
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$fw = (netsh advfirewall show currentprofile firewallpolicy 2>$null) -join ' ';" ^
    "$isBlocked = $fw -match 'BlockInbound,BlockOutbound';" ^
    "if ($isBlocked) { Write-Host '  Firewall Status:   [LOCKED - ONLY TOPH.CO ALLOWED]' -ForegroundColor Red } else { Write-Host '  Firewall Status:   [UNLOCKED - FULL INTERNET]' -ForegroundColor Green };" ^
    "try { $t = Invoke-WebRequest -Uri 'https://toph.co' -Method GET -UseBasicParsing -TimeoutSec 4; Write-Host ('  Toph.co Access:    [PASS] Reachable (HTTP ' + $t.StatusCode + ')') -ForegroundColor Green } catch { Write-Host '  Toph.co Access:    [FAIL] Unreachable' -ForegroundColor Red };" ^
    "try { $g = Invoke-WebRequest -Uri 'https://www.google.com' -Method GET -UseBasicParsing -TimeoutSec 3; if ($isBlocked) { Write-Host '  External Sites:    [WARNING] Reachable' -ForegroundColor Yellow } else { Write-Host '  External Sites:    [PASS] Reachable (Normal mode)' -ForegroundColor Gray } } catch { if ($isBlocked) { Write-Host '  External Sites:    [BLOCKED] All others blocked' -ForegroundColor Green } else { Write-Host '  External Sites:    [FAIL] Unreachable' -ForegroundColor Gray } };" ^
    "$hasBits = Test-Path 'C:\MinGW\lib\gcc\mingw32\6.3.0\include\c++\mingw32\bits\stdc++.h'; if ($hasBits) { Write-Host '  MinGW (bits):      [PASS] C:\MinGW\bin\g++.exe (bits/stdc++.h OK)' -ForegroundColor Green } else { Write-Host '  MinGW (bits):      [NOT READY] Extract MinGW.zip' -ForegroundColor Yellow };" ^
    "$cbOk = Test-Path 'C:\Program Files\CodeBlocks\codeblocks.exe'; if ($cbOk) { Write-Host '  Code::Blocks IDE:  [PASS] Installed' -ForegroundColor Green } else { Write-Host '  Code::Blocks IDE:  [NOT FOUND]' -ForegroundColor Yellow };" ^
    "$cCmd = $null; @('C:\Program Files\Microsoft VS Code\bin\code.cmd', ($env:LOCALAPPDATA + '\Programs\Microsoft VS Code\bin\code.cmd')) | ForEach-Object { if (-not $cCmd -and (Test-Path $_)) { $cCmd = $_ } }; if (-not $cCmd) { $c = Get-Command code.cmd -ErrorAction SilentlyContinue; if ($c) { $cCmd = $c.Source } };" ^
    "if ($cCmd) { Write-Host '  VS Code:           [PASS] Installed' -ForegroundColor Green } else { Write-Host '  VS Code:           [NOT FOUND]' -ForegroundColor Yellow };" ^
    "$hasCR = Test-Path ($env:USERPROFILE + '\.vscode\extensions\formulahendry.code-runner*'); if ($hasCR) { Write-Host '  Code Runner Ext:   [PASS] Installed' -ForegroundColor Green } else { Write-Host '  Code Runner Ext:   [MISSING] Not installed' -ForegroundColor Red };" ^
    "$aiFound = $false; if (Get-Process -Name 'ollama*' -ErrorAction SilentlyContinue) { $aiFound = $true }; if (Test-Path ($env:LOCALAPPDATA + '\Programs\Ollama')) { $aiFound = $true }; if (Test-Path ($env:USERPROFILE + '\.ollama')) { $aiFound = $true }; if ($aiFound) { Write-Host '  Offline AI Tools:  [DETECTED] Ollama/AI files present' -ForegroundColor Red } else { Write-Host '  Offline AI Tools:  [PASS] Clean (None found)' -ForegroundColor Green };" ^
    "$uac = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -ErrorAction SilentlyContinue).ConsentPromptBehaviorAdmin; if ($uac -eq 1) { Write-Host '  Security Policy:   [HIGH] Admin Security and UAC Credentials Prompt Active' -ForegroundColor Green } else { Write-Host ('  Security Policy:   [NORMAL] UAC Level: ' + $uac) -ForegroundColor Gray };" ^
    "$cDir = Join-Path $env:USERPROFILE 'Desktop\Contest'; if (Test-Path $cDir) { Write-Host ('  Workspace:         [READY] ' + $cDir) -ForegroundColor Green } else { Write-Host '  Workspace:         [NOT CREATED]' -ForegroundColor Gray };" ^
    "$hasRest = (Test-Path 'C:\.SYSTEM\restore.bat') -or (Test-Path (Join-Path '%ROOT%' '.SYSTEM\restore.bat')); if ($hasRest) { Write-Host '  Recovery Script:   [READY] Hidden in C:\.SYSTEM\restore.bat' -ForegroundColor Green } else { Write-Host '  Recovery Script:   [MISSING]' -ForegroundColor Red }"
echo ==================================================
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: 9. CONFIGURE CONTEST WORKSPACE ONLY
:: =============================================================
:cp_only
cls
echo Configuring Contest workspace and VS Code CP environment...
call :configure_cp
echo.
echo [OK] Contest workspace configured at %CONTEST_DIR%.
echo.
if not "!ARG!"=="" exit /b 0
pause
goto menu


:: =============================================================
:: HELPER: REQUIRE ADMINISTRATOR PRIVILEGES
:: =============================================================
:require_admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Requesting Administrator privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\" %*' -Verb RunAs"
    exit
)
exit /b 0


:: =============================================================
:: HELPER: EXTRACT MINGW (<bits/stdc++.h> COMPILER)
:: =============================================================
:extract_mingw
if not exist "%MINGW_ZIP%" (
    echo       [Skipped: MinGW.zip not found in software\]
    exit /b 0
)

echo       Extracting MinGW to C:\MinGW...
if not exist "C:\MinGW" mkdir "C:\MinGW" >nul 2>&1

where.exe tar.exe >nul 2>&1
if %errorlevel% equ 0 (
    tar.exe -xf "%MINGW_ZIP%" -C "C:\MinGW"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Expand-Archive -LiteralPath '%MINGW_ZIP%' -DestinationPath 'C:\MinGW' -Force" >nul 2>&1
)

if exist "C:\MinGW\bin\g++.exe" (
    echo       [OK] MinGW extracted successfully to C:\MinGW.
) else (
    echo       [WARNING] Could not find C:\MinGW\bin\g++.exe after extraction.
)
exit /b 0


:: =============================================================
:: HELPER: CLEAN ENVIRONMENT VARIABLE PATHS
:: =============================================================
:clean_environment_paths
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "foreach ($target in @('Machine', 'User')) {" ^
    "    $oldP = [Environment]::GetEnvironmentVariable('Path', $target);" ^
    "    if ($oldP) {" ^
    "        $parts = $oldP -split ';' | Where-Object {" ^
    "            $_ -and" ^
    "            ($_ -notmatch '(?i)CodeBlocks') -and" ^
    "            ($_ -notmatch '(?i)MinGW') -and" ^
    "            ($_ -notmatch '(?i)msys64') -and" ^
    "            ($_ -notmatch '(?i)Microsoft VS Code')" ^
    "        };" ^
    "        $newP = $parts -join ';';" ^
    "        [Environment]::SetEnvironmentVariable('Path', $newP, $target);" ^
    "    };" ^
    "    $cur = [Environment]::GetEnvironmentVariable('Path', $target);" ^
    "    if ($cur -split ';' -notcontains 'C:\MinGW\bin') {" ^
    "        $up = if ($cur) { $cur.TrimEnd(';') + ';C:\MinGW\bin' } else { 'C:\MinGW\bin' };" ^
    "        [Environment]::SetEnvironmentVariable('Path', $up, $target);" ^
    "    }" ^
    "};" ^
    "Write-Host '       Cleaned conflicting paths and registered C:\MinGW\bin.' -ForegroundColor Green;"
set "PATH=C:\MinGW\bin;%PATH%"
exit /b 0


:: =============================================================
:: HELPER: CLEAN USER PROFILE FOLDERS
:: =============================================================
:clean_user_folders
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$scriptRoot = '%ROOT%'.TrimEnd('\');" ^
    "$folders = @('Desktop','Downloads','Documents','Pictures','Videos','Music');" ^
    "$profiles = @($env:USERPROFILE);" ^
    "if (Test-Path 'C:\Users') { $others = Get-ChildItem 'C:\Users' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -notmatch '^(Public|Default|Default User|All Users)$' -and $_.FullName -ne $env:USERPROFILE } | Select-Object -ExpandProperty FullName; if ($others) { $profiles += $others } };" ^
    "$delCount = 0;" ^
    "foreach ($p in $profiles) {" ^
    "    foreach ($f in $folders) {" ^
    "        $tPath = Join-Path $p $f;" ^
    "        if (Test-Path $tPath) {" ^
    "            Get-ChildItem -LiteralPath $tPath -Force -ErrorAction SilentlyContinue | ForEach-Object {" ^
    "                if ($_.Name -like '*IDPC_Script*') { return };" ^
    "                if ($scriptRoot -and ($scriptRoot -like ($_.FullName + '*'))) { return };" ^
    "                if ($_.Name -eq 'desktop.ini') { return };" ^
    "                if ($_.Attributes -band [System.IO.FileAttributes]::ReparsePoint) { return };" ^
    "                try {" ^
    "                    Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction SilentlyContinue;" ^
    "                    $delCount++;" ^
    "                } catch {}" ^
    "            }" ^
    "        }" ^
    "    }" ^
    "};" ^
    "Write-Host ('       Cleaned ' + $delCount + ' item(s) across user folders (IDPC_Script preserved).') -ForegroundColor Green;"
exit /b 0


:: =============================================================
:: HELPER: DETECT AND REMOVE OFFLINE AI TOOLS
:: =============================================================
:remove_offline_ai
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$aiNames = @('ollama', 'ollama_app', 'LM Studio', 'jan', 'chat', 'anythingllm');" ^
    "foreach ($p in $aiNames) { Get-Process -Name $p -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue };" ^
    "Get-Service -Name 'ollama*' -ErrorAction SilentlyContinue | ForEach-Object { Stop-Service $_ -Force -ErrorAction SilentlyContinue; sc.exe delete $_.Name 2>&1 | Out-Null };" ^
    "$uKeys = @('HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*');" ^
    "$foundAI = $false;" ^
    "Get-ItemProperty $uKeys -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -match '(?i)ollama|lm studio|jan ai|gpt4all|anythingllm' } | ForEach-Object {" ^
    "    $foundAI = $true;" ^
    "    Write-Host ('       Found: ' + $_.DisplayName + '. Uninstalling...') -ForegroundColor Yellow;" ^
    "    $un = $_.UninstallString;" ^
    "    if ($_.QuietUninstallString) { $c = $_.QuietUninstallString } elseif ($un -match '(?i)uninstall\.exe') { $c = \"$un /VERYSILENT /NORESTART\" } else { $c = \"$un /S /silent /quiet /norestart\" };" ^
    "    try { Start-Process cmd.exe -ArgumentList \"/c $c\" -Wait -WindowStyle Hidden } catch {}" ^
    "};" ^
    "$aiDirs = @(" ^
    "    ($env:LOCALAPPDATA + '\Programs\Ollama')," ^
    "    'C:\Program Files\Ollama'," ^
    "    ($env:USERPROFILE + '\.ollama')," ^
    "    ($env:LOCALAPPDATA + '\Ollama')," ^
    "    ($env:LOCALAPPDATA + '\Programs\LM Studio')," ^
    "    ($env:USERPROFILE + '\.cache\lm-studio')," ^
    "    ($env:LOCALAPPDATA + '\Programs\Jan')," ^
    "    ($env:USERPROFILE + '\jan')," ^
    "    'C:\Program Files\GPT4All'" ^
    ");" ^
    "if (Test-Path 'C:\Users') { Get-ChildItem 'C:\Users' -Directory -ErrorAction SilentlyContinue | ForEach-Object { $aiDirs += (Join-Path $_.FullName '.ollama'); $aiDirs += (Join-Path $_.FullName '.cache\lm-studio') } };" ^
    "foreach ($ad in $aiDirs) { if (Test-Path $ad) { $foundAI = $true; try { Remove-Item -LiteralPath $ad -Recurse -Force -ErrorAction SilentlyContinue } catch {} } };" ^
    "foreach ($target in @('Machine', 'User')) {" ^
    "    try {" ^
    "        $oldP = [Environment]::GetEnvironmentVariable('Path', $target);" ^
    "        if ($oldP) {" ^
    "            $newP = ($oldP -split ';' | Where-Object { $_ -and ($_ -notmatch '(?i)ollama|lm studio|jan') }) -join ';';" ^
    "            if ($oldP -ne $newP) { [Environment]::SetEnvironmentVariable('Path', $newP, $target) }" ^
    "        }" ^
    "    } catch {}" ^
    "};" ^
    "if (-not $foundAI) { Write-Host '       No offline AI tools (Ollama, LM Studio, etc.) detected on system.' -ForegroundColor Green } else { Write-Host '       Offline AI tools and models successfully removed.' -ForegroundColor Green };"
exit /b 0


:: =============================================================
:: HELPER: INSTALL CODE::BLOCKS
:: =============================================================
:install_codeblocks
if exist "%CB_EXE%" (
    echo       Installing provided Code::Blocks...
    start /wait "" "%CB_EXE%" /S
    ping 127.0.0.1 -n 2 >nul
    if exist "C:\Program Files\CodeBlocks\codeblocks.exe" (
        echo       [OK] Code::Blocks installed successfully.
    ) else (
        echo       [WARNING] Code::Blocks installation could not be verified.
    )
) else (
    echo       [Skipped: installer not found in software\]
)
exit /b 0


:: =============================================================
:: HELPER: INSTALL VS CODE
:: =============================================================
:install_vscode
if not exist "%VS_EXE%" (
    echo       [Skipped: installer not found in software\]
    exit /b 0
)

echo       Installing provided Visual Studio Code...
start /wait "" "%VS_EXE%" /VERYSILENT /NORESTART /MERGETASKS="!runcode,addtopath,desktopicon"
echo       [OK] Visual Studio Code installed.
exit /b 0


:: =============================================================
:: HELPER: INSTALL CODE RUNNER EXTENSION
:: =============================================================
:install_coderunner
set "CODE_CMD="
if exist "C:\Program Files\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=C:\Program Files\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD if exist "C:\Program Files (x86)\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=C:\Program Files (x86)\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD (
    for /f "delims=" %%G in ('where.exe code.cmd 2^>nul') do (
        if not defined CODE_CMD set "CODE_CMD=%%~fG"
    )
)

if not defined CODE_CMD (
    echo       [Skipped: VS Code code.cmd not found.]
    exit /b 0
)

call "!CODE_CMD!" --list-extensions 2>nul | findstr /i "formulahendry.code-runner" >nul 2>&1
if %errorlevel% equ 0 (
    echo       Code Runner extension is already installed.
    exit /b 0
)

if exist "%CR_VSIX%" (
    echo       Installing Code Runner from local package "%CR_VSIX%"...
    call "!CODE_CMD!" --install-extension "%CR_VSIX%" --force >nul 2>&1
) else (
    echo       Installing Code Runner from Visual Studio Marketplace...
    call "!CODE_CMD!" --install-extension formulahendry.code-runner --force >nul 2>&1
)

call "!CODE_CMD!" --list-extensions 2>nul | findstr /i "formulahendry.code-runner" >nul 2>&1
if %errorlevel% equ 0 (
    echo       [OK] Code Runner extension installed successfully.
) else (
    echo       [WARNING] Could not verify Code Runner extension.
)
exit /b 0


:: =============================================================
:: HELPER: CONFIGURE C++ CP ENVIRONMENT & CONTEST WORKSPACE
:: =============================================================
:configure_cp
if not exist "%CONTEST_DIR%\.vscode" mkdir "%CONTEST_DIR%\.vscode" >nul 2>&1
if not exist "%APPDATA%\Code\User" mkdir "%APPDATA%\Code\User" >nul 2>&1

(
echo {
echo     "editor.fontSize": 15,
echo     "terminal.integrated.defaultProfile.windows": "Command Prompt",
echo     "C_Cpp.default.compilerPath": "C:\\MinGW\\bin\\g++.exe",
echo     "C_Cpp.default.cppStandard": "c++17",
echo     "C_Cpp.default.intelliSenseMode": "windows-gcc-x64",
echo     "code-runner.runInTerminal": true,
echo     "code-runner.saveFileBeforeRun": true,
echo     "code-runner.saveAllFilesBeforeRun": true,
echo     "code-runner.clearPreviousOutput": true,
echo     "code-runner.preserveFocus": false,
echo     "code-runner.ignoreSelection": true,
echo     "code-runner.fileDirectoryAsCwd": true,
echo     "code-runner.executorMap": {
echo         "cpp": "cd /d $dirWithoutTrailingSlash && g++ -O2 -std=c++17 $fileName -o $fileNameWithoutExt && $fileNameWithoutExt",
echo         "c": "cd /d $dirWithoutTrailingSlash && gcc -O2 $fileName -o $fileNameWithoutExt && $fileNameWithoutExt",
echo         "python": "python -u",
echo         "java": "cd /d $dirWithoutTrailingSlash && javac $fileName && java $fileNameWithoutExt"
echo     }
echo }
) > "%CONTEST_DIR%\.vscode\settings.json"

copy /y "%CONTEST_DIR%\.vscode\settings.json" "%APPDATA%\Code\User\settings.json" >nul 2>&1

(
echo {
echo     "version": "2.0.0",
echo     "tasks": [
echo         {
echo             "label": "Build C++",
echo             "type": "shell",
echo             "command": "g++",
echo             "args": ["-O2", "-std=c++17", "-Wall", "${file}", "-o", "${fileDirname}\\${fileBasenameNoExtension}.exe"],
echo             "group": {"kind": "build", "isDefault": true},
echo             "problemMatcher": ["$gcc"]
echo         }
echo     ]
echo }
) > "%CONTEST_DIR%\.vscode\tasks.json"

(
echo {
echo     "version": "0.2.0",
echo     "configurations": [
echo         {
echo             "name": "Debug C++",
echo             "type": "cppdbg",
echo             "request": "launch",
echo             "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
echo             "args": [],
echo             "stopAtEntry": false,
echo             "cwd": "${workspaceFolder}",
echo             "environment": [],
echo             "externalConsole": true,
echo             "MIMode": "gdb",
echo             "miDebuggerPath": "gdb.exe",
echo             "preLaunchTask": "Build C++"
echo         }
echo     ]
echo }
) > "%CONTEST_DIR%\.vscode\launch.json"

(
echo {
echo     "configurations": [
echo         {
echo             "name": "Win32",
echo             "includePath": ["${workspaceFolder}/**"],
echo             "defines": ["_DEBUG", "UNICODE", "_UNICODE", "LOCAL"],
echo             "compilerPath": "C:/MinGW/bin/g++.exe",
echo             "cStandard": "c17",
echo             "cppStandard": "c++17",
echo             "intelliSenseMode": "windows-gcc-x64"
echo         }
echo     ],
echo     "version": 4
echo }
) > "%CONTEST_DIR%\.vscode\c_cpp_properties.json"

(
echo #include ^<bits/stdc++.h^>
echo using namespace std;
echo.
echo int main^(^)
echo {
echo     cout^<^<"Welcome to IDPC";
echo.
echo     return 0;
echo }
) > "%CONTEST_DIR%\main.cpp"

if exist "%CONTEST_DIR%\solution.cpp" del /f /q "%CONTEST_DIR%\solution.cpp" >nul 2>&1
if exist "%CONTEST_DIR%\input.txt" del /f /q "%CONTEST_DIR%\input.txt" >nul 2>&1
if exist "%CONTEST_DIR%\output.txt" del /f /q "%CONTEST_DIR%\output.txt" >nul 2>&1
if exist "%CONTEST_DIR%\main.exe" del /f /q "%CONTEST_DIR%\main.exe" >nul 2>&1
if exist "%CONTEST_DIR%\main.o" del /f /q "%CONTEST_DIR%\main.o" >nul 2>&1
exit /b 0


:: =============================================================
:: HELPER: DEPLOY HIDDEN RECOVERY UTILITY TO C:\.SYSTEM
:: =============================================================
:deploy_recovery
if not exist "C:\.SYSTEM" mkdir "C:\.SYSTEM" >nul 2>&1
if exist "%ROOT%.SYSTEM\restore.bat" (
    copy /y "%ROOT%.SYSTEM\restore.bat" "C:\.SYSTEM\restore.bat" >nul 2>&1
)
attrib +h "C:\.SYSTEM" >nul 2>&1
if exist "%ROOT%.SYSTEM" attrib +h "%ROOT%.SYSTEM" >nul 2>&1
exit /b 0


:: =============================================================
:: HELPER: SET ADMIN SECURITY & HIGH UAC POLICY
:: =============================================================
:apply_security_policy
echo       Configuring Administrator security...
net user Administrator /active:yes >nul 2>&1
net user Administrator "@DMIN_idpc" >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$admins = Get-LocalGroupMember -Group 'Administrators' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name;" ^
    "Get-LocalUser -ErrorAction SilentlyContinue | ForEach-Object {" ^
    "    $full = ($env:COMPUTERNAME + '\' + $_.Name);" ^
    "    if ($admins -contains $full -or $admins -contains $_.Name -or $_.Name -eq 'Administrator') {" ^
    "        try {" ^
    "            Set-LocalUser -Name $_.Name -Password (ConvertTo-SecureString '@DMIN_idpc' -AsPlainText -Force) -ErrorAction SilentlyContinue;" ^
    "            Enable-LocalUser -Name $_.Name -ErrorAction SilentlyContinue;" ^
    "        } catch {}" ^
    "    }" ^
    "};" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorUser' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'FilterAdministratorToken' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableInstallerDetection' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableSecureUIAPaths' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableVirtualization' -Value 1 -Force -ErrorAction SilentlyContinue;" ^
    "Write-Host '       Administrator security configured. High UAC policy applied.' -ForegroundColor Green;"
exit /b 0


:: =============================================================
:: HELPER: OPEN CONTEST WORKSPACE IN VS CODE AND CODE::BLOCKS
:: =============================================================
:open_ides
set "CODE_CMD="
if exist "C:\Program Files\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=C:\Program Files\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD (
    for /f "delims=" %%G in ('where.exe code.cmd 2^>nul') do if not defined CODE_CMD set "CODE_CMD=%%~fG"
)

set "CB_BIN="
if exist "C:\Program Files\CodeBlocks\codeblocks.exe" set "CB_BIN=C:\Program Files\CodeBlocks\codeblocks.exe"
if not defined CB_BIN if exist "C:\Program Files (x86)\CodeBlocks\codeblocks.exe" set "CB_BIN=C:\Program Files (x86)\CodeBlocks\codeblocks.exe"
if not defined CB_BIN (
    for /f "delims=" %%G in ('where.exe codeblocks.exe 2^>nul') do if not defined CB_BIN set "CB_BIN=%%~fG"
)

if defined CODE_CMD (
    echo       Opening Visual Studio Code with %CONTEST_DIR%...
    start "" "!CODE_CMD!" "%CONTEST_DIR%" "%CONTEST_DIR%\main.cpp"
) else (
    echo       [Skipped: VS Code not detected]
)

if defined CB_BIN (
    echo       Opening Code::Blocks with %CONTEST_DIR%\main.cpp...
    start "" "!CB_BIN!" "%CONTEST_DIR%\main.cpp"
) else (
    echo       [Skipped: Code::Blocks not detected]
)
exit /b 0


:: =============================================================
:: HELPER: APPLY FIREWALL LOCKDOWN
:: =============================================================
:apply_firewall
set "TOPH_IPS=172.104.40.125 2400:8901::2000:26ff:fe31:c05e 159.89.98.98 2a03:b0c0:3:d0::ec0:3001"

for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "'toph.co','www.toph.co','ws.toph.co','uploads.toph.co','static.toph.co','drafts.toph.co','community.toph.co','blog.toph.co','help.toph.co','status.toph.co' | ForEach-Object { (Resolve-DnsName $_ -ErrorAction SilentlyContinue).IPAddress } | Select-Object -Unique" 2^>nul`) do (
    set "TOPH_IPS=!TOPH_IPS! %%A"
)

netsh advfirewall firewall delete rule name="TOPH_DNS_UDP" >nul 2>&1
netsh advfirewall firewall delete rule name="TOPH_DNS_TCP" >nul 2>&1
netsh advfirewall firewall delete rule name="TOPH_DHCP_UDP" >nul 2>&1
netsh advfirewall firewall delete rule name="TOPH_LOOPBACK_V4" >nul 2>&1
netsh advfirewall firewall delete rule name="TOPH_LOOPBACK_V6" >nul 2>&1
netsh advfirewall firewall delete rule name="TOPH_ALLOW_SITE" >nul 2>&1

netsh advfirewall firewall add rule name="TOPH_DNS_UDP" dir=out action=allow protocol=UDP remoteport=53 >nul
netsh advfirewall firewall add rule name="TOPH_DNS_TCP" dir=out action=allow protocol=TCP remoteport=53 >nul
netsh advfirewall firewall add rule name="TOPH_DHCP_UDP" dir=out action=allow protocol=UDP localport=68 remoteport=67 >nul
netsh advfirewall firewall add rule name="TOPH_LOOPBACK_V4" dir=out action=allow remoteip=127.0.0.1 >nul
netsh advfirewall firewall add rule name="TOPH_LOOPBACK_V6" dir=out action=allow remoteip=::1 >nul

for %%I in (!TOPH_IPS!) do (
    netsh advfirewall firewall add rule name="TOPH_ALLOW_SITE" dir=out action=allow protocol=TCP remoteport=80,443 remoteip=%%I >nul
)

netsh advfirewall set allprofiles state on >nul
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound >nul
exit /b 0
