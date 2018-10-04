#!/bin/bash

# Application variables
gitrepo={github repository}
branch={branch}
token={personal access token}
resourcegroup={resource group name}
webappname={webapp name}
location={location}
appserviceplan={service plan name}
sku={sku name}

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
echo "Creating a new Web App:" $webappname"..."
az webapp create \
    --name $webappname \
    --resource-group $resourcegroup \
    --plan $appserviceplan
echo "Done."
echo ""

# Deploy code from a public GitHub repository. 
echo "Deploying eShop App automatically from Github..."
az webapp deployment source config \
    --name $webappname \
    --resource-group $resourcegroup \
    --repo-url $gitrepo \
    --branch $branch \
    --git-token $token
echo "Done."
echo ""

# Copy the result of the following command into a browser to see the web app.
echo https://$webappname.azurewebsites.net
