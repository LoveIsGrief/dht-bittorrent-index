#!/bin/bash

# install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.23.0/install.sh | bash

# Install node and set a default
source ~/.nvm/nvm.sh
nvm install 0.10
nvm alias default 0.10

# Install deps for project
cd /vagrant
npm install
npm install -g coffee-script jasmine