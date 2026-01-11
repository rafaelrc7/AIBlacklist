#!/usr/bin/env bash

set -e -o pipefail

if [[ -n $title ]];       then echo "! Title: ${title}"; fi
if [[ -n $version ]];     then echo "! Version: ${version}"; fi
if [[ -n $description ]]; then echo "! Description: ${description}"; fi
if [[ -n $expires ]];     then echo "! Expires: ${expires}"; fi
if [[ -n $homepage ]];    then echo "! Homepage: ${homepage}"; fi
if [[ -n $updated ]];     then echo "! Last Updated: ${updated}"; fi
if [[ -n $licence ]];     then echo "! Licence: ${licence}"; fi
echo ""

if [[ -z $UBLOCK_SEARCH_ENGINES ]]; then exit 1; fi

while read -r domain; do
	if [ -z "$domain" ]; then # Skip blank lines
		continue
	fi

	echo "||${domain}^\$all"

	if [[ $UBLOCK_SEARCH_ENGINES =~ \;?brave\;? ]]; then
		echo "search.brave.com###results > div:has(a[href*=\"${domain}\"])"
	fi

	if [[ $UBLOCK_SEARCH_ENGINES =~ \;?bing\;? || $UBLOCK_SEARCH_ENGINES =~ \;?duckduckgo\;? ]]; then
		echo "duckduckgo.com,bing.com##.react-results--main > li:has(a[href*=\"${domain}\"])"
		echo "lite.duckduckgo.com##tbody > tr:has(> td > a[href*=\"${domain}\"]):xpath(self::* | following-sibling::*[position() <= 3])"
	fi

	if [[ $UBLOCK_SEARCH_ENGINES =~ \;?ecosia\;? ]]; then
		echo "ecosia.org###main .result:has(a[href*=\"${domain}\"])"
	fi

	if [[ $UBLOCK_SEARCH_ENGINES =~ \;?google\;? ]]; then
		echo "google.*###rso .MjjYud a[href*=\"${domain}\"]:upward(.MjjYud)"
	fi

	if [[ $UBLOCK_SEARCH_ENGINES =~ \;?startpage\;? ]]; then
		echo "startpage.com##.w-gl .result:has(a[href*=\"${domain}\"])"
	fi
done

