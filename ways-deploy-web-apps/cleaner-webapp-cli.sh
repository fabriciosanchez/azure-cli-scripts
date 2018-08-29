#!/bin/bash

# Global variables
rg=arecibo-webapp
rg2=arecibo-eshop

# Deleting first resouce group
echo "Removing resource group:" $rg"..."
az group delete -n $rg
echo "Done."
echo ""

# Deleting second resource group
echo "Removing resource group:" $rg"..."
az group delete -n $rg2
echo "Done."
echo ""