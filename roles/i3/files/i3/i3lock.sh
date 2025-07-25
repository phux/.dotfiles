#!/bin/bash

i3lock -p default -f -t -i "$( find ~/Dropbox/screensaver -type f | shuf -n 1 )"
