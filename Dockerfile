FROM node:8.11.3

ARG container_user_id

RUN useradd --shell /bin/bash -u $container_user_id -o -c "" -m user-in-container

RUN mkdir -p /s_nuxt_1st/src && mkdir -p /ext/node_modules

ADD ./package.json /s_nuxt_1st
RUN cd /s_nuxt_1st && yarn install --network-timeout 80000

RUN yarn global add package-json-merge --network-timeout 80000

ADD ./ /s_nuxt_1st

ADD ./entryfiles/entry.sh /entry.sh

RUN chown -R user-in-container:user-in-container /s_nuxt_1st /ext && chmod +x /entry.sh
USER user-in-container

WORKDIR /s_nuxt_1st/src
