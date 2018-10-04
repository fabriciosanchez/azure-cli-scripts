#!/bin/bash

# Global variables
vnetname={virtual network name}
subnetname={subnet name}
vnetprefix=10.0.0.0/16
subnetprefix=10.0.0.0/24
rg={resource group}
nsgname={network security group}
location={west us}

# Creating the firewall (NSG) to the subnet of our data migration process
az network nsg create \
    -g $rg \
    -n $nsgname \
    -l $location

# Allowing ports required by migration process
az network nsg rule create \
    --resource-group $rg \
    --nsg-name $nsgname \
    --name open_443 \
    --priority 100 \
    --access Allow \
    --direction Inbound \
    --destination-port-ranges 443

az network nsg rule create \
    --resource-group $rg \
    --nsg-name $nsgname \
    --name open_53 \
    --priority 200 \
    --access Allow \
    --direction Inbound \
    --destination-port-ranges 53

az network nsg rule create \
    --resource-group $rg \
    --nsg-name $nsgname \
    --name open_9354 \
    --priority 300 \
    --access Allow \
    --direction Inbound \
    --destination-port-ranges 9354

az network nsg rule create \
    --resource-group $rg \
    --nsg-name $nsgname \
    --name open_445 \
    --priority 400 \
    --access Allow \
    --direction Inbound \
    --destination-port-ranges 445

az network nsg rule create \
    --resource-group $rg \
    --nsg-name $nsgname \
    --name open_12000 \
    --priority 500 \
    --access Allow \
    --direction Inbound \
    --destination-port-ranges 12000


# Creating Azure Vnet and subnets to support data migration service
az network vnet create \
    -g $rg \
    -n $vnetname \
    --address-prefix $vnetprefix

# Creating a new subnet with a NSG attached
az network vnet subnet create \
    -g $rg \
    --vnet-name $vnetname \
    -n $subnetname \
    --address-prefix $subnetprefix \
    --network-security-group $nsgname

