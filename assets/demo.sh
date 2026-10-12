#!/usr/bin/env bash
# Records a cold install, a warm one, and zbx.
# asciinema rec -c ./assets/demo.sh assets/zb-demo.cast
set -euo pipefail

export ZEROBREW_ROOT=/tmp/zbdemo ZEROBREW_PREFIX=/tmp/zbdemo
export PATH="/tmp/zbdemo/bin:$PATH"
rm -rf /tmp/zbdemo
zb init --no-modify-path >/dev/null 2>&1
zb update >/dev/null 2>&1

type_cmd() {
  printf '\033[1;32m❯\033[0m '
  for ((i = 0; i < ${#1}; i++)); do
    printf '%s' "${1:i:1}"
    sleep 0.04
  done
  printf '\n'
  sleep 0.4
}

run() {
  type_cmd "$1"
  eval "$1"
  echo
  sleep "${2:-1.5}"
}

clear
run 'zb install imagemagick' 2
run 'zb uninstall imagemagick' 1
run 'zb install imagemagick' 2
run 'zbx tokei --version' 2

rm -rf /tmp/zbdemo
