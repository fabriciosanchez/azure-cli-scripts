#!/bin/bash

# Replace the following URL with a public GitHub repo URL
gitrepo=
branch=master
resourcegroup=rgmoett
webappname=moett$RANDOM
location=eastus
appserviceplan=moettserviceplan
sku=FREE

# Create a resource group.
az group create --location $location --name $resourcegroup

# Create an App Service plan in `FREE` tier.
az appservice plan create --name $webappname --resource-group $resourcegroup --sku $sku

# Create a web app.
az webapp create --name $webappname --resource-group $resourcegroup --plan $appserviceplan

# Deploy code from a public GitHub repository. 
az webapp deployment source config --name $webappname --resource-group $resourcegroup --repo-url $gitrepo --branch $branch --manual-integration

# Copy the result of the following command into a browser to see the web app.
echo http://$webappname.azurewebsites.net