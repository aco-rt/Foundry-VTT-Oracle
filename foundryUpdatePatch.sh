#!/bin/bash
# Patch update for Foundry VTT within the same major version (e.g. v14.369 -> v14.370).
# No NodeJS or pm2 changes needed: v14 builds already run on the NodeJS 24 installed by foundryUpdatev14.sh.
# chmod a+x foundryUpdatePatch.sh && ./foundryUpdatePatch.sh
set -e
cd /home/ubuntu

echo "Please enter the Foundry VTT timed download URL (NodeJS version) for the new build:"
read tdurl

# Stop Foundry
pm2 stop foundry

# Back up the current install and user data so you can roll back
stamp=$(date +%Y%m%d-%H%M)
mv foundry "foundry-archive-$stamp"
tar -czf "foundryuserdata-backup-$stamp.tar.gz" foundryuserdata

# Download and unpack the new build into a clean folder
mkdir foundry
wget --output-document foundry/foundryvtt.zip "$tdurl"
unzip -q foundry/foundryvtt.zip -d foundry/
rm foundry/foundryvtt.zip

# Start Foundry again (same pm2 process, same main.js path and data path)
pm2 start foundry
pm2 save
echo "Done. Old install kept in foundry-archive-$stamp, data backup in foundryuserdata-backup-$stamp.tar.gz"
