#!/usr/bin/env bash

set -euo pipefail

uno=$(mktemp)
trap "rm ${uno}" SIGINT

shopt -s lastpipe
while read -r one; do :; done
shopt -u lastpipe

echo $one >$uno

nohup -- /usr/local/bin/fswatch -1 $uno | \
  xargs -n1 -I{} bash -c 'sleep 1 && rm {}' \
  &>/dev/null &
echo $uno
