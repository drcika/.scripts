#!/bin/bash

if [ -f "$1" ];then "$1" "${@:2}"
elif [ -f "scripts/$1" ];then "scripts/$1" "${@:2}"
elif [ -f "scripts/${1}.sh" ];then "scripts/${1}.sh" "${@:2}" 
elif [ -f "${1}.sh" ];then "${1}.sh" "${@:2}"
elif [ -f 'pnpm-lock.yaml' ];then pnpm run "${@:1}"
elif [ -f 'package-lock.json' ];then npm run "${@:1}"
else "$@"
fi
