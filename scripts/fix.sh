#!/usr/bin/env bash

set -e -o pipefail

sed '/^$/d' | sort --unique "$@"

