#!/bin/bash

OS_TYPE="$(uname -s)"
JET_VERSION="1.15.4"
DOCKER_USER="pyar6329"

if ! which jet; then
  [ "$OS_TYPE" = "Darwin" ] && OS_TYPE="darwin" && INSTALL_PATH="$(brew --prefix)/sbin"
  [ "$OS_TYPE" = "Linux" ] && OS_TYPE="linux" && INSTALL_PATH="/usr/local/sbin"
  curl -SLO "https://s3.amazonaws.com/codeship-jet-releases/1.15.4/jet-${OS_TYPE}_amd64_${JET_VERSION}.tar.gz"
  tar xzvf jet-${OS_TYPE}_amd64_${JET_VERSION}.tar.gz
  chmod u+x jet
  sudo mv jet ${INSTALL_PATH}/jet
  rm -rf jet-${OS_TYPE}_amd64_${JET_VERSION}.tar.gz
fi

# docker login
[ -f "${HOME}/.docker/config.json" ] && rm -rf ${HOME}/.docker/config.json
docker login registry.gitlab.com -u ${DOCKER_USER} -p ${GITLAB_TOKEN}

# download AES key for project, and rename to codeship.aes
jet encrypt ${HOME}/.docker/config.json dockercfg.encrypted
