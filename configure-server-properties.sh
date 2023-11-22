#!/usr/bin/env bash
set -e

vars=("${!MC_@}")

if [ ! -f /minecraft/server.properties ]; then 
    echo "#" > /minecraft/server.properties
fi

for var in "${vars[@]}"; do

    name=$(echo "$var" | tr '[:upper:]' '[:lower:]' | sed -e 's/^mc_//' -e 's/_/-/')
    value=$(printenv "$var")

    echo "$name=$value"

    sed -i "/^$name=/{h;s/=.*/=$value/};\${x;/^$/{s//$name=$value/;H};x}" /minecraft/server.properties
done