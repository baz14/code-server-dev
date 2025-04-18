FROM linuxserver/code-server:latest

USER root

RUN apt-get update && \
    apt-get install -y git openssh-client curl ca-certificates && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash && \
    export NVM_DIR="/root/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install node && \
    nvm alias default node && \
    nvm use default && \
    rm -rf /var/lib/apt/lists/*

ENV NVM_DIR="/root/.nvm"
ENV NODE_PATH="$NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node)/lib/node_modules"
ENV PATH="$NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node)/bin:$PATH"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "/init" ]
