#!/bin/bash 
ARG=$1

if [ "$ARG" == "name" ]; then
  PACKAGE_NAME=$(cat package.json \
    | grep name \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g')
  echo $PACKAGE_NAME
fi

if [ "$ARG" == "version" ]; then
  PACKAGE_VERSION=$(cat package.json \
    | grep version \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g')
  echo $PACKAGE_VERSION
fi

if [ "$ARG" == "port" ]; then
  PORT=$(cat Dockerfile \
    | grep EXPOSE \
    | head -1 \
    | awk -FEXPOSE '{ print $2 }' \
    | awk '{$1=$1};1')
  echo $PORT
fi