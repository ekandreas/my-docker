#!/usr/bin/env bash

# Composer
docker build -t composer -f config/docker/Dockerfile.composer .

# Nginx
docker build \
    -t eu.gcr.io/elseif/my-docker-nginx:latest \
    -f config/docker/Dockerfile.nginx .

# Web
docker build \
    -t eu.gcr.io/elseif/my-docker-web:latest \
    -f config/docker/Dockerfile.web .

gcloud auth configure-docker --quiet
docker push eu.gcr.io/elseif/my-docker-nginx:latest
docker push eu.gcr.io/elseif/my-docker-web:latest

kubectl delete deployment mydockernginx
kubectl delete deployment mydockerweb
kubectl delete deployment mydockersql

eval $(minikube docker-env)

helm version \
	--tiller-namespace tiller

kubectl create deployment mydockernginx --image=eu.gcr.io/elseif/my-docker-nginx:latest
kubectl create deployment mydockerweb --image=eu.gcr.io/elseif/my-docker-web:latest
kubectl create deployment mydockersql --image=mysql:5.7

