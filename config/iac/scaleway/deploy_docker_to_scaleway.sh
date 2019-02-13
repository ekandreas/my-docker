#!/usr/bin/env bash

export DOCKER_HOST=tcp://ip_address_scaleway:2375
export DOCKER_TLS_VERIFY=0
export DOCKER_CERT_PATH=

docker-compose -f ././../../../docker-compose.yaml -f scaleway.yaml up -d
