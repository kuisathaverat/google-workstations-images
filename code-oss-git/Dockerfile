FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

RUN (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh gnome-keyring -y

RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> /etc/environment \
  && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /etc/environment \
  && echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /etc/environment

RUN curl -sL -o /usr/local/bin/gvm https://github.com/andrewkroh/gvm/releases/download/v0.5.2/gvm-linux-amd64 \
  && chmod +x /usr/local/bin/gvm

COPY github-login.sh /usr/local/bin/github-login
COPY oblt-cli /usr/local/bin/oblt-cli
RUN chmod +x /usr/local/bin/github-login \
  && chmod +x /usr/local/bin/oblt-cli

ENV PATH=/home/user/go/bin/:${PATH}
