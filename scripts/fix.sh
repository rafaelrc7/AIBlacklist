#!/usr/bin/env bash

sed '/^$/d' | sort --unique "$@"

