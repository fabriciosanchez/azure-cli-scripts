#!/bin/bash

# Global variables
warurl=https://raw.githubusercontent.com/Azure-Samples/html-docs-hello-world/master/index.html
resourcegroup=rgmoett
webappname=moett$RANDOM
location=eastus
appserviceplan=moettserviceplan
sku=FREE

# Download sample static HTML page
curl $warurl --output index.html

# Create a resource group.
az group create --location $location --name $resourcegroup

# Create an App Service plan in `FREE` tier.
az appservice plan create --name $appserviceplan --resource-group $resourcegroup --sku $sku

# Create a web app.
az webapp create --name $webappname --resource-group $resourcegroup --plan $appserviceplan

# Get FTP publishing profile and query for publish URL and credentials
creds=($(az webapp deployment list-publishing-profiles --name $webappname --resource-group $resourcegroup --query "[?contains(publishMethod, 'FTP')].[publishUrl,userName,userPWD]" --output tsv))

# Use cURL to perform FTP upload. You can use any FTP tool to do this instead. 
curl -T index.html -u ${creds[1]}:${creds[2]} ${creds[0]}/

# Copy the result of the following command into a browser to see the static HTML site.
echo http://$webappname.azurewebsites.net