#!/usr/bin/bash
set -euo pipefail

# prasom kad skriptas butu paleistas su sudo teisemis, EUID tai effective user id
if [[ "$EUID" -ne 0 ]]; then
        echo "ERROR: This script must be run with sudo/root priveleges"
        echo "Run it as: sudo ./deploy.sh"
        exit 1
fi

BUSYBOX="/opt/task2/busybox"

# x-means a file and checks if it is executable
if [[ ! -x "$BUSYBOX" ]]; then
	echo "The BusyBox binary '$BUSYBOX' doesn't exist or is not executable."
	exit 1
fi


# isvedam bb komandu sarasa, o while paima kiekviena komanda ir sukuria /bin/bb-<command> wrapperius
# wrapper (mazas tarpinis failas kuris paleidzia kita programa)
"$BUSYBOX" --list | while read -r cmd; do
	TARGET="/bin/bb-$cmd"
	# viska tarp <<EOF ir paskutinio EOF iraso i $TARGET faila
	cat > "$TARGET" <<EOF
#!/bin/sh
exec /opt/task2/busybox $cmd "\$@"
EOF
	chmod +x "$TARGET"

done

echo "BusyBox commands deployed successfully."


######################################################################

sudo mkdir -p /var/www/html

# tee parodo terminale outputa ir tuo paciu metu iraso ji i faila, bet naudojamas dev kad nebutu output terminale
echo "I am alive empo1010" | sudo tee /var/www/html/index.html > /dev/null


sudo tee /etc/bb-httpd.conf > /dev/null <<EOF
EOF

# irasoma serverio konfiguracija
sudo tee /etc/systemd/system/bb-httpd.service > /dev/null <<EOF
[Unit]
Description=BusyBox HTTP daemon
After=network.target

# -f — veikia foreground rezimu, reikalinga systemd
# -p 80 portas
#-h /var/www/html rodo failus is sios  dir
# -c /etc/bb-httpd.conf — naudoja config faila
[Service]
Type=simple
ExecStart=/bin/bb-httpd -f -p 80 -h /var/www/html -c /etc/bb-httpd.conf

# jei servisas nuluzta paleidzia is naujo po 2 sek.
Restart=always
RestartSec=2

# ijungia servisa su sudo systemctl enable bb-httpd
[Install]
WantedBy=multi-user.target
EOF


# systemd perskaito nauja service faila
sudo systemctl daemon-reload
# servisas startuos automatiskai po reboot
sudo systemctl enable bb-httpd
# servisas paleidziamas dabar
sudo systemctl restart bb-httpd


