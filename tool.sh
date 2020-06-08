#!/bin/bash 
ARG=$1

DOCKER_ID=viewmodel

if [ "$PASSWORD" == "" ]; then
  PASSWORD=$(cat ~/.docker/password.txt)
fi

APP_NAME=$(cat app/package.json \
    | grep name \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g' \
    | awk '{$1=$1};1')

VERSION=$(cat app/package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | awk '{$1=$1};1')

if [ "$ARG" == "build" ]; then
  docker build -t "$DOCKER_ID/$APP_NAME" .
fi

if [ "$ARG" == "tag" ]; then
  echo "create tag latest"
  docker tag "$DOCKER_ID/$APP_NAME" "$DOCKER_ID/$APP_NAME:latest"
  echo "create tag $VERSION"
  docker tag "$DOCKER_ID/$APP_NAME" "$DOCKER_ID/$APP_NAME:$VERSION"
fi

if [ "$ARG" == "publish" ]; then
  echo "publish image"
  echo "$PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin
  docker push "$DOCKER_ID/$APP_NAME:latest"
  docker push "$DOCKER_ID/$APP_NAME:$VERSION"
fi

if [ "$ARG" == "name" ]; then
  echo $APP_NAME
fi

if [ "$ARG" == "version" ]; then
  echo $VERSION
fi

if [ "$ARG" == "port" ]; then
  PORT=$(cat Dockerfile \
    | grep EXPOSE \
    | head -1 \
    | awk -FEXPOSE '{ print $2 }' \
    | awk '{$1=$1};1')
  echo $PORT
fi