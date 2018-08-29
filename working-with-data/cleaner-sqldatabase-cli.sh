#!/bin/bash

# Global variables
rg=arecibo-db

# Deleting resouce group
echo "Removing" $rg"..."
az group delete -n $rg
echo "Done."