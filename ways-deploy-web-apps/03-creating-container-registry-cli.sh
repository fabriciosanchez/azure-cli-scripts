#!/bin/bash

# Global variables
rg=rgmoett-acr
location=eastus
acrname=acrmoett
sku=Basic

# Create a resource group.
az group create --location $location --name $rg

# Creating Docker Registry
az acr create --resource-group $rg --name $acrname --sku $sku