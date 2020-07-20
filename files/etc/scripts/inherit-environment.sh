#!/bin/bash
# Import environment variables from systemd init

(
	for e in $(tr "\000" "\n" < /proc/1/environ | grep -vE '^(PATH|PWD|TERM|LC_|HOME)'); do
	        echo "$e";
	done;
) > /etc/environment.inherited;
