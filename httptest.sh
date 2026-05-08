#!/usr/bin/bash
set -uo pipefail

#patikrina ar bb httpd serveris atsako per localhost
# -q quiete mode, -O- output raso i terminala o ne i faila
bb-wget -qO- http://localhost
