#!/bin/sh
cd /home/flexget/
flexget --loglevel $LOGLEVEL -c /home/flexget/.config/flexget/config.yml execute
