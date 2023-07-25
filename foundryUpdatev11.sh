#!/bin/bash    
# chmod a+x /where/i/saved/it/foundryInstall.sh
# Foundry Installation on Oracle
# update the system and remove older packages
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean
# To update to NodeJS 18, we should stop pm2 processes
pm2 stop all
# Remove the current pm2 from startup to allow for the upgrade.
pm2 unstartup
# Add the new NodeJS version repository and update the installed version of NodeJS.
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt upgrade
# Set pm2 to use the upgraded version of NodeJS and set it to run on start again.
npm rebuild -g pm2
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
# Restart any previously running pm2 managed processes.
pm2 start all
pm2 save
# This concludes the nodejs update.
# Let's update foundry to v11 here
# stopping foundry
pm2 stop foundry
# making a copy so we can go back if needed.
mv foundry foundry-archive-v10
# Getting and installing foundry
mkdir ~/foundry
# Enter Foundry timed url for download
echo "please enter the foundry vtt v11 timed download url for the Linux NodeJS version"
read tdurl
wget --output-document ~/foundry/foundryvtt.zip "$tdurl"
unzip ~/foundry/foundryvtt.zip -d ~/foundry/
rm ~/foundry/foundryvtt.zip
# Restart foundry using pm2
pm2 start foundry
echo "Restarting the system to complete installation"
sleep 5
sudo shutdown -r now
