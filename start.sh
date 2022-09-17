#!/bin/bash

astraRC="~/.astrarc"
dc="workshops"

if [[ -f "$astraRC" ]]; then
    # get Astra token
    token=$(grep ASTRA ~/.astrarc | head -n 1 | cut -f 2 -d =)
    # inject Astra token into quine.conf
    sed -i "s/ASTRA_TOKEN/\"$token\"/" quine.conf

    # get region
    region=$(astra db list | grep "$dc" | cut -f 4 -d '|' )
    # inject Astra token into quine.conf
    sed -i "s/ASTRA_CLOUD_REGION/$region/" quine.conf

    # start Quine
    java -Dconfig.file=quine.conf -jar quine.jar -r password-spraying-workshop.yml --force-config
else
    echo "Please set up your token with Astra Shell by running:\n astra setup"
fi
