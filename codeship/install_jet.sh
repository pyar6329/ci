#!/bin/bash

OS_TYPE="$(uname -s | tr \"[:upper:]\" \"[:lower:]\")"
JET_VERSION="1.15.4"

if ! which jet > /dev/null 2>&1; then
  case "${OS_TYPE}" in
    "darwin" ) INSTALL_PATH="$(brew --prefix)/sbin" ;;
    "linux" ) INSTALL_PATH="/usr/local/sbin" ;;
  esac

  curl -SLO "https://s3.amazonaws.com/codeship-jet-releases/1.15.4/jet-${OS_TYPE}_amd64_${JET_VERSION}.tar.gz"
  tar xzvf jet-${OS_TYPE}_amd64_${JET_VERSION}.tar.gz > /dev/null 2>&1
  chmod u+x jet
  sudo mv jet ${INSTALL_PATH}/jet
  rm -rf jet-${OS_TYPE}_amd64_${JET_VERSION}.tar.gz
fi

# docker login
[ -f "${HOME}/.docker/config.json" ] && rm -rf ${HOME}/.docker/config.json
docker login ${DOCKER_REGISTRY:-registry.gitlab.com} -u ${DOCKER_USER:-pyar6329} -p ${GITLAB_TOKEN} > /dev/null 2>&1

# download AES key for project, and rename to codeship.aes
jet encrypt ${HOME}/.docker/config.json dockercfg.encrypted

