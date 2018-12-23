#!/bin/bash
cd /s_nuxt_1st

# copy external node modules
cp -a /ext/node_modules/* node_modules

# merge external package.json
package-json-merge ./package.json /ext/package.json > /tmp/package.json
cat /tmp/package.json > ./package.json

${@:1}
