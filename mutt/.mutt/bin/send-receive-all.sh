#!/bin/sh --

mbsync -a &
exec /usr/bin/env PATH=$HOME/.mail/bin:$PATH $HOME/.mail/bin/msmtp-queue  -r
