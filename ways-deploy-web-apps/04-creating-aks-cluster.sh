#!/bin/bash

# Global variables
rg=rgmoett-aks
location=eastus
aksname=aksmoett
nodecount=1
acrname=acrmoett
rgacr=rgmoett-acr
subscriptionid=9b3db624-2934-44c6-830f-9a17cb92cb4a

# Creating a resource group.
az group create --location $location --name $rg

# Deploying AKS cluster
az aks create --resource-group $rg --name $aksname --node-count $nodecount --generate-ssh-keys

# Connecting with AKS cluster
az aks get-credentials --resource-group $rg --name $aksname

# Testing if connection was successfuly
sudo kubectl get nodes

# Getting AKS service principal to link out with ACR
spid=$(az aks show --resource-group $rg --name $aksname --query "servicePrincipalProfile.clientId" --output tsv)
echo $spid

# Getting ACR Id
acrid=$(az acr show --name $acrname --resource-group $rgacr --query "id" --output tsv)
echo $acrid

# Creating the role assignment
az role assignment create --assignee $spid --role Reader --scope $acrid --subscription $subscriptionid