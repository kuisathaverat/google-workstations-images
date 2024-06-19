#!/usr/bin/env bash
# This script is used to login to GitHub using a personal access token

function ask_for_name() {
  read -rp "Enter your name: " name
  echo "Set user.name to ${name}"
  git config --global user.name "${name}"
}

function ask_for_email() {
  read -rp "Enter your email: " email
  echo "Set user.email to $email"
  git config --global user.email "${email}"
}

function ask_for_password(){
  read -rp "Enter your password: " password
  echo "Set password to $password"
}

if [ -z "$(git config --global user.name)" ]; then
  ask_for_name
fi

if [ -z "$(git config --global user.email)" ]; then
  ask_for_email
fi

if [ -z "$(git config --global credential.helper)" ];  then
  echo "Setting credential.helper to cache"
  git config --global credential.helper cache
fi

PASSWORD_KEYRING=$(ask_for_password)
dbus-run-session -- bash --noprofile --norc <<EOF
# Back them up first if you'd like
rm -rf ~/.local/share/keyrings
echo -n "${PASSWORD_KEYRING}" | gnome-keyring-daemon --unlock
git config --global --list
gh auth login --git-protocol https --web --skip-ssh-key
gh auth setup-git
EOF

echo "To open a new terminal with the GitHub session, run the following command:"
echo "dbus-run-session -- bash"
echo "echo -n ${PASSWORD_KEYRING} | gnome-keyring-daemon --unlock"


