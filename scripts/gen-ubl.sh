#!/usr/bin/env bash

echo "# Title: ${TITLE}"
echo "# Version: ${VERSION}"
echo "# Description: ${DESCRIPTION}"
echo "# Expires: ${EXPIRES}"
echo "# Homepage: ${HOMEPAGE}"
echo "# Updated: ${UPDATED}"
echo "# Licence: ${LICENCE}"
echo ""

while read -r domain; do
	if [ -z "$domain" ]; then # Skip blank lines
		continue
	fi
	echo "*://*.${domain}/*"
done

