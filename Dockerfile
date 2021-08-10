FROM node:16-alpine
MAINTAINER @Lordslair

COPY entrypoint.sh     /entrypoint.sh

RUN apk update --no-cache \
    && apk add --no-cache git \
    && apk add --no-cache --virtual .build-deps \
                                    tzdata \
    && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && apk del .build-deps

ENTRYPOINT ["/entrypoint.sh"]
