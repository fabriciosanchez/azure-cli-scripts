#!/bin/bash

# Global variables
acirg={resource group name}
acilocation={location}
aciname={aci name}
acicpu={cpu number}
acimemory={memory amount}
aciport={aci public port}
aciiptype=public
acifqdn={aci fqdn}
acrname={container registry name}
acrserver={container registry uri}
appimage=$acrserver/eshopwebmvc:v1
acrspname={container registry service principal name}

# Getting ACR ID for authentication via Service Principal
acrid=$(az acr show --name $acrname --query id --output tsv)

# Creating a new ACR Service Principal with right permission
acrsppassword=$(az ad sp create-for-rbac --name $acrspname --scopes $acrid --role contributor --query password --output tsv)
acrspid=$(az ad sp show --id http://$acrspname --query appId --output tsv)

# Creating ACI resource group
az group create --name $acirg --location $acilocation

# Creating ACI and deploying application from ACR
az container create \
    --resource-group $acirg \
    --name $aciname \
    --image $appimage \
    --ip-address $aciiptype \
    --dns-name-label $acifqdn \
    --ports $aciport \
    --cpu $acicpu \
    --memory $acimemory \
    --registry-login-server $acrserver \
    --registry-username $acrspid \
    --registry-password $acrsppassword
