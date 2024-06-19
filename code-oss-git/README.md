# code-oss-git

This Docker image installs [gh CLI](https://cli.github.com/) and [gnome-keyring](https://wiki.gnome.org/Projects/GnomeKeyring).

It contains an script `github-login` that performs the login to GitHub using the `gh` CLI and store the GitHub Token in the `gnome-keyring`.
Then tou can open a session debus session and use the `gnome-keyring` to get the token with git.

## Test the image

Build the image, then run it and execute the `github-login` script.

```shell
docker build -t code-oss-git .
docker run -it --rm --entrypoint /bin/bash code-oss-git 
```

```shell
github-login
```

Then you can open a new dbus session and use the `gh` CLI.

```shell
dbus-run-session -- bash
echo "PaSSw0rd" | gnome-keyring-daemon --unlock
gh auth status
```
