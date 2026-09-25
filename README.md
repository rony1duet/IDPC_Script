# Competitive Programming Contest Setup, Code Runner & Toph.co Firewall

A minimal, automated installer, cleaner, environment configurator, security lockdown, and firewall blocker for competitive programming contests on **[Toph](https://toph.co)**.

---

## ⚡ Quick Start

👉 **Run:** **`setup.bat`** (Run as Administrator)

```text
==================================================
  CONTEST SETUP - TOPH.CO FIREWALL and CP LAB
==================================================
  [1] Full Contest Setup (Extract, Install, Lock)
  [2] Clean Profile Folders (Keep IDPC_Script)
  [3] Remove Offline AI Tools (Ollama, LM Studio)
  [4] Extract MinGW and Clean Environment Paths
  [5] Reinstall VS Code, Code::Blocks and Code Runner
  [6] Apply Admin Security and High UAC Policy
  [7] Lock Internet (Allow ONLY toph.co)
  [8] Check Status (Firewall, MinGW, Tools, Security)
  [9] Exit
==================================================
```

- Select **`[1]`** to execute the complete end-to-end preparation for contest machines:
  1. **Clean user folders** (`Desktop`, `Downloads`, `Documents`, `Pictures`, `Videos`, `Music`) while safely preserving `IDPC_Script`.
  2. **Detect and silently remove offline AI tools** (Ollama, LM Studio, Jan AI, GPT4All, and wipe `.ollama` model stores).
  3. **Extract MinGW compiler** from `software\MinGW.zip` into `C:\MinGW`, enabling `<bits/stdc++.h>`.
  4. **Clean environment variable paths** (strips old/stale MinGW, CodeBlocks, and VS Code paths, registers fresh `C:\MinGW\bin`).
  5. **Reinstall Code::Blocks IDE & Visual Studio Code** using the provided installers.
  6. **Install Code Runner extension** in VS Code **before** internet is blocked and configure CP environment (`Desktop\Contest`).
  7. **Deploy Hidden Recovery Utility**: Copies `.SYSTEM` to `C:\.SYSTEM` (marked hidden) containing `restore.bat`.
  8. **Lock down Administrative Security**: Configures admin credentials in background (password hidden from display) and enforces **High UAC Policy** (credentials prompt on secure desktop).
  9. **Lock Firewall**: Allows ONLY `https://toph.co` and contest-essential services (DNS, DHCP, loopback).
  10. **Auto-Launch IDEs**: Automatically opens the `Desktop\Contest` workspace and `main.cpp` in both Visual Studio Code and Code::Blocks so the contest setup can be verified instantly.

---

## 📁 Folder Structure

```text
IDPC_Script/
├── setup.bat              # Main automated script (installer, cleaner, security, firewall)
├── README.md              # Documentation
├── .SYSTEM/               # Hidden recovery directory (kept isolated from participants)
│   └── restore.bat        # Standalone recovery utility (restores firewall, sets UAC to Low)
└── software/              # Installers & packages folder
    ├── MinGW.zip          # Full MinGW GCC distribution with <bits/stdc++.h>
    ├── codeblocks.exe     # Code::Blocks IDE Installer
    ├── VSCode.exe         # Visual Studio Code Installer
    └── code-runner.vsix   # Code Runner extension (offline installation bundle)
```

*(Note: During setup, `.SYSTEM` is also deployed to `C:\.SYSTEM` as a hidden system directory).*

---

## 🔒 Security Lockdown & Anti-Cheating

1. **Admin Password & High UAC Policy**:
   - The built-in Administrator and any password-less admin accounts are secured.
   - **Password Security**: The administrator password is never displayed on the console during script execution to prevent visibility to bystanders.
   - **High UAC Enforcement**: UAC is configured to **Prompt for Credentials on the Secure Desktop** (`ConsentPromptBehaviorAdmin = 1`, `PromptOnSecureDesktop = 1`).
   - If any participant attempts to open an elevated command prompt, run administrative scripts, or alter network settings, Windows requires the administrator password.

2. **Hidden Recovery Script (`C:\.SYSTEM\restore.bat`)**:
   - The restore/unlock routine is isolated inside a **hidden** directory on both the repository and `C:\.SYSTEM`.
   - Participants viewing the contest folder will not see `.SYSTEM`.
   - Contest organizers can run [`.SYSTEM\restore.bat`](file:///e:/github.com/IDPC_Script/.SYSTEM/restore.bat) or `C:\.SYSTEM\restore.bat` post-contest.
   - **Automatic Low UAC Reset**: When `restore.bat` is executed, it removes all firewall restrictions, restores full internet access, and **sets UAC back to Low** (`ConsentPromptBehaviorAdmin = 0`, `PromptOnSecureDesktop = 0`).

3. **Workspace Sanitization**:
   - Deletes prior downloads, solutions, and temporary files from user profiles (`Desktop`, `Downloads`, `Documents`, `Pictures`, `Videos`, `Music`).
   - The `IDPC_Script` directory itself is protected and never deleted.

4. **Offline AI Removal**:
   - Halts all background processes and services for local LLMs (Ollama, LM Studio, Jan, GPT4All).
   - Deletes model weight caches (`.ollama`, `.cache\lm-studio`, etc.) to prevent offline AI inference during contests.

---

## 💻 C++ Compiler & `<bits/stdc++.h>` Support

- **MinGW Setup**:
  - `MinGW.zip` extracts directly to `C:\MinGW`.
  - Both Machine and User `PATH` are purged of conflicting paths and updated with `C:\MinGW\bin`.
  - Verified `<bits/stdc++.h>` header is present at:
    `C:\MinGW\lib\gcc\mingw32\6.3.0\include\c++\mingw32\bits\stdc++.h`
- **Code::Blocks & VS Code Integration**:
  - Code::Blocks automatically locates GCC via `C:\MinGW\bin` in PATH.
  - VS Code `settings.json` points compiler path to `C:\MinGW\bin\g++.exe`.
  - Code Runner compiles solutions using `g++ -O2 -std=c++17 $fileName -o $fileNameWithoutExt`.

---

## 🚀 Contest Workspace (`Desktop\Contest`)

The workspace is automatically created and populated with:
- **`main.cpp`**: Verified starter template with `<bits/stdc++.h>` support:
  ```cpp
  #include <bits/stdc++.h>
  using namespace std;

  int main()
  {
      cout<<"Welcome to IDPC";

      return 0;
  }
  ```
- **`.vscode/` Configuration**:
  - `tasks.json`: Default build task for C++20/C++17 with `-O2 -Wall`.
  - `launch.json`: Integrated GDB debugging configuration.
  - `c_cpp_properties.json`: Full IntelliSense pointing to `C:\MinGW\bin\g++.exe`.
- **Code Runner in VS Code**:
  - Configured with `"code-runner.runInTerminal": true` for interactive keyboard input (`cin` / `scanf`).
  - Auto-saves code before execution (`"code-runner.saveFileBeforeRun": true`).
  - Shortcut: Press `Ctrl+Alt+N` or click the Play (▶) button.
- **Auto Launch**: Automatically opens in VS Code and Code::Blocks upon setup completion.

---

## 🔒 Firewall Lockdown Rules

- **Allowed**:
  - `https://toph.co` and all subdomains (`*.toph.co`):
    - `toph.co`, `www.toph.co`, `ws.toph.co`, `uploads.toph.co`, `static.toph.co`, `drafts.toph.co`, `community.toph.co`, `blog.toph.co`, `help.toph.co`, `status.toph.co`.
  - DNS (Port 53 UDP/TCP) for domain resolution.
  - DHCP (Port 67/68 UDP) for dynamic IP assignment.
  - Localhost loopback (`127.0.0.1` and `::1`) for VS Code IPC and GDB debugging.
- **Blocked**:
  - All other external websites, unauthorized outbound/inbound connections, and external web services.

---

## 💻 CLI Commands

| Action | Command |
| :--- | :--- |
| **Run Full Automated Setup** | `setup.bat 1` (or `setup.bat /auto`, `setup.bat full`) |
| **Clean User Profile Folders** | `setup.bat 2` (or `setup.bat clean`) |
| **Remove Offline AI Tools** | `setup.bat 3` (or `setup.bat remove-ai`) |
| **Extract MinGW & Clean PATH** | `setup.bat 4` (or `setup.bat mingw`) |
| **Reinstall IDEs & Code Runner** | `setup.bat 5` (or `setup.bat reinstall`) |
| **Apply Admin Security & UAC** | `setup.bat 6` (or `setup.bat security`) |
| **Lock Internet (Toph Only)** | `setup.bat 7` (or `setup.bat lock`) |
| **Check Status & Environment** | `setup.bat 8` (or `setup.bat status`) |
| **Restore Full Access & Low UAC** | `setup.bat restore` (or run `C:\.SYSTEM\restore.bat`) |
