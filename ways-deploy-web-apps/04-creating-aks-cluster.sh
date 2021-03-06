#!/bin/bash

# Global variables
rg={resource group}
location={location}
aksname={aks name}
nodecount=3
acrname={container registry name}
rgacr={resource group container registry}
subscriptionid={subscription id}

# Creating a resource group.
echo "Creating a new resource group:" $rg"..."
az group create \
    --location $location \
    --name $rg
echo "Done."
echo ""

# Deploying AKS cluster
echo "Deploying a new AKS cluster:" $aksname"..."
az aks create \
    --resource-group $rg \
    --name $aksname \
    --node-count $nodecount \
    --generate-ssh-keys
echo "Done."
echo ""

# Connecting with AKS cluster
echo "Connecting to" $aksname "cluster..."
az aks get-credentials \
    --resource-group $rg \
    --name $aksname
echo "Done."
echo ""

# Testing if connection was successfuly
echo "Getting AKS nodes..."
sudo kubectl get nodes
echo "Done."
echo ""

# Getting AKS service principal to link out with ACR
echo "Getting AKS service principal to link to ACR..."
spid=$(az aks show --resource-group $rg --name $aksname --query "servicePrincipalProfile.clientId" --output tsv)
echo $spid
echo "Done."
echo ""

# Getting ACR Id
echo "Getting Container Registry ID..."
acrid=$(az acr show --name $acrname --resource-group $rgacr --query "id" --output tsv)
echo $acrid
echo ""

# Creating the role assignment
echo "Create the role assignment..."
az role assignment create \
    --assignee $spid \
    --role Reader \
    --scope $acrid \
    --subscription $subscriptionid
echo "Done."
echo ""
