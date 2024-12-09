#!/bin/bash

pushd `dirname $0`
chmod a+x devtools/bin/vpc
devtools/bin/vpc /hl2mp +everything /mksln everything
popd
