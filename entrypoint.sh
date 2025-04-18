#!/bin/bash

set -e

GIT_USER_NAME="${GIT_USER_NAME:-Code User}"
GIT_USER_EMAIL="${GIT_USER_EMAIL:-code@local}"
SSH_KEYS="${SSH_KEYS:-local_default_$(date +%Y%m%d)}"

mkdir -p /config/.ssh
chmod 700 /config/.ssh

touch /config/.ssh/config
echo "" >/config/.ssh/config

IFS=',' read -ra KEYS <<<"$SSH_KEYS"
for ENTRY in "${KEYS[@]}"; do
  HOST="$(echo "$ENTRY" | cut -d_ -f1)"
  KEY_PATH="/config/.ssh/${ENTRY}"

  if [ ! -f "$KEY_PATH" ]; then
    echo "Generating SSH key: $ENTRY"
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -C "$GIT_USER_EMAIL"
  else
    echo "Using existing SSH key: $ENTRY"
  fi

  chmod 600 "$KEY_PATH"
  chmod 644 "$KEY_PATH.pub"

  cat >>/config/.ssh/config <<EOF
  Host ${HOST}.com
  HostName ${HOST}.com
  IdentityFile ${KEY_PATH}
  IdentitiesOnly yes
  User git

EOF

  echo "Public key for $ENTRY:"
  cat "${KEY_PATH}.pub"
  echo "------------------------------------------------"
done

chmod 600 /config/.ssh/config

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

git config --global url."git@github.com:".insteadOf "https://github.com/"
git config --global url."git@bitbucket.org:".insteadOf "https://bitbucket.org/"
git config --global url."git@gitlab.com:".insteadOf "https://gitlab.com/"

exec "$@"
