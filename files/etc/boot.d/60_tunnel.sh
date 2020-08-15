#!/bin/bash

echo "RR_SSH_HOSTS=$SATELLITE_REMOTE_HOST" >/etc/environment.tunnel

systemctl enable ssh-tunnel \
	&& ( systemctl start ssh-tunnel || true)
