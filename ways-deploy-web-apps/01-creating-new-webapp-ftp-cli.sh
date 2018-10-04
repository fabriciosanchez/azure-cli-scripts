#!/bin/bash

# Global variables
warurl=https://raw.githubusercontent.com/Azure-Samples/html-docs-hello-world/master/index.html
resourcegroup={resource group name}
webappname={webapp name}
location={location}
appserviceplan={service plan name}
sku={sku for service plan}

# Download sample static HTML page
echo "Getting example of static HTML page..."
curl $warurl --output index.html
echo "Done."
echo ""

# Create a resource group.
echo "Creating a new resource group:" $resourcegroup"..."
az group create \
    --location $location \
    --name $resourcegroup
echo "Done."
echo ""

# Create an App Service plan in `FREE` tier.
echo "Creating a new App Service Hosting Plan:" $appserviceplan"..."
az appservice plan create \
    --name $appserviceplan \
    --resource-group $resourcegroup \
    --sku $sku
echo "Done."
echo ""

# Create a web app.
echo "Creating a new web app on top of" $appserviceplan"..."
az webapp create \
    --name $webappname \
    --resource-group $resourcegroup \
    --plan $appserviceplan
echo "Done."
echo ""

# Get FTP publishing profile and query for publish URL and credentials
echo "Web App criada. Getting publish profile..."
creds=($(az webapp deployment list-publishing-profiles --name $webappname --resource-group $resourcegroup --query "[?contains(publishMethod, 'FTP')].[publishUrl,userName,userPWD]" --output tsv))
echo "Done."
echo ""

# Use cURL to perform FTP upload. You can use any FTP tool to do this instead. 
echo "Uploading HTML example page to" $webappname"..."
curl -T index.html -u ${creds[1]}:${creds[2]} ${creds[0]}/
echo "Done."
echo ""

# Copy the result of the following command into a browser to see the static HTML site.
echo http://$webappname.azurewebsites.net
