#!/bin/bash

# Global variable
rg=rgmoett-db
servername=sqlserverpoolmoett

# Deleting server
az sql server delete \
    --name $servername \
    --resource-group $rg \
    --yes