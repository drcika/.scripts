#!/bin/bash

echo
echo "    options:"
echo
echo "    -h|--help                  Print this Help."
echo
echo "    c|chmod name               chmod +x"
echo "                               expets file name to be in ./ or in ./scripts"
echo "                               otherwise provide full path"
echo
echo "    n|new name                 new script with chmod"
echo "                               file needs to be full path aka scripts/test.sh"
echo
echo "    b|branche                  "
echo "      -u|--update name         target branch to merge with current branche"
echo
echo "    script_name|command        .sh ar optional and looks for in ./ or ./scripts/"
echo
echo "    g|generate                 generate hook or component depend on subcommand"
echo "      c|components             sub command for generate"
echo "      h|hook                   sub command for generate"
echo "      -a|-app project_name     required if path omited"
echo "      -l|-lib project_name     required if path omited"
echo "      -s|--skip-scss           skip scss file generation"
echo "      path/name | name         path and name form component or hook"
echo "                               if NX and /apps | /libs path can be omited"
echo
