#!/bin/bash

# Global variables
rg=arecibo-mysql

# Removing resource group
echo "Removing" $rg "and all the associated workloads..."
az group delete -g $rg
echo "Done."