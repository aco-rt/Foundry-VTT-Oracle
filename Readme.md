# Installing FoundryVTT on Oracle Free tier.

## Step 1 : Create an Account on Oracle Cloud.

Its free to Create an account on [https://www.oracle.com/cloud/](https://www.oracle.com/cloud/)

Click on the try OCI for free button, follow the instructions and make an account. You will need 3 things.
- A valid email account (gmail recommended, fastest response back)
- A valid credit or debit card (You will be charged a small amount, a few cents, to check if the tranaction goes through, and then you will be refunded, so free.)
- A valid phone number. They want to make sure you are not a bot.

## Step 2 : Get an instance running

Get an oracle free tier instance running with the correct ports open. See the video on how to do this. Important point is to use the latest Ubuntu version available, currently v22.

## Step 3 : Get a domain

You may purchase a domain from a domain registrar of your choice, or do what I did and use noip to get 3 free dynamic dns domains (ddns). Just A record will be enough. Watch the video on how to do it, if you find the process a bit confusing. You will need this url which points to your Oracle instance ip.

Note: Before step 4 you will need to connect to your new VPS. Here are some tips.
Use a terminal emulator/application. Depending on your Operating system you may have to move the private key you got to the Documents folder. On windows it doesn't matter, but on certain Linux distributions, and in certain versions of the macOS, the permissions are a bit different in the downloads folder. To connect first cd into your folder containing the private key, then try using a command like

```
ssh -i yourRenamedPrivatekey.key ubuntu@yourNewNoIpDomain.ddns.net
```

## Step 4 : Get the foundryOracle.sh script 

Now let's connect to the instance and start the installation process. This script will install foundry VTT on your new instance. It will get the system updated and get the required support software installed, and It will ask for a foundryVTT timed download url, and the url you made earlier with noip or something similar.

On your new instance run the following.

```
curl -o foundryOracle.sh https://raw.githubusercontent.com/aco-rt/Foundry-VTT-Oracle/main/foundryOracle.sh
```

Once that file has downloaded, we will need to make it executable so run

```
chmod a+x foundryOracle.sh
```
Now that its executable, let's execute it by running

```
./foundryOracle.sh
```

Then enter the details asked. See video if you find the instructions a bit vague.

Note: It will open up screens to ask if you wish to restart some services about 4 times. hit the tab key and then enter key to select ok. 

## Step 4a : Download Foundry NodeJS version

During the script execution it will ask you for a timed url. This can be found under your user name on the top right of foundryvtt website. Click your user name and then the purchased license tab on the left. Select the recommended version and Linux/NodeJS version in the downloads options. Click on the Timed URL button to copy a download url. Not the Download button. We need the link to download foundryVTT from the command line. Now paste (crtl+v or right click paste) your url that was copied to the clipboard into your cmd/terminal promt. Hurry you only have 5 mins to do this step. press enter.

Now relax, you are almost done.

It will ask you for the noip(or similar or yourown domain) address that the players will use to connect to the session, make sure this address points to the instance's public ip address.

Once you have entered it, it will restart the system. Give it 30 seconds or so to restart, and go to your url, you should be in your foundry license key page. Enter your license key and you are good to go.

Note: if you are using cloudflair as your domain name registrar, make sure to use full encription, that allows the use of 3rd part ssl certificates, as we are using caddy to get a let's encrypt certificate in this method. If you are well versed with hosting websites and SSL stuff, feel free to change the script to your preference.

# Upgrading from v11 to v12. (updated on 06/08/2024)

On your foundry v11 instance run the following.

```
curl -o foundryupdatev11-v12.sh https://raw.githubusercontent.com/aco-rt/Foundry-VTT-Oracle/main/foundryUpdatev12.sh
```

Once that file has downloaded, we will need to make it executable so run

```
chmod a+x foundryupdatev11-v12.sh
```
Now that its executable, let's execute it by running

```
./foundryupdatev11-v12.sh
```

Then enter the details asked. See video if you find the instructions a bit vague.

https://www.youtube.com/watch?v=bcfH6UldX14
