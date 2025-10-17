#!/usr/bin/env bash

# Runs the Bitwarden CLI in REST API server mode
#
# * Authenticates via API key.
# * Persists the created session in BW_SESSION_FILE.
# * Mounts a writable, persistent volume at BITWARDENCLI_APPDATA_DIR to facilitate
#   session persistence across startups. Set this env at a suitable location,
#   e.g. '/bitwarden-appdata'.
# * Attempts to use the existing session file on startup, before logging in again.
#
# CLI docs: https://bitwarden.com/help/cli/

set -eux

# BW CLI storage handling
# https://bitwarden.com/help/data-storage/#CLI:~:text=BITWARDENCLI%5FAPPDATA%5FDIR
export BW_SESSION_FILE="${BITWARDENCLI_APPDATA_DIR}/BW_SESSION"

if [ -f "${BW_SESSION_FILE}" ]; then
  printf '\nLoading existing session key from %s\n' "${BW_SESSION_FILE}"

  BW_SESSION=$(cat "${BW_SESSION_FILE}")
  export BW_SESSION
fi

if ! bw login --check; then
  bw config server "${BW_HOST}"
  if ! bw login --apikey; then
    printf "\nFailed to login\n"
    exit 1
  fi
fi

if bw unlock --check; then
  printf "Vault is already unlocked"
else
  printf "\nUnlocking vault\n"
  # BW_PASSWORD is supposed to be the env name, not the value.
  BW_SESSION=$(bw unlock --passwordenv 'BW_PASSWORD' --raw)
  export BW_SESSION

  if ! bw unlock --check; then
    # Something went really wrong, we just logged in :/
    # Clean all state up, so that we can try again after a restart.
    printf "\nFailed to unlock vault, removing full state\n"
    rm -rf "${BITWARDENCLI_APPDATA_DIR:?}/"
    exit 1
  fi

  printf '\nSaving session key to %s\n' "${BW_SESSION_FILE}"
  echo "${BW_SESSION}"> "${BW_SESSION_FILE}"
fi

bw serve --hostname 0.0.0.0 --port 8087
