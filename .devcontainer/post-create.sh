#!/usr/bin/env bash

set -euo pipefail

export PATH="/usr/local/cargo/bin:/usr/local/share/nvm/current/bin:$PATH"

sudo env DEBIAN_FRONTEND=noninteractive apt-get update
sudo env DEBIAN_FRONTEND=noninteractive apt-get install \
  --yes \
  --no-install-recommends \
  fish \
  libpam0g-dev

sudo -E env PATH="$PATH" npm install --global \
  @anthropic-ai/claude-code \
  @openai/codex

if [[ -n "${GH_TOKEN:-}${GITHUB_TOKEN:-}" ]]; then
  gh auth setup-git --hostname github.com --force
fi

cargo fetch --locked
