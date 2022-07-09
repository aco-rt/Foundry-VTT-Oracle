#!/bin/bash    
# chmod a+x /where/i/saved/it/foundryInstall.sh
# Foundry Installation on Oracle
# update the system and remove older packages
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean
#update the iptables to open ports 80, 443, 30000
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --match multiport --dports 80,443,30000 -j ACCEPT
# save this configuration
sudo netfilter-persistent save
# install nodejs, pm2, nano, unzip
sudo apt install nano unzip -y
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install pm2 -g
#allow pm2 to start and stop after reboot
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
# make the needed directory
mkdir ~/foundry
mkdir ~/foundryuserdata