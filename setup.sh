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

# Systemd servisi tanımlanıyor
echo "[*] hela-watchdog service creation..."
sudo tee /etc/systemd/system/hela-watchdog.service > /dev/null << EOF
[Unit]
Description=Hela Watchdog - USB connection contoller
After=multi-user.target

[Service]
ExecStart=/usr/local/bin/hela-watchdog.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Servis etkinleştiriliyor
echo "[*] Reloading the daemon & starting hela-watchdog service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable hela-watchdog.service > /dev/null
sudo systemctl start hela-watchdog.service

echo ""
echo "[✓] Hela is now ready"
