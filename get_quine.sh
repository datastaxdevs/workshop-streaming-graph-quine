#!/bin/bash

# Download the latest release
curl -s https://api.github.com/repos/thatdot/quine/releases/latest \
| grep "browser_download_url.*jar" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i -

# Create a Quine sym-link
ln -s $(ls -tr quine-*.jar | tail -1) quine.jar

# Download the sample data
wget https://that.re/attempts --max-redirect=10 -O attempts.json