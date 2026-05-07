#!/usr/bin/bash
set -uo pipefail

RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"   # i balta spalva grizta


PASS=0
FAIL=0
SKIP=0

TESTED=""
FUNCTIONAL_PASS=0

check() {
	local test_name="$1"
	local expected="$2"
	local command="$3"
	local actual
	#paleidzia komanda kuri yra saugoma kintamajame command, eval ivykdo ja
	eval "$command" >/dev/null 2>&1
	actual=$?

	if [[ "$actual" -eq "$expected" ]]; then
		PASS=$((PASS + 1))

		if [[ "$test_name" != *"--help"* ]]; then
			FUNCTIONAL_PASS=$((FUNCTIONAL_PASS + 1))
		fi

		echo -e "${GREEN}PASS: $test_name --> expected $expected, got $actual${NC}"
	else
		FAIL=$((FAIL + 1))
		echo -e "${RED}FAIL: $test_name --> expected $expected, got $actual${NC}"
	fi
}

# funkcija kuri issaugo kad komanda jau buvo testuota, kad nebutu 2 kart testuojama
tested() {
	TESTED="$TESTED $1"
}
# patikrina, ar komanda jau buvo testuota
# jeigu komanda jau turejo test case, tai loope ji nebus testuojama dar karta
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

check "bb-cal" 0 "bb-cal 04 2006"
tested "bb-cal"

check "bb-cut" 0 "bb-echo 'emilija 20 2006' > /tmp/sample.txt && bb-cut -d ' ' -f 2 /tmp/sample.txt && bb-rm /tmp/sample.txt"
tested "bb-cut"

check "bb-cp" 0 "bb-echo 'miau miau miau' > /tmp/test1.txt && bb-cp /tmp/test1.txt /tmp/test2.txt && bb-rm /tmp/test1.txt /tmp/test2.txt"
tested "bb-cp"

check "bb-date" 0 "bb-date -s 20:15"
tested "bb-date"

check "bb-echo" 0 "echo \"I love cats \" "
tested "bb-echo"

check "bb-find" 0 "bb-find . -type f -name test.sh"
tested "bb-find"

check "bb-grep" 0 "printf 'hello\nworld\n' | bb-grep 'world'"
tested "bb-grep"

check "bb-rmdir" 0 "bb-mkdir /tmp/gaf && bb-rmdir /tmp/gaf"
tested "bb-rmdir"

check "bb-touch" 0 "bb-touch /tmp/miau.txt && bb-rm /tmp/miau.txt"
tested "bb-touch"

check "bb-sed" 0 "printf 'hello world\n' | bb-sed 's/world/BusyBox/'"
tested "bb-sed"

check "bb-mkdir" 0 "bb-mkdir /tmp/gaf && bb-rmdir /tmp/gaf"
tested "bb-mkdir"

check "bb-mv" 0 "bb-echo \"miau miau miau\" > /tmp/test3.txt | bb-mv /tmp/test3.txt /tmp/test4.txt"
tested "bb-mv"

check "bb-printf" 0 "bb-printf 'hello world\nmiau busybox\n'"
tested "bb-printf"

sudo setcap cap_net_raw+ep /opt/task2/busybox

check "bb-ping" 0 "bb-ping -c 1 127.0.0.1"
tested "bb-ping"

check "bb-pwd" 0 "bb-pwd"
tested "bb-pwd"

check "bb-rm" 0 "bb-touch /tmp/test{1..5}.txt && bb-rm /tmp/test*.txt"
tested "bb-rm"

check "bb-tail" 0 "printf '1\n2\n3\n' | bb-tail -n 1"
tested "bb-tail"

check "bb-head" 0 "printf '1\n2\n3\n' | bb-head -n 1"
tested "bb-head"

check "bb-tar" 0 "mkdir -p /tmp/bb_tar_test && touch /tmp/bb_tar_test/file && bb-tar -cf /tmp/test.tar /tmp/bb_tar_test && rm -rf /tmp/bb_tar_test /tmp/test.tar"
tested "bb-tar"

check "bb-wc" 0 "printf 'hello\n' | bb-wc"
tested "bb-wc"

check "bb-which" 0 "bb-which bb-ls"
tested "bb-which"

check "bb-who" 0 "bb-who"
tested "bb-who"

check "bb-whoami" 0 "bb-whoami"
tested "bb-whoami"

check "bb-man" 0 "bb-man --help"
tested "bb-man"

check "bb-chmod" 0 "bb-touch /tmp/foo.sh && bb-chmod a+x /tmp/foo.sh && bb-rm /tmp/foo.sh"
tested "bb-chmod"

check "bb-dirname" 0 "bb-dirname /tmp/example/file.txt"
tested "bb-dirname"

check "bb-df" 0 "bb-df /"
tested "bb-df"

check "bb-env" 0 "bb-env"
tested "bb-env"

check "bb-expr" 0 "bb-expr 1 + 1"
tested "bb-expr"

check "bb-sleep" 0 "bb-sleep 1"
tested "bb-sleep"

check "bb-sort" 0 "printf '1\n5\n8\n2\n6\n' > /tmp/numbers.txt && bb-sort -n /tmp/numbers.txt && bb-rm /tmp/numbers.txt"
tested "bb-sort"

check "bb-uniq" 0 "printf 'apple\napple\nbanana\nbanana\norange\n' | bb-uniq"
tested "bb-uniq"

echo "=== Other BusyBox Commands: --help only ==="

for cmd in /bin/bb-*; do
	# paima tik f pav. is pilno kelio, pvz. cmd="/bin/bb-ls" tada name="bb-ls"
	name="$(basename "$cmd")"

	if was_tested "$name"; then
		continue
	fi

	check "$name --help" 0 "$cmd --help"
	SKIP=$((SKIP + 1))
done

echo "------------------------"
echo "PASSED TEST CASES: $FUNCTIONAL_PASS"
echo "FAILED COMMANDS: $FAIL"
echo "SKIPPED WITH --help: $SKIP"
echo "------------------------"
