#!/usr/bin/bash
set -uo pipefail

for cmd in /bin/bb-*; do
	timeout 2 "$cmd" --help </dev/null >/dev/null 2>&1
	exit_code=$?
	echo "$cmd --> $exit_code"
done
