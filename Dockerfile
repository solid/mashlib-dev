FROM ubuntu
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python3-dev \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /nvm
ENV NODE_VERSION 14.13.1

# Install nvm with node and npm
RUN mkdir /nvm \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.36.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ADD . /app
WORKDIR /app
RUN npm install
RUN mkdir workspaces
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install 13.2.0 && nvm install v12.7.0 && nvm install v11.15.0 && nvm install v10
RUN npm run setup
RUN npm run add jose \
  && npm run add oidc-rp \
  && npm run add solid-auth-client \
#  && npm run add rdflib \
  && npm run add pane-registry \
  && npm run add solid-namespace \
#  && npm run add solid-ui \
  && npm run add chat-pane \
  && npm run add contacts-pane \
  && npm run add folder-pane \
  && npm run add issue-pane \
  && npm run add meeting-pane \
  && npm run add source-pane \
  && npm run add activitystreams-pane \
#  && npm run add solid-panes \
#  && npm run add mashlib \
  && npm run add solid-multi-rp-client \
  && npm run add oidc-op \
  && npm run add keychain \
  && npm run add oidc-auth-manager \
  && npm run add node-solid-ws \
  && npm run add acl-check \
  && npm run add solid-auth-oidc \
#  && npm run add node-solid-server \
  && npm run add solid-cli \
  && npm run add solid-rest \
  && npm run add solid-auth-cli \
  && npm run add solid-auth-fetcher \
  && npm run add solid-auth-tls \
  && npm run add solid-crud-tests \
  && npm run add web-access-control-tests
CMD /bin/bash
