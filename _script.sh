#!/bin/bash

path="$1"
base_path="$2"

if [ ! -d "$(dirname -- "$path")" ];then
  if gum confirm $'Some of the directories do not exist.\nShould i create them'
    then mkdir -p -- "$(dirname -- "$path")"
    else exit
  fi
fi

if [ ! -f "$path.sh" ]
  then 
    if [[ "$path" =~ .*\.(sh$) ]]; then echo "#!/bin/bash" > "$path"
    elif [[ "$path" =~ .*\.(ts$|js$) ]]; then echo "#!/usr/bin/env node" > "$path"
    else touch "$path"
    fi
    ~/.scripts/apc/_chmod.sh "$path" "$base_path"
    codium "$path"
  else echo "file $path already exists" && exit 1
fi
