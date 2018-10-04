#!/bin/bash

# Global variables
rg={resource group name}
# Deleting resouce group
az group delete -n $rg

# Deleting ACR Service Principal
az ad sp delete --id http://acrmoett-sp
