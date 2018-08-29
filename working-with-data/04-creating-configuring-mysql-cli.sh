#!/bin/bash

# Global variables
mysqllocation=westus
mysqlrg=arecibo-mysql
mysqlservername=arecibo-mysqlserver
mysqlserverusername=fabricio
mysqlserverpassword=admin@1029384756
mysqlserversku=B_Gen4_2
mysqldbname=catalogdb

#Creating a new resource group
echo "Creating a new resource group:" $mysqlrg"..."
az group create \
    -l $mysqllocation \
    -n $mysqlrg
echo "Done."
echo ""

# Creating MySQL Server
echo "Creating a new MySQL Server:" $mysqlservername"..."
az mysql server create \
    -l $mysqllocation \
    -g $mysqlrg \
    -n $mysqlservername \
    -u $mysqlserverusername \
    -p $mysqlserverpassword \
    --sku-name $mysqlserversku \
    --ssl-enforcement Disabled \
    --storage-size 51200
echo "Done."
echo ""

# Creating a firewall rule allowing connection from all ips
echo "Creating a general firewall rule..."
az mysql server firewall-rule create \
    -g $mysqlrg \
    -s $mysqlservername \
    -n allowallips \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255
echo "Done."
echo ""

# Creating MySQL database
echo "Adding a new MySQL Schema into" $mysqlservername":" $mysqldbname"..."
az mysql db create \
    -g $mysqlrg \
    -s $mysqlservername \
    -n $mysqldbname
echo "Done."
echo ""

# Printing information
echo "Final MySQL Server/DB information"
echo "--------------------------------------------------------"
echo Server: $mysqlservername.mysql.database.azure.com,3306
echo Username: $mysqlserverusername@$mysqlservername
echo Password: $mysqlserverpassword