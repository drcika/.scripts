#!/bin/bash

name="$1"
base_path="$2"

if [[ "$name" =~ .*\.(sh$|ts$|js$) ]] && [ -f "$name" ]; then FILE_path="$name"
elif [[ "$name" =~ .*\.(sh$|ts$|js$) ]] && [ -f "$base_path/$name" ];then FILE_path="$base_path/$name"
elif [ -f "$name.sh" ]; then FILE_path="$name.sh"
elif [ -f "$base_path/$name.sh" ]; then FILE_path="$base_path/$name.sh"
elif [ -f "$name.ts" ];then FILE_path="$name.ts"
elif [ -f "$base_path/$name.ts" ]; then FILE_path="$base_path/$name.ts"
elif [ -f "$name.js" ];then FILE_path="$name.js"
elif [ -f "$base_path/$name.js" ]; then FILE_path="$base_path/$name.js"
fi

if [ -n "$FILE_path" ]
  then chmod +x "$FILE_path" && echo "chmod $FILE_path"
  else echo "could not find the file $1" && exit 1
fi
