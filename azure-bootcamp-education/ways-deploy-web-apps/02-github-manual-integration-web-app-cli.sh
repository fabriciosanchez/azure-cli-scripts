#!/bin/bash

# Application variables
gitrepo=https://github.com/fabriciosanchez/eshop.git
branch=master
token=7b1676fd1aed61f28a420a832c0008f0007c32ea
resourcegroup=rgmoett-app
webappname=moett$RANDOM
location=eastus
appserviceplan=moettserviceplan
sku=FREE

# Create a resource group.
az group create --location $location --name $resourcegroup

# Create an App Service plan in `FREE` tier.
az appservice plan create --name $appserviceplan --resource-group $resourcegroup --sku $sku

# Create a web app.
az webapp create --name $webappname --resource-group $resourcegroup --plan $appserviceplan

# Deploy code from a public GitHub repository. 
az webapp deployment source config --name $webappname --resource-group $resourcegroup --repo-url $gitrepo --branch $branch --git-token $token

# Copy the result of the following command into a browser to see the web app.
echo https://$webappname.azurewebsites.net