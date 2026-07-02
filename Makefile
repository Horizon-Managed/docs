# Makefile — LOCAL docs preview/validation convenience ONLY (macOS/Linux).
#
# This file is NOT run by CI. GitHub PR checks (the Mintlify cloud preview
# build) are completely unaffected by it — it exists purely to run the
# Mintlify CLI on your own machine. Windows has no `make`; see AGENTS.md for
# the equivalent `npx` commands.
#
# The Mintlify CLI needs an LTS Node (<= 24). On a Mac whose default node is 26
# (e.g. GitNexus machines), `brew install node@22` (keg-only) and these targets
# pick it up automatically without changing your default node.

# Prefer a keg-only node@22 (Apple Silicon, then Intel); else fall back to PATH node.
NODE22 := $(shell [ -x /opt/homebrew/opt/node@22/bin/node ] && echo /opt/homebrew/opt/node@22/bin || { [ -x /usr/local/opt/node@22/bin/node ] && echo /usr/local/opt/node@22/bin; })

ifeq ($(strip $(NODE22)),)
MINT := npx -y mint@latest
else
MINT := PATH="$(NODE22):$$PATH" npx -y mint@latest
endif

.PHONY: preview check node-info help

help: ## List targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN{FS=":.*?## "}{printf "  %-12s %s\n", $$1, $$2}'

preview: ## Live local preview at http://localhost:3000
	$(MINT) dev

check: ## Build + broken-link validation — run before opening a PR
	$(MINT) broken-links

node-info: ## Show which Node the mint CLI will use
ifeq ($(strip $(NODE22)),)
	@echo "Using Node from PATH:"; node --version
else
	@echo "Using keg node@22 at $(NODE22):"; $(NODE22)/node --version
endif
