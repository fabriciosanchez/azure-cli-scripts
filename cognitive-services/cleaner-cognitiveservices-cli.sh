#!/bin/bash

# Global variables
rg={resource group name}

# Deleting resouce group
az group delete -n $rg
