#!/usr/bin/bash
set -euo pipefail


# prasom kad skriptas butu paleistas su sudo teisemis, EUID tai effective user id
if [[ "$EUID" -ne 0 ]]; then
	echo "ERROR: This script must be run with sudo/root priveleges"
	echo "Run it as: sudo ./compile.sh"
	exit 1
fi


ROOT="/opt/task2"
SRC="$ROOT/src"

BB_VERSION="1.37.0"
BB_ARCHIVE="busybox-${BB_VERSION}.tar.bz2"
BB_DIR="${SRC}/busybox-${BB_VERSION}"
BB_URL="https://busybox.net/downloads/${BB_ARCHIVE}"


# patikriniam ar yra reikalingi tools jei ne tai idiegiam
# -v rodo komandos kelia pvz /usr/bin/python3
for cmd in wget tar python3 make gcc bzip2; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
                echo "Required tool '$cmd' is missing."
                echo "Trying to install build dependencies using apt..."
                sudo apt update
                sudo apt install -y wget tar python3 make gcc bzip2
                break
        fi
done


#jei dar nera katalogo tai sukuriam ji.
# sis katalogas reikalingas kad atsiustas bb archyvas atsirastu src kataloge
# pagal uzduoties reikalavimus
mkdir -p "$SRC"
cd "$SRC"

# patikrinam ar yra archyvas ar ne
# reikalinga tam, kad kai kiekviena karta paleidziant si skripta
# nekurtu vis is naujo to paties failo
if [[ ! -f "${BB_ARCHIVE}" ]]; then
	echo "-----------------BusyBox archive not found.------------------"
	echo "-----------------Downloading BusyBox...----------------------"
	wget "$BB_URL"
	echo "-----------------BusyBox has been installed------------------"
fi

# isarchyvojam bb, jei src katalogo dar nera
# x-extract; j-.bz2 archivas; f-failo pavadinimas
if [[ ! -d "$BB_DIR" ]]; then
        echo "-----------------Extracting BusyBox source...----------------"

        if command -v bzip2 >/dev/null 2>&1; then
                tar -xjf "$BB_ARCHIVE"
        else
                python3 -m tarfile -e "$BB_ARCHIVE"
        fi
fi


# pereinam i bb kataloga, nes kompiliacija butent sioj dir turi vykt
cd "$BB_DIR"

# isvalom sena konfiguracija + pridejau true nes jei pirma karta nera ka valyt
# tai skriptas gali sustot xdd
make distclean || true
# sukuria default konfigur.
make defconfig


#reiskia kad bb sukompiliuotas kaip vienas failas be isoriniu biblioteku
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config
#isjungia traffic control, reikalingas kad isvengtum possible kompiliavimo problemas
sed -i 's/^CONFIG_TC=y/# CONFIG_TC is not set/' .config
## Parodo konfig. eilutes kad patikrinti ar pakeitimai pritaikyti
grep -E '^(CONFIG_STATIC=y|# CONFIG_TC is not set)' .config
# papildomai patikrina ar ijungtas config static
grep '^CONFIG_STATIC=y' .config

#kompiliuoja bb
make -j"$(nproc)"

systemctl stop bb-httpd 2>/dev/null || true

cp busybox "$ROOT/busybox"
chmod +x "$ROOT/busybox"
"$ROOT/busybox" --help | head

echo "=== COMPILATION IS FINISHED ==="
