#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

./s_nuxt_1st.sh yarn install
./scripts/bundle.sh
./scripts/eject.sh
