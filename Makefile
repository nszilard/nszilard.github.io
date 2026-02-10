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
	@pnpm install --silent
	@command -v hugo >/dev/null 2>&1 || { echo "[ERROR] hugo is not installed"; exit 1; }

.PHONY: debug
debug: clean ## Serves the site locally in debug mode
	@hugo server --buildDrafts --gc --bind 0.0.0.0 --printPathWarnings --logLevel debug

.PHONY: dev
dev: clean ## Serves the site locally
	@hugo server --printPathWarnings --buildDrafts --minify --gc --bind 0.0.0.0 --port 80

.PHONY: build
build: clean bootstrap ## Compiles site for production
	@hugo --minify

.PHONY: serve
serve: clean bootstrap ## Compiles and serves the site locally
	@hugo --environment development --minify
	@pnpm exec serve public -l 3000

.PHONY: clean
clean: ## Cleanup
	@hugo mod clean
	@hugo mod tidy
	@rm -rf public
	@rm -rf resources
	@rm -f .hugo_build.lock
	@rm -f hugo_stats.json

help:
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
