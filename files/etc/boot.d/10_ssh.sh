#!/bin/bash
# Need to generate local ssh host keys

mkdir -p "$DATA_DIR/ssh";

sed -i -e "s:{{ SATELLITE_REMOTE_HOST }}:$SATELLITE_REMOTE_HOST:g" \
	-e "s:{{ SATELLITE_REMOTE_USER }}:$SATELLITE_REMOTE_USER:g" \
	/etc/ssh/ssh_config

# generate host keys as needed
for type in "rsa" "dsa" "ecdsa" "ed25519";
do
	[ -e "/etc/persistent/ssh/ssh_host_${type}_key" ] && continue;
	ssh-keygen -t "$type" -f "/etc/persistent/ssh/ssh_host_${type}_key";
done;
