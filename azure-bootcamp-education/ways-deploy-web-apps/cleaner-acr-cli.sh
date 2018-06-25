#!/bin/bash

# Global variables
rg=rgmoett-acr

# Deleting resouce group
az group delete -n $rg

# Deleting ACR Service Principal
az ad sp delete --id http://acrmoett-sp