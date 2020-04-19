#!/bin/sh

set -e
CONFIGFILE=/home/flexget/.config/flexget/config.yml

if [[ ! -f ${CONFIGFILE}.bak ]]; then
        # Checks for USERNAME variable
        if [ -z "$USERNAME" ]; then
          echo >&2 'Please set an USERNAME variable (ie.: -e USERNAME=john).'
          exit 1
        fi
        # Checks for PASSWORD variable
        if [ -z "$PASSWORD" ]; then
          echo >&2 'Please set a PASSWORD variable (ie.: -e PASSWORD=hackme).'
          exit 1
        fi
        # Modify config.yaml
        sed -i.bak -e "s/TPASSWORD/$PASSWORD/" $CONFIGFILE
        sed -i.bak -e "s/TUSERNAME/$USERNAME/" $CONFIGFILE
fi

unset PASSWORD USERNAME

cd /home/flexget/
flexget --loglevel $LOGLEVEL -c /home/flexget/.config/flexget/config.yml execute
