@echo off
setlocal enabledelayedexpansion
title Contest Unlock - Full Internet and System Policies

echo ==================================================
echo   CONTEST UNLOCK - RECOVERY UTILITY
echo ==================================================
echo.

:: Require admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Requesting Administrator privileges...
    if "%~1"=="" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    ) else (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -ArgumentList '%*' -Verb RunAs"
    )
    exit /b 0
)

echo [1/3] Restoring Firewall Policies (Full Internet Access)...
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound >nul
netsh advfirewall firewall delete rule name="BAPSOJ_DNS_UDP" >nul 2>&1
netsh advfirewall firewall delete rule name="BAPSOJ_DNS_TCP" >nul 2>&1
netsh advfirewall firewall delete rule name="BAPSOJ_DHCP_UDP" >nul 2>&1
netsh advfirewall firewall delete rule name="BAPSOJ_LOOPBACK_V4" >nul 2>&1
netsh advfirewall firewall delete rule name="BAPSOJ_LOOPBACK_V6" >nul 2>&1
netsh advfirewall firewall delete rule name="BAPSOJ_ALLOW_SITE" >nul 2>&1
echo       Firewall rules removed. Full internet access restored.

echo [2/3] Setting UAC to Low...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Value 0 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorUser' -Value 3 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Value 0 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'FilterAdministratorToken' -Value 0 -Force -ErrorAction SilentlyContinue;" ^
    "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 1 -Force -ErrorAction SilentlyContinue;" >nul 2>&1
echo       UAC policies set to Low (Elevate without prompting for administrators).

echo [3/3] Testing Internet Connectivity (Bapsoj.org and api.bapsoj.org)...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "try { $t = Invoke-WebRequest -Uri 'https://bapsoj.org' -Method GET -UseBasicParsing -TimeoutSec 4; Write-Host ('       bapsoj.org:     [PASS] (HTTP ' + $t.StatusCode + ')') -ForegroundColor Green } catch { Write-Host '       bapsoj.org:     [FAIL] Unable to reach' -ForegroundColor Red };" ^
    "try { $t = Invoke-WebRequest -Uri 'https://api.bapsoj.org' -Method GET -UseBasicParsing -TimeoutSec 4; Write-Host ('       api.bapsoj.org: [PASS] (HTTP ' + $t.StatusCode + ')') -ForegroundColor Green } catch { Write-Host '       api.bapsoj.org: [FAIL] Unable to reach' -ForegroundColor Red };"

echo.
echo ==================================================
echo   UNLOCK COMPLETE
echo   Full internet restored and UAC set to Low.
echo ==================================================
echo.
pause
