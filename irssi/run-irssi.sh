#!/bin/sh --

set -e
stty -ixon -ixoff
exec /usr/bin/env -i \
        TERM="xterm-256color" \
        LANG="en_US.utf-8" \
        LC_COLLATE="en_US.utf-8" \
        LC_CTYPE="en_US.utf-8" \
        LC_MESSAGES="en_US.utf-8" \
        LC_MONETARY="en_US.utf-8" \
        LC_NUMERIC="en_US.utf-8" \
        LC_TIME="en_US.utf-8" \
        LC_ALL= \
/usr/local/bin/irssi
