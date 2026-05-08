#!/usr/bin/bash
set -euo pipefail

if [[ "$EUID" -ne 0 ]]; then
	echo "ERROR: This script must be run with sudo/root privileges."
	echo "Run it as: sudo ./install_service.sh"
	exit 1
fi

cd /opt/task2

echo "=== STEP 1: Compile BusyBox ==="
./compile.sh

echo "=== STEP 2: Deploy BusyBox commands and bb-httpd service ==="
./deploy.sh

echo "=== STEP 3: Run BusyBox tests ==="
./test.sh

echo "=== STEP 4: Test bb-httpd response ==="
./httptest.sh

echo
echo "=== INSTALLATION AND TESTING FINISHED SUCCESSFULLY ==="
