#!/bin/bash

# Global variable
rg={resource group name}
servername={server name}

# Deleting server
az sql server delete \
    --name $servername \
    --resource-group $rg \
    --yes
