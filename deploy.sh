#!/bin/sh

GIT_COMMIT=$(git rev-parse --short HEAD)
IMAGE=kasvith/nuxt-test:${GIT_COMMIT}

echo Building docker image for GIT Commit ${GIT_COMMIT}
docker build -t $IMAGE .

echo Pushing $IMAGE
docker push $IMAGE

echo Creating deployment

rm -rf k8sdeploy
mkdir k8sdeploy
envsubst < kubernetes/deployment.tmpl > k8sdeploy/deployment.yaml
cp kubernetes/*.yaml k8sdeploy

kubectl apply -f ./k8sdeploy
