#!/usr/bin/env bash
set -e

IMAGE=monetize/omnicell
REPOSITORY=947683842129.dkr.ecr.us-east-1.amazonaws.com
VERSION=$(git rev-parse HEAD)

$(aws ecr get-login --no-include-email --region us-east-1)
docker build -t ${IMAGE} .
ID=$(docker inspect --format="{{.Id}}" ${IMAGE} | sed -e "s/^.*://")

docker tag ${ID} ${REPOSITORY}/${IMAGE}:${VERSION}
docker push ${REPOSITORY}/${IMAGE}:${VERSION}
docker tag ${ID} ${REPOSITORY}/${IMAGE}:latest
docker push ${REPOSITORY}/${IMAGE}:latest
