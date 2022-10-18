#!/bin/bash
source .env

db=$DB_NAME
bundle="secure-connect-workshops.zip"

if test ! -f $bundle; then
    echo "Downloading Astra secure connect bundle..."
    astra db download-scb $DB_NAME -f $bundle

    if test ! -f $bundle; then
        echo "Download of SCB failed!" && exit
    fi
fi

if test -f ~/.astrarc; then
    # get Astra token
    token=$(grep ASTRA ~/.astrarc | head -n 1 | cut -f 2 -d =)
    # inject Astra token into quine.conf
    sed -i.bak "s/ASTRA_TOKEN/\"$token\"/" quine.conf

    # get region
    region=$(astra db list | grep "$db" | cut -f 4 -d '|')
    # inject region into quine.conf
    sed -i.bak "s/ASTRA_CLOUD_REGION/$region/" quine.conf

    # get bundle directory
    bundle_file="$PWD/$bundle"
    # inject secure connect bundle into quine.conf
    sed -i.bak "s|SECURE_CONNECT_BUNDLE|\"$bundle_file\"|" quine.conf

    # start Quine
    java -Dconfig.file=quine.conf -jar quine.jar -r password-spraying-workshop.yml --force-config
else
    echo "Please set up your token with Astra Shell by running: astra setup"
fi
