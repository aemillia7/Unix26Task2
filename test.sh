#!/usr/bin/bash
set -uo pipefail

PASS=0
FAIL=0
SKIP=0

check () {
	test_name="$1"
	expected="$2"
	command="$3"
	eval "$command" >/dev/null 2>&1
	actual=$?

	if [[ "$actual" -eq "$expected" ]]; then
		PASS=$((PASS + 1))
		echo "PASS: $test_name --> expected $expected, got $actual"
	else
		FAIL=$((FAIL + 1))
		echo "FAIL: $test_name --> expected $expected, got $actual"
	fi
}

for cmd in /bin/bb-*; do
	name="$(basename "$cmd")"

	case "$name" in
		bb-acpid|bb-add-shell|bb-addgroup|bb-adjtimex|bb-arping|bb-beep|bb-blkdiscard|bb-blkid|bb-blockdev|bb-bootchartd|bb-killall5|bb-reboot|bb-poweroff|bb-halt|bb-shutdown|bb-init|bb-mount|bb-umount|bb-fdisk|bb-fsck*|bb-mkfs*|bb-adduser|bb-deluser|bb-passwd|bb-ifconfig|bb-ip|bb-modprobe|bb-insmod|bb-rmmod)
			check "$name --help" 0 "$cmd --help"
			;;
		bb-\[)
			check "$name" 0 'bb-[ -f /etc/passwd ]'
			;;
		bb-\[\[)
			check "$name" 0 'bb-[[ -f /etc/passwd ]]'
			;;
		bb-arch)
			check "$name" 0 'bb-arch'
			;;
		bb-arp)
			check "$name" 0 'bb-arp'
			;;
		bb-ascii)
			check "$name" 0 "bb-ascii"
			;;
		bb-ash)
			check "$name" 0 "echo 'exit 0' | bb-ash"
			;;
		bb-awk)
			check "$name" 0 "printf 'a b\n' | bb-awk '{print \$1}'"
			;;
		bb-base32)
			check "$name" 0 "printf 'hello' | bb-base32"
			;;
		bb-base64)
			check "$name" 0 "printf 'hello' | bb-base64"
			;;
		bb-basename)
			check "$name" 0 "bb-basename /tmp/example.txt"
			;;
		bb-bc)
			check "$name" 0 "echo '1+1' | bb-bc"
			;;
		bb-brctl)
			check "$name" 0 "bb-brctl show"
			;;
		bb-bunzip2)
			check "$name" 0 "printf 'hello\n' | bb-bzip2 | bb-bunzip2"
			;;
		bb-bzcat)
			check "$name" 0 "printf 'hello\n' | bb-bzip2 | bb-bunzip2"
			;;
		bb-bzip2)
			check "$name" 0 "printf 'hello\n' | bb-bzip2 | bb-bzcat"
			;;
		*)
			echo "SKIP: $name"
			SKIP=$((SKIP + 1))
			;;
	esac
done


echo "------------------------"
echo "PASS: $PASS"
echo "FAIL: $FAIL"
echo "SKIP: $SKIP"
echo "------------------------"
