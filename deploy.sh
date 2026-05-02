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
