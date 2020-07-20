#!/bin/bash
# Need to generate local ssh host keys

[ -e /etc/.NOT_CONFIGURED ] && exit 0

dpkg-reconfigure openssh-server
