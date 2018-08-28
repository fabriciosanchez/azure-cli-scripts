#!/bin/bash

# Global variables
mysqllocation=eastus
mysqlrg=rgmoett-mysql
mysqlservername=mysqlservermoett
mysqlserverusername=fabricio
mysqlserverpassword=admin@1029384756
mysqlserversku=B_Gen4_2
mysqldbname=educationdb

#Creating a new resource group
az group create \
    -l $mysqllocation \
    -n $mysqlrg

# Creating MySQL Server
az mysql server create \
    -l $mysqllocation \
    -g $mysqlrg \
    -n $mysqlservername \
    -u $mysqlserverusername \
    -p $mysqlserverpassword \
    --sku-name $mysqlserversku \
    --ssl-enforcement Disabled \
    --storage-size 51200

# Creating a firewall rule allowing connection from all ips
az mysql server firewall-rule create \
    -g $mysqlrg \
    -s $mysqlservername \
    -n allowallips \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255

# Creating MySQL database
az mysql db create \
    -g $mysqlrg \
    -s $mysqlservername \
    -n $mysqldbname

# Printing information
echo Server: $mysqlservername.mysql.database.azure.com,3306
echo Username: $mysqlserverusername@$mysqlservername
echo Password: $mysqlserverpassword