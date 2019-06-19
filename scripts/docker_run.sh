#!/bin/bash
RUN_DIR=$(pwd)
cd $RUN_DIR

IMAGE=saavu-local/s_nuxt_1st_v4

RUN_DIR=$(pwd)

if [ ! -z $CONTAINER_NAME ]; then
  DOCKER_PARAM_NAME=--name=$CONTAINER_NAME
fi

if [ ! -z $PTO ]; then
  PORT_TO_OPEN=$PTO
fi

if [ ! -z $NET_NAME ]; then
 docker network create $NET_NAME 2> /dev/null
 DOCKER_PARAM_NET=--net=$NET_NAME
fi

if [ ! -f $RUN_DIR/package.json ]; then
  echo "No package.json found."
  exit 1
fi

dockerstop() {
  if [ ! -z $CONTAINER_NAME ]; then
    docker stop -t 0 $(docker ps | grep $CONTAINER_NAME | cut -d' ' -f1) > /dev/null 2>&1
  fi
}
if [ -z $RUN_IN_BG ]; then
  trap 'dockerstop' SIGINT SIGTERM EXIT
fi

# Create placeholders for folders that should exist so that
# permissions will be correct when they are mounted to the
# container.
mkdir -p $RUN_DIR/dist
mkdir -p $RUN_DIR/node_modules_app/saavu-cbin-placeholder

ARGS=${@:1}
TWO="$1 $2"
if [ "$TWO" = "yarn add" -o "$TWO" = "yarn install" ]; then
  # working with local packages (installing deps)
  WORKDIR="/ext";
  CMD="$ARGS"
else
  # working with packages already in the container
  WORKDIR="/s_nuxt_1st";
  CMD="/entry.sh $ARGS"
fi

docker run \
  -u $UID:$(id -g $USER) \
  -e NODE_ENV=$NODE_ENV \
  -e NUXT_PORT=$NUXT_PORT \
  $([ -z $RUN_IN_BG ] && echo '--rm' || echo '-d') \
  $([ ! -z $NO_TTY ] && echo '' || echo '-it') \
  $DOCKER_PARAM_NAME \
  $DOCKER_PARAM_NET \
  $([ ! -z $PORT_TO_OPEN ] && echo "-p $PORT_TO_OPEN:$PORT_TO_OPEN") \
  $([ -d $RUN_DIR/src ] && echo "--volume $RUN_DIR/src:/s_nuxt_1st/src") \
  $([ -d $RUN_DIR/dist ] && echo "--volume $RUN_DIR/dist:/s_nuxt_1st/dist") \
  $([ -d $RUN_DIR/public ] && echo "--volume $RUN_DIR/public:/s_nuxt_1st/public") \
  $([ -f $RUN_DIR/package.json ] && echo "--volume $RUN_DIR/package.json:/ext/package.json") \
  $([ -d $RUN_DIR/.webpack-cache ] && echo "--volume $RUN_DIR/.webpack-cache:/s_nuxt_1st/.webpack-cache") \
  $([ -d $RUN_DIR/node_modules_app ] && echo "--volume $RUN_DIR/node_modules_app:/ext/node_modules") \
  $([ -f $RUN_DIR/env-development ] && echo "--volume $RUN_DIR/env-development:/s_nuxt_1st/env-development") \
  $([ -f $RUN_DIR/now.json ] && echo "--volume $RUN_DIR/now.json:/s_nuxt_1st/now.json") \
  $([ -f $RUN_DIR/.gitignore ] && echo "--volume $RUN_DIR/.gitignore:/s_nuxt_1st/.gitignore") \
  $([ -f $RUN_DIR/.npmignore ] && echo "--volume $RUN_DIR/.npmignore:/s_nuxt_1st/.npmignore") \
  $([ -f $RUN_DIR/.eslintignore ] && echo "--volume $RUN_DIR/.eslintignore:/s_nuxt_1st/.eslintignore") \
  $([ -d $RUN_DIR/.nuxt ] && echo "--volume $RUN_DIR/.nuxt:/s_nuxt_1st/.nuxt") \
  $([ -f $RUN_DIR/nuxt.config.js ] && echo "--volume $RUN_DIR/nuxt.config.js:/s_nuxt_1st/nuxt.config.js") \
  $([ -f $RUN_DIR/vue.config.js ] && echo "--volume $RUN_DIR/vue.config.js:/s_nuxt_1st/vue.config.js") \
  --workdir $WORKDIR \
  --entrypoint sh \
  $IMAGE \
  -c "$CMD"
