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
sudo apt install curl nano unzip -y
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install pm2 -g
sudo npm update -g pm2
sudo pm2 update
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
echo "please enter the foundry vtt timed download url for the NodeJS version"
read tdurl
wget --output-document ~/foundry/foundryvtt.zip "$tdurl"
unzip ~/foundry/foundryvtt.zip -d ~/foundry/
rm ~/foundry/foundryvtt.zip
# Set up pm2 to start foundry vtt at system startup or reboot.
pm2 start "node /home/ubuntu/foundry/resources/app/main.js --dataPath=/home/ubuntu/foundryuserdata" --name foundry
pm2 save
# Setting up Caddy reverse proxy
curl -o Caddyfile https://raw.githubusercontent.com/aco-rt/Foundry-VTT-Oracle/main/Caddyfile
sudo rm /etc/caddy/Caddyfile
sudo mv Caddyfile /etc/caddy/Caddyfile
echo "please enter the domain url your players will use to connect to your server"
read vtturl
sudo sed -i "s/your.hostname.com/$vtturl/g" /etc/caddy/Caddyfile
sudo service caddy restart
# Edit foundry options.json file to allow connections through proxy and 443
sed -i 's/"proxyPort": null/"proxyPort": 443/g' /home/ubuntu/foundryuserdata/Config/options.json
sed -i 's/"proxySSL": false/"proxySSL": true/g' /home/ubuntu/foundryuserdata/Config/options.json
sed -i 's/"hostname": null/"hostname": "$vtturl"/g' /home/ubuntu/foundryuserdata/Config/options.json
# Restarting the system to complete installation
sleep 2
clear
echo "Restarting the system to complete installation"
sleep 3
sudo shutdown -r now
