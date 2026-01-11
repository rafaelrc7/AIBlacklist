#!/usr/bin/env bash

set -e -o pipefail

sort --check --unique "$@"

