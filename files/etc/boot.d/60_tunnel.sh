#!/bin/bash

echo "RR_SSH_HOSTS=$SATELLITE_REMOTE_HOST" >/etc/environment.tunnel

systemctl enable ssh-tunnel ssh-tunnel-reconfigure.service ssh-tunnel-reconfigure.timer \
	&& ( systemctl start ssh-tunnel ssh-tunnel-reconfigure.timer || true)
