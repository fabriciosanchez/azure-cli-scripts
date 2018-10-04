#!/bin/bash

# Global variables
rg={resource group name}

# Removing resource group
echo "Removing" $rg "and all the associated workloads..."
az group delete -g $rg
echo "Done."
