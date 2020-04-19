FROM alpine:latest

MAINTAINER @silvinux [silvinux7@gmail.com]

ARG TUID=1000
ARG TGID=1000
ARG USERNAME=silvinux
ARG PASSWORD=toor
ARG TZ=Europe/Madrid
ARG LOGLEVEL=info

ENV TUID=${TUID}
ENV TGID=${TGID}
ENV USERNAME=${USERNAME}
ENV PASSWORD=${PASSWORD}
ENV TZ=${TZ}
ENV LOGLEVEL=${LOGLEVEL}

RUN adduser -D -u $TUID -g $TGID flexget && \
    mkdir -p /home/flexget/.config/flexget && \
    mkdir -p /transmission/{downloads,TV_Shows} 

ADD files/run_flexget.sh /home/flexget/run_flexget.sh

RUN set -x \
    && apk add --update --no-cache \
    tzdata \
    python \
    ca-certificates \
    py2-pip \
    && pip install --upgrade pip \
    && pip install setuptools \
    && pip install flexget transmissionrpc \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo "$TZ" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* 

VOLUME ["/transmission/downloads", "/transmission/TV_Shows", "/home/flexget/.config/flexget"]
RUN chown -R $TUID:$TGID /transmission /home/flexget/ \
    && chmod +x /home/flexget/run_flexget.sh

USER flexget
CMD ["/home/flexget/run_flexget.sh"]
