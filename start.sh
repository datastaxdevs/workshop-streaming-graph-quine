#!/bin/bash

dc="workshops"
bundle="secure-connect-$dc.zip"

if test ! -f $bundle; then
    echo "Please copy the $bundle bundle file into this directory" && exit
fi 

if test -f ~/.astrarc; then
    # get Astra token
    token=$(grep ASTRA ~/.astrarc | head -n 1 | cut -f 2 -d =)
    # inject Astra token into quine.conf
    sed -i.bak "s/ASTRA_TOKEN/\"$token\"/" quine.conf

    # get region
    region=$(astra db list | grep "$dc" | cut -f 4 -d '|')
    # inject region into quine.conf
    sed -i.bak "s/ASTRA_CLOUD_REGION/$region/" quine.conf

    # get bundle directory
    bundle_file="$PWD/$bundle"
    # inject secure connect bundle into quine.conf
    sed -i.bak "s|SECURE_CONNECT_BUNDLE|\"$bundle_file\"|" quine.conf

    # start Quine
    #java -Dconfig.file=quine.conf -jar quine.jar -r password-spraying-workshop.yml --force-config
else
    echo "Please set up your token with Astra Shell by running: astra setup"
fi
