#!/usr/bin/bash
set -uo pipefail

RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"   # i balta spalva grizta


PASS=0
FAIL=0
SKIP=0

TESTED=""

check() {
	local test_name="$1"
	local expected="$2"
	local command="$3"
	local actual

	eval "$command" >/dev/null 2>&1
	actual=$?

	if [[ "$actual" -eq "$expected" ]]; then
		PASS=$((PASS + 1))
		echo -e "${GREEN}PASS: $test_name --> expected $expected, got $actual${NC}"
	else
		FAIL=$((FAIL + 1))
		echo -e "${RED}FAIL: $test_name --> expected $expected, got $actual${NC}"
	fi
}

tested() {
	TESTED="$TESTED $1"
}

was_tested() {
	[[ " $TESTED " == *" $1 "* ]]
}

echo "=== BusyBox Functional Tests ==="

check "bb-ls" 0 "bb-ls /tmp"
tested "bb-ls"

check "bb-cat" 0 "bb-cat /etc/hostname"
tested "bb-cat"

check "bb-bzip2" 0 "printf 'hello\n' | bb-bzip2 | bb-bzcat"
tested "bb-bzip2"

check "bb-[" 0 "bb-[ -f /etc/passwd ]"
tested "bb-["

check "bb-[[" 0 "bb-[[ -f /etc/passwd ]]"
tested "bb-[["

check "bb-arch" 0 "bb-arch"
tested "bb-arch"

check "bb-arp" 0 "bb-arp"
tested "bb-arp"

check "bb-ash" 0 "echo 'exit 0' | bb-ash"
tested "bb-ash"

check "bb-awk" 0 "printf 'a b\n' | bb-awk '{print \$1}'"
tested "bb-awk"

check "bb-base32" 0 "printf 'hello' | bb-base32"
tested "bb-base32"

check "bb-base64" 0 "printf 'hello' | bb-base64"
tested "bb-base64"

check "bb-basename" 0 "bb-basename /tmp/example.txt"
tested "bb-basename"

check "bb-bc" 0 "echo '1+1' | bb-bc"
tested "bb-bc"

check "bb-bunzip2" 0 "printf 'hello\n' | bb-bzip2 | bb-bunzip2"
tested "bb-bunzip2"

check "bb-cal"
tested "bb-cal"

check "bb-cut"
tested "bb-cut"

check "bb-cp"
tested "bb-cp"

check "bb-date"
tested "bb-date"

check "bb-echo"
tested "bb-echo"

check "bb-find"
tested "bb-find"

check "bb-grep"
tested "bb-grep"

check "bb-httpd"
tested "bb-httpd"

check "bb-rmdir"
tested "bb-rmdir"

check "bb-touch"
tested "bb-touch"

check "bb-sed"
tested "bb-sed"

check "bb-mkdir"
tested "bb-mkdir"

check "bb-mv"
tested "bb-mv"

check "bb-ping"
tested "bb-ping"

check "bb-printf"
tested "bb-printf"

check "bb-pwd"
tested "bb-pwd"

check "bb-rm"
tested "bb-rm"

check "bb-tail"
tested "bb-tail"

check "bb-head"
tested "bb-head"

check "bb-tar"
tested "bb-tar"

check "bb-wc"
tested "bb-wc"

check "bb-which"
tested "bb-which"

check "bb-who"
tested "bb-who"

check "bb-whoami"
tested "bb-whoami"

check "bb-man"
tested "bb-man"

check "bb-chmod"
tested "bb-chmod"

check "bb-dirname"
tested "bb-dirname"

check "bb-du"
tested "bb-du"

check "bb-df"
tested "bb-df"

check "bb-env"
tested "bb-env"

check "bb-expr"
tested "bb-expr"

check "bb-sleep"
tested "bb-sleep"

check "bb-sort"
tested "bb-sort"

check "bb-uniq"
tested "bb-uniq"

echo "=== Other BusyBox Commands: --help only ==="

for cmd in /bin/bb-*; do
	name="$(basename "$cmd")"

	if was_tested "$name"; then
		continue
	fi

	check "$name --help" 0 "$cmd --help"
	SKIP=$((SKIP + 1))
done

echo "------------------------"
echo "PASSED TEST CASES: $PASS"
echo "FAILED COMMANDS: $FAIL"
echo "SKIPPED WITH --help: $SKIP"
echo "------------------------"
