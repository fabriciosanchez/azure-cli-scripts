#!/bin/bash

# Application variables
gitrepo=https://github.com/fabriciosanchez/eshop.git
branch=master
token=6b547383578642be12bd34a9c3fa191f0d51bc9c
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