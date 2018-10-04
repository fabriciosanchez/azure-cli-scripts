#!/bin/bash

# Global variables
rg={resource group name}

# Deleting resouce group
echo "Removing" $rg"..."
az group delete -n $rg
echo "Done."
