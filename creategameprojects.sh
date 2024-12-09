#!/bin/bash

pushd `dirname $0`
chmod a+x devtools/bin/vpc
devtools/bin/vpc /hl2mp +everything +game_shader_dx9 -shaders /mksln everything
popd
