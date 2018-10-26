FROM alpine

RUN apk add --update weechat && rm -rf /var/cache/apk/* 

ARG USER
ARG UID
ARG GID
RUN addgroup -g $GID $USER
RUN adduser  -G $USER -u $UID -h /home/$USER -s /bin/sh -D $USER
WORKDIR /home/$USER
USER $USER
ENTRYPOINT weechat
