#!/bin/bash
systemctl --user start mbsync.service
notmuch new
