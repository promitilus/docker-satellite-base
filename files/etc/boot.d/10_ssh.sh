#!/bin/bash
# Need to generate local ssh host keys

mkdir -p "$DATA_DIR/ssh";

sed -i -e "s:{{ SATELLITE_REMOTE_HOST }}:$SATELLITE_REMOTE_HOST:g" \
	-e "s:{{ SATELLITE_REMOTE_USER }}:$SATELLITE_REMOTE_USER:g" \
	/etc/ssh/ssh_config

[ -e /etc/.NOT_CONFIGURED ] && exit 0

dpkg-reconfigure openssh-server
