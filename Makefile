#!make
#----------------------------------------
# Settings
#----------------------------------------
.DEFAULT_GOAL := help

#----------------------------------------
# Variables
#----------------------------------------

#----------------------------------------
# Targets
#----------------------------------------
install: ## Installs dependencies
	@bundle install

local: ## View website locally
	@bundle exec jekyll serve

.PHONY: install local clean help

clean: ## Cleanup
	@rm -rf _site

help:
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-8s\033[0m %s\n", $$1, $$2}'