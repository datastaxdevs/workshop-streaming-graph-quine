SCBFile=~/.astrarc
if [ -f "$SCBFile" ]; then
    # get Astra token
    token=$(grep ASTRA ~/.astrarc | head -n 1 | cut -f 2 -d =)

    # inject Astra token into quine.conf
    sed -i 's/ASTRA_TOKEN/$token/' quine.conf

    # start Quine
    java -Dconfig.file=quine.conf -jar quine.jar -r password-spraying-workshop.yml --force-config
else
    echo "Please set up your token with Astra Shell by running:\n astra setup"
fi
