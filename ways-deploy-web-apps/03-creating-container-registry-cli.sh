#!/bin/bash

# Global variables
rg=arecibo-acr
location=eastus
acrname=areciboacr
sku=Basic

# Create a resource group.
echo "Creating a new resource group:" $rg"..."
az group create \
    --location $location \
    --name $rg
echo "Done."
echo ""

# Creating Docker Registry
echo "Creating a new Azure Container Registry:" $acrname"..."
az acr create \
    --resource-group $rg \
    --name $acrname \
    --sku $sku
echo "Done."
echo ""