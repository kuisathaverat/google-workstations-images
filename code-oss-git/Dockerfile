FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

RUN (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh gnome-keyring -y

COPY github-login.sh /usr/local/bin/github-login
COPY oblt-cli /usr/local/bin/oblt-cli
RUN chmod +x /usr/local/bin/github-login

ENV PATH=/home/user/go/bin/:${PATH}
