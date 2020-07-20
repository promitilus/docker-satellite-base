#!/bin/bash

systemctl enable ssh-tunnel \
	&& ( systemctl start ssh-tunnel || true)

