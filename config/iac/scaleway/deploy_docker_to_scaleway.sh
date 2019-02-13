#!/usr/bin/env bash

export DOCKER_HOST=
export DOCKER_TLS_VERIFY=
export DOCKER_CERT_PATH=

docker-compose -f docker-compose.yaml -f scaleway.yaml up -d
