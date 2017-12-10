FROM alpine:latest

MAINTAINER @silvinux [silvinux7@gmail.com]

ENV FUID 1000
ENV FGID 1000
ENV TZ Europe/Madrid
ENV LOGLEVEL info


RUN adduser -D -u $FUID -g $FGID flexget && \
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
RUN chown -R $FUID:$FGID /transmission /home/flexget/ \
    && chmod +x /home/flexget/run_flexget.sh

USER flexget
CMD ["/home/flexget/run_flexget.sh"]
