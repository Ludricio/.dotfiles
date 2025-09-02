#!/usr/bin/env bash

# Adds rebase helper aliases with dry-run and dev-branch config support.

set -e

# Default dev branch (can be overridden per repo)
git config --global rebase.devbranch dev 

# --- squash-branch ---
git config --global alias.squash-branch '!f() { \
  base=$(git merge-base HEAD $(git config rebase.devbranch)); \
  git rebase -i $base; \
}; f'

git config --global alias.squash-branch-dry '!f() { \
  base=$(git merge-base HEAD $(git config rebase.devbranch)); \
  echo "Would run: git rebase -i $base"; \
}; f'

# --- rebase-dev ---
git config --global alias.rebase-dev '!f() { \
  branch=$(git config rebase.devbranch); \
  git fetch origin $branch && git rebase origin/$branch; \
}; f'

git config --global alias.rebase-dev-dry '!f() { \
  branch=$(git config rebase.devbranch); \
  echo "Would run: git fetch origin $branch && git rebase origin/$branch"; \
}; f'

# --- stack-refresh ---
git config --global alias.stack-refresh '!f() { \
  branch=$(git config rebase.devbranch); \
  git fetch origin $branch && \
  base=$(git merge-base HEAD $branch) && \
  git rebase -i $base && \
  git rebase origin/$branch; \
}; f'

git config --global alias.stack-refresh-dry '!f() { \
  branch=$(git config rebase.devbranch); \
  base=$(git merge-base HEAD $branch); \
  echo "Would run:"; \
  echo "  git fetch origin $branch"; \
  echo "  git rebase -i $base"; \
  echo "  git rebase origin/$branch"; \
}; f'

echo "✅ Installed git rebase helper aliases."
echo "Default dev branch set to 'dev' (override per repo with: git config rebase.devbranch <branch>)"
