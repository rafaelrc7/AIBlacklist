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

# List Header Information
export title = AIBlacklist
export description = Blocks AI slop from search engine results
export homepage = https://github.com/rafaelrc7/AIBlacklist
export licence = https://github.com/rafaelrc7/AIBlacklist/blob/master/LICENCE
export expires = 1 day
export updated != date +'%d %B %Y, %R UTC%:z'

version_major = 1
version_minor = 0
version_patch = 0
version_date != date +'%y.%m.%d'
export version = $(version_major).$(version_minor).$(version_date)-$(version_patch)

# Project Directories
srcdir = domains
bindir = scripts
outdir = lists

# Combined Domains List File
combined-domains = combined-domains.txt

# Blocked Search Engines
export UBLOCK_SEARCH_ENGINES ?= bing;brave;duckduckgo;ecosia;google;startpage

# Input Domains Lists
sources = $(srcdir)/domains.txt

# Output Lists
lists = \
$(outdir)/hosts.list.txt \
$(outdir)/ubl.list.txt \
$(outdir)/ubo.list.txt \
$(outdir)/ubo.bing.txt \
$(outdir)/ubo.brave.txt \
$(outdir)/ubo.duckduckgo.txt \
$(outdir)/ubo.ecosia.txt \
$(outdir)/ubo.google.txt \
$(outdir)/ubo.startpage.txt \

# Rules
all: $(lists)

# Search Engine Specific UBO BlackLists
$(outdir)/ubo.bing.txt: UBLOCK_SEARCH_ENGINES = bing
$(outdir)/ubo.brave.txt: UBLOCK_SEARCH_ENGINES = brave
$(outdir)/ubo.duckduckgo.txt: UBLOCK_SEARCH_ENGINES = duckduckgo
$(outdir)/ubo.ecosia.txt: UBLOCK_SEARCH_ENGINES = ecosia
$(outdir)/ubo.google.txt: UBLOCK_SEARCH_ENGINES = google
$(outdir)/ubo.startpage.txt: UBLOCK_SEARCH_ENGINES = startpage

$(combined-domains): $(sources)
	cat $(^:%="%") > "$@"

ubo.%: $(combined-domains) | $(outdir)
	$(bindir)/gen-ubo.sh < $< > "$@"

ubl.%: $(combined-domains) | $(outdir)
	$(bindir)/gen-ubl.sh < $< > "$@"

hosts.%: $(combined-domains) | $(outdir)
	$(bindir)/gen-hosts.sh < $< > "$@"

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
	$(RM) $(combined-domains)
	$(RM) $(lists)

MKDIR_P ?= mkdir -p

.PHONY: all fix-sources check clean

