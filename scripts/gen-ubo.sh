#!/usr/bin/env bash

echo "! Title: ${TITLE}"
echo "! Version: ${VERSION}"
echo "! Description: ${DESCRIPTION}"
echo "! Expires: ${EXPIRES}"
echo "! Homepage: ${HOMEPAGE}"
echo "! Updated: ${UPDATED}"
echo "! Licence: ${LICENCE}"
echo ""

while read -r domain; do
	if [ -z "$domain" ]; then # Skip blank lines
		continue
	fi
	echo "||${domain}^\$all"
	echo "google.*###rso .MjjYud a[href*=\"${domain}\"]:upward(.MjjYud)"
	echo "duckduckgo.com,bing.com##.react-results--main > li:has(a[href*=\"${domain}\"])"
	echo "lite.duckduckgo.com##tbody > tr:has(> td > a[href*=\"${domain}\"]):xpath(self::* | following-sibling::*[position() <= 3])"
	echo "search.brave.com###results > div:has(a[href*=\"${domain}\"])"
	echo "startpage.com##.w-gl .result:has(a[href*=\"${domain}\"])"
	echo "ecosia.org###main .result:has(a[href*=\"${domain}\"])"
done

