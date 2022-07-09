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
# Install caddy for reverse proxy and https configuration
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
# Enter Foundry timed url for download
echo "please enter the foundry vtt timed download url"
read tdurl
wget --output-document ~/foundry/foundryvtt.zip "$tdurl"
unzip ~/foundry/foundryvtt.zip -d ~/foundry/
rm ~/foundry/foundryvtt.zip
# Set up pm2 to start foundry vtt at system startup or reboot.
pm2 start "node /home/ubuntu/foundry/resources/app/main.js --dataPath=/home/ubuntu/foundryuserdata" --name foundry
pm2 save

sudo rm /etc/caddy/Caddyfile
sudo mv Caddyfile /etc/caddy/Caddyfile
echo "please enter the domain url your players will use to connect to your server"
read vtturl
sed -i "s/your.hostname.com/$vtturl/g" Caddyfile