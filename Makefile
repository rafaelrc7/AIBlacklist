######################### Preamble ###########################################
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.SECONDEXPANSION:
.EXTRA_PREREQS := $(MAKEFILE_LIST)
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += -j$(shell nproc)

######################### Project Settings ###################################

export TITLE = AIBlacklist
export DESCRIPTION = Blocks AI slop from search engine results
export HOMEPAGE = https://github.com/rafaelrc7/AIBlacklist
export LICENCE = https://github.com/rafaelrc7/AIBlacklist/blob/master/LICENCE
export EXPIRES = 1 day
export UPDATED != date +'%d %B %Y, %R UTC%:z'

export VERSION_MAJOR = 1
export VERSION_MINOR = 0
export VERSION_PATCH = 0
export VERSION_DATE != date +'%y.%m.%d'
export VERSION = $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_DATE)-$(VERSION_PATCH)

lists = $(outdir)/ubo.list.txt $(outdir)/ubl.list.txt $(outdir)/hosts.list.txt

sources = $(srcdir)/domains.txt

srcdir = domains
bindir = scripts
outdir = lists

all: $(lists)

ubo.%: $(sources) | $(outdir)
	cat $(^:%="%") | $(bindir)/gen-ubo.sh > "$@"

ubl.%: $(sources) | $(outdir)
	cat $(^:%="%") | $(bindir)/gen-ubl.sh > "$@"

hosts.%: $(sources) | $(outdir)
	cat $(^:%="%") | $(bindir)/gen-hosts.sh > "$@"

$(outdir):
	@$(MKDIR_P) $@

fix-sources:
	@for src in $(sources); do
		$(bindir)/fix.sh -o $$src < "$$src"
	done

check:
	@for src in $(sources); do
		@echo "Checking $$src:"
		$(bindir)/check.sh < "$$src"
	done

clean:
	$(RM) $(lists)

MKDIR_P ?= mkdir -p

.PHONY: all fix-sources check clean

