#!/bin/bash
set -e # exit if any error

base_path='./scripts'

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --base-path) base_path="$2"; shift 2;;
    --base-path=*) base_path="${1#*=}"; shift;;
    *) POSITIONAL_ARGS+=("$1"); shift;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

if [ "$1" == '-h' ] || [ "$1" == '--help' ]; then ~/.scripts/apc/_apc_help.sh
elif [ "$1" == 'c' ] || [ "$1" == 'chmod' ]; then ~/.scripts/apc/_chmod.sh "$2" "$base_path"
elif [ "$1" == 'n' ] || [ "$1" == 'new' ]; then ~/.scripts/apc/_script.sh "$2" "$base_path"
elif [ "$1" == 'b' ] || [ "$1" == 'branch' ]; then ~/.scripts/apc/_branch.sh "${@:2}"
elif [ "$1" == 'g' ] || [ "$1" == 'generate' ];then ~/.scripts/apc/_generate.sh "${@:1}"
else ~/.scripts/apc/_run.sh "$@"
fi
