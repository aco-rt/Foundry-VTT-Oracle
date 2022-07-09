# Installing FoundryVTT on Oracle Free tier.

## Step 1 : Create an Account on Oracle Free tier

Its free to Create an account on [https://www.oracle.com/cloud/](https://www.oracle.com/cloud/)


Click on the try OCI for free button, follow the instructions and make an account. You will need 2 things.
- A valid email account (gmail recommended, fastest response back)
- A valid credit or debit card (You will be charged a small amount, a few cents, to check if the tranaction goes through, and then you will be refunded, so free.)

## Step 2 : Get an instance running

## Step 3 : Get the foundryOracle.sh script 

This script will get the system updated and get the required support software installed.

Now check if the support software installed are properly installed by running --version options

```
node --version
npm --version
pm2 --version
```

These should output version numbers of node, npm, pm2 etc.

## Step 4 : Download Foundry NodeJS version

Select the recommended version and Linux/NodeJS version in the downloads options. Click on the Timed URL button to copy a download url. Not the Download button. We need the link to download foundryVTT.