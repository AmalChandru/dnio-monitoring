FROM node:18-alpine

RUN apk update
RUN apk upgrade
RUN set -ex; apk add --no-cache --virtual .fetch-deps curl tar git ;

WORKDIR /app

COPY package.json /app

RUN npm install -g npm
# RUN npm install --production --no-audit
RUN npm i --production
RUN npm audit fix --production

RUN rm -rf /usr/local/lib/node_modules/npm/node_modules/node-gyp/test

COPY api /app/api
COPY app.js /app
COPY config /app/config
COPY util /app/util

ENV IMAGE_TAG=__image_tag__

EXPOSE 10005

#RUN adduser -D appuser
#RUN chown -R appuser /app
RUN chmod -R 777 /app
#USER appuser

CMD node app.js