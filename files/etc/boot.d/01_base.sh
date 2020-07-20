#!/bin/bash

set -u;

mv -f /var/log $DATA_DIR &&
	ln -sf $DATA_DIR/log /var/log;
