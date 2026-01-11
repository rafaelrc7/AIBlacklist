#!/usr/bin/env bash

set -e -o pipefail

if [[ -n $title ]];       then echo "# Title: ${title}"; fi
if [[ -n $version ]];     then echo "# Version: ${version}"; fi
if [[ -n $description ]]; then echo "# Description: ${description}"; fi
if [[ -n $expires ]];     then echo "# Expires: ${expires}"; fi
if [[ -n $homepage ]];    then echo "# Homepage: ${homepage}"; fi
if [[ -n $updated ]];     then echo "# Last Updated: ${updated}"; fi
if [[ -n $licence ]];     then echo "# Licence: ${licence}"; fi
echo ""

while read -r domain; do
	if [ -z "$domain" ]; then # Skip blank lines
		continue
	fi
	echo "*://*.${domain}/*"
done

