#!/bin/bash

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -u|--update) update="true"; shift;;
    *) POSITIONAL_ARGS+=("$1"); shift;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

if [ -n "$update" ];then
  if [ -n "$1" ] && [[ $(git branch) =~ $1 ]]
    then
      git checkout "$1"
      git merge "$1"
    else echo "bracnh $1 does not exist"  && exit 1
  fi
else echo "commant not provided or not supported" && exit 1
fi
