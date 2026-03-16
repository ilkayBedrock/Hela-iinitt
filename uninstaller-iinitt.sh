#!/bin/bash

echo "[*] Uninstalling Hela Flash Tool..."

# 1. iinitt info msg
echo "Please delete the hela-watchdog service from the iinitt.c file and recompile the code"

# 2. Info the uninstaller
echo "SYSHALT after the uninstall message."
sleep 5

# 3. Remove hela binary with sudo
echo "[*] Removing hela binary executable: /usr/local/bin/hela"
sudo rm -rf /usr/local/bin/hela*

# 4. Remove tmp files
echo "[*] Removing temporary files..."
sudo rm -rf /tmp/hela_*

# 5. Confirm
echo "[+] Hela has been completely uninstalled."
