#!/bin/bash

# template='react' # ! for now only posibile option
# -apps-path='apps'  # ! for now only posibile option
# -libs-path='libs'  # ! for now only posibile option

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -s|--skip-scss) skip_scss="true"; shift;;
    -a|--app) app="$2"; shift 2;;
    -a=*|--app=*) app="${1#*=}"; shift ;;
    -l|--lib) lib="$2"; shift 2;;
    -l=*|--lib=*) lib="${1#*=}"; shift ;;
    *) POSITIONAL_ARGS+=("$1"); shift;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

function getPascalCase() {
  echo "$1" | sed -E 's/[[:space:]_.-]+/\n/g' | awk '{print toupper(substr($0, 1, 1)) tolower(substr($0, 2))}' | tr -d '\n'
}

path="$3"

function generate() {
  if [ -d "$path" ]; then echo "$path already exists" && exit 1; fi

  path_template="$HOME/.scripts/apc/template/react"

  mkdir -p "$path"
  name=$(basename "$path")
  parent_dir=$(dirname "$path")



  if [[ "$name" == use* ]]
    then
      name_capital="$name"
      interface="I$name"
    else 
      capital=$(getPascalCase "$name")
      name_capital=$(if [ -n "$component" ];then echo "$capital";else echo "use$capital";fi)
      interface=$(if [ -n "$component" ];then echo "I$capital";else echo "IUse$capital";fi)
  fi

  # * name.model.ts
  sed -e "s/\${interface}/$interface/" "$path_template/model"  > "$path/$name.model.ts"

  # * index.ts
  sed -e "s/\${name}/$name/" "$path_template/index"  >  "$path/index.ts"

  # * ../index.ts
  echo "export * from './${name}';" >> "${parent_dir}/index.ts"

  # * name.spec.ts
  if [ -n "$component" ];then spec_path='component';else spec_path='hook';fi
  sed -e "s/\${name_capital}/$name_capital/" -e "s/\${name}/$name/" "$path_template/$spec_path.spec"  > "$path/$name.spec.tsx"

  # * main file
  if [ -z "$skip_scss" ]
    then 
      sed -e "s/\${interface}/$interface/" -e "s/\${name_capital}/$name_capital/" -e "s/\${name}/$name/" "$path_template/component.style" > "$path/$name.tsx"
      # * name.scss
      touch "$path/$name.scss"
    else sed -e "s/\${interface}/$interface/" -e "s/\${name_capital}/$name_capital/" -e "s/\${name}/$name/" "$path_template/component" > "$path/$name.tsx"
  fi
}

if [ "$2" == 'c' ] || [ "$2" == 'component' ];then component="true";
elif [ "$2" == 'h' ] || [ "$2" == 'hook' ];then hook="true" skip_scss="true";fi

if [ -n "$component" ] || [ -n "$hook" ] && [ -n "$3" ];then 
  # ! predpostavka da je NX i da su apps/libs[name] pathovi
  dir_name=$(dirname "$path")
  if [ -f 'nx.json' ] && [[ "$path" != libs* && "$path" != apps* ]];then
    if [ -n "$app" ];then type='apps' project="$app";elif [ -n "$lib" ];then type='libs' project="$lib";else echo "project isn't provided" && exit 1;fi
    project_path="$type/$project"
    if [[ "$path" =~ $project_path ]]; then generate
    elif [ -d "$project_path" ];then
      path="$project_path/src/$(if [ -n "$component" ];then echo 'components';else echo 'hooks';fi)/$path"
      generate
    else echo "project $project_path dons't exists" && exit 1
    fi
  elif [ -d "$dir_name" ] && [ "$dir_name" != '.' ]; then generate
  else echo "dir $dir_name dosn't exist"
  fi
else echo 'command not found' && exit 1
fi
