#!/usr/bin/bash
set -euo pipefail

BUSYBOX="/opt/task2/busybox"

# x-means a file and checks if it is executable
if [[ ! -x "$BUSYBOX" ]]; then
	echo "The BusyBox binary '$BUSYBOX' doesn't exist or is not executable."
	exit 1
fi


# isvedam bb komandu sarasa ir sukuria /bin/bb-<command> wrapperius
# wrapper (mazas tarpinis failas kuris paleidzia kita programa)
"$BUSYBOX" --list | while read -r cmd; do
	TARGET="/bin/bb-$cmd"

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

sudo tee /etc/systemd/system/bb-httpd.service > /dev/null <<EOF
[Unit]
Description=BusyBox HTTP daemon
After=network.target

[Service]
Type=simple
ExecStart=/bin/bb-httpd -f -p 80 -h /var/www/html -c /etc/bb-httpd.conf
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF


# systemd perskaito nauja service faila
sudo systemctl daemon-reload
# servisas startuos automatiskai po reboot
sudo systemctl enable bb-httpd
# servisas paleidziamas dabar
sudo systemctl restart bb-httpd
