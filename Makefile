#!make
#----------------------------------------
# Settings
#----------------------------------------
.DEFAULT_GOAL := help

#----------------------------------------
# Targets
#----------------------------------------
.PHONY: bootstrap
bootstrap: ## Ensures Node dependencies are installed
	@rm -rf node_modules
	@npm install --no-save @fullhuman/postcss-purgecss postcss-cli --silent
	@hugo version 2>&1 /dev/null

.PHONY: debug
debug: clean ## Serves the site locally in debug mode
	@hugo server --buildDrafts --gc --bind 0.0.0.0 --debug --verbose --verboseLog --log

.PHONY: dev
dev: clean ## Serves the site locally
	@hugo server --buildDrafts --minify --gc --bind 0.0.0.0

.PHONY: prod
prod: clean ## Serves the site locally but using "production" env
	@hugo server -e "production" --buildDrafts --minify --gc --bind 0.0.0.0

.PHONY: build
build: clean bootstrap ## Compiles site for production
	@hugo --minify

.PHONY: clean
clean: ## Cleanup
	@hugo mod clean
	@hugo mod tidy
	@rm -rf public
	@rm -rf resources
	@rm -f .hugo_build.lock
	@rm -f hugo_stats.json

help:
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-9s\033[0m %s\n", $$1, $$2}'
