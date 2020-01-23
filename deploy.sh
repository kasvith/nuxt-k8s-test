#!/bin/sh

GIT_COMMIT=$(git rev-parse --short HEAD)
IMAGE=kasvith/nuxt-test:${GIT_COMMIT}

echo Building docker image for GIT Commit ${GIT_COMMIT}
docker build -t $IMAGE .

echo Pushing $IMAGE
docker push $IMAGE

echo Creating deployment

envsubst < kubernetes/deployment.tmpl > kubernetes/deployment.yaml
rm kubernetes/deployment.tmpl

kubectl apply -f ./kubernetes
