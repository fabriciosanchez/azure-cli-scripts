#!/bin/bash

# Global variables
rg={resource group}

# Deleting resouce group
az group delete -n $rg
