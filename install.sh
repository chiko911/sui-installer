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
  bash <(curl -s https://raw.githubusercontent.com/chiko911/useful-scripts/main/docker-compose.sh)
}

function prepare {
  mkdir sui
  cd sui
  wget https://raw.githubusercontent.com/MystenLabs/sui/main/docker/fullnode/docker-compose.yaml
  wget https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml
  wget https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
  sed -i 's/127.0.0.1/0.0.0.0/' fullnode-template.yaml
  
}

function run_docker {
  docker compose up -d
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
echo "starting docker"
line
run_docker
line
echo "installation complete, check logs by command:"
echo "docker-compose -f $HOME/sui/docker-compose.yaml logs -f --tail=100"
