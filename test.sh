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
		bb-acpid|bb-arping|bb-killall5|bb-reboot|bb-poweroff|bb-halt|bb-shutdown|bb-init|bb-mount|bb-umount|bb-fdisk|bb-fsck*|bb-mkfs*|bb-adduser|bb-deluser|bb-passwd|bb-ifconfig|bb-ip|bb-modprobe|bb-insmod|bb-rmmod)
			check "$name --help" 0 "$cmd --help"
			;;
		bb-\[)
			check "$name" 0 'bb-[ -f /etc/passwd ]'
			;;
		bb-\[\[)
			check "$name" 0 'bb-[[ -f /etc/passwd ]]'
			;;
		bb-add-shell)

			;;
		bb-addgroup)

			;;
		bb-adjtimex)

			;;
		bb-arch)
			check "$name" 0 'bb-arch'
			;;
		bb-arp)
			check "$name" 0 'bb-arp'
			;;
		bb-ascii)

			;;
		bb-ash)
			
			;;
		bb-awk)

			;;
		bb-base32)

			;;
		bb-base64)

			;;
		bb-basename)

			;;
		bb-bc)

			;;
		bb-beep)

			;;
		bb-blkdiscard)

			;;
		bb-blkid)

			;;
		bb-blockdev)

			;;
		bb-bootchartd)

			;;
		bb-brctl)

			;;
		bb-bunzip2)

			;;
		bb-bzcat)

			;;
		bb-bzip2)

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
