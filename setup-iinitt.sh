#!/bin/bash

set -e

clear
echo "[*] Hela setup is starting..."

echo "Please don't forget to install Heimdall (Henrik Grimler's fork)"
sleep 4
# hela scripti kuruluyor
echo "[*] Installing hela executable to '/usr/local/bin/hela'..."
sudo mv hela /usr/local/bin/hela 2>/dev/null || true
sudo chmod +x /usr/local/bin/hela

# Watchdog scripti oluşturuluyor
echo "[*] Creating file 'hela-watchdog.sh'..."
sudo tee /usr/local/bin/hela-watchdog.sh > /dev/null << 'EOF'
#!/bin/bash
while true; do
    if ! lsusb | grep -q "04e8.*Download mode"; then
        rm -f /tmp/hela_last_flash
    fi
    sleep 1
done
EOF
sudo chmod +x /usr/local/bin/hela-watchdog.sh

# Servis icin ne yapilmasi gerektigi echolaniyor
echo "Please add this: 'start_service("/usr/local/bin/hela-watchdog.sh");' line to your iinitt.c file and rebuild it..."
echo "Then SYSHALT the system (Ctrl+Alt+Del)"

echo ""
echo "[✓] Hela is now ready"
