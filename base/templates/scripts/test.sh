#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

NET_NAME=saavunet ./s_nuxt_1st.sh yarn run test ${@:1}
