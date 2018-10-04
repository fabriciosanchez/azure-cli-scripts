#!/bin/bash

# Global variables
rg={resource group name}
rg2={resource group 2 name}

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
