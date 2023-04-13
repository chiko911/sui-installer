#!/bin/bash

function logo {
  bash <(curl -s https://raw.githubusercontent.com/chiko911/useful-scripts/main/introduce.sh)
}

function line {
  echo "-----------------------------------------------------------------------------"
}

function colors {
  GREEN="\e[1m\e[32m"
  RED="\e[1m\e[39m"
  NORMAL="\e[0m"
}

function main_tools {
  bash <(curl -s https://raw.githubusercontent.com/chiko911/useful-scripts/main/tools.sh)
}

function docker {
  bash <(curl -s https://raw.githubusercontent.com/chiko911/useful-scripts/main/docker.sh)
}

function prepare {
  mkdir -p $HOME/sui
  cd $HOME/sui
  wget -O $HOME/sui/fullnode-template.yaml https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
  wget -O $HOME/sui/genesis.blob  https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
  IMAGE="mysten/sui-node:38826623bba3844a716729a66693fcdc5f917428"
  wget -O $HOME/sui/docker-compose.yaml https://raw.githubusercontent.com/MystenLabs/sui/main/docker/fullnode/docker-compose.yaml
  sed -i.bak "s|image:.*|image: $IMAGE|" $HOME/sui/docker-compose.yaml
}

function run_docker {
  docker-compose -f ${HOME}/sui/docker-compose.yaml pull
  docker-compose -f ${HOME}/sui/docker-compose.yaml up -d
}

colors
line
logo
line
echo "installing tools...."
line
main_tools
docker
line
echo "prepare directory and docker files"
line
prepare
line
echo "starting docker-compose"
line
run_docker
line
echo "installation complete, check logs by command:"
echo "docker-compose -f $HOME/sui/docker-compose.yaml logs -f --tail=100"
