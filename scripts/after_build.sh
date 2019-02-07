#!/bin/bash
if [ -z $PROJECT_ROOT_PATH ]; then
  echo "PROJECT_ROOT_PATH not provided"
  exit 1
fi

# remove previous build if exists
rm -rf $PROJECT_ROOT_PATH/node_modules*
rm -f $PROJECT_ROOT_PATH/.ejected

$PROJECT_ROOT_PATH/scripts/build.sh

echo
echo "To start with an example base, run:"
echo "cp -a ./dependencies/s_nuxt_1st/example/src/* ./src"
echo "./s_nuxt_1st.sh yarn add axios"
echo
