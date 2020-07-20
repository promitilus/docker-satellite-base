#!/bin/bash

set -u;

mkdir -p "$PERSISTENT_DIR/ssh";
SSH_KEY_FILE="$PERSISTENT_DIR/ssh/id_ecdsa";

# GENERATE NEW KEY PAIR IF PRIVATE CAN NOT BE FOUND
if ! [ -f $SSH_KEY_FILE ];
then
	ssh-keygen -t ecdsa -b 521 -q -N '' -f "$SSH_KEY_FILE" -C "root@${SATELLITE_HOSTNAME:-$HOSTNAME}";
fi

(
	echo;
	echo "----------------- SYSTEM PUBLIC KEY -----------------";
	echo;
	cat "$SSH_KEY_FILE.pub";
	echo;
	echo "-----------------------------------------------------";
	echo;
) >/dev/console
