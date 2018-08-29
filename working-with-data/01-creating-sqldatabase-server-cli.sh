#!/bin/bash

# Server variables
resourcegroupname=arecibo-db
servername=arecibo-sqlserver
location=eastus
adminlogin=fabricio
password=admin@1029384756
startip=0.0.0.0
endip=255.255.255.255
databasename1=catalogdb
databasename2=identitydb

# Creating Resource Group
echo "Creating the resource group" $resourcegroupname"..."
az group create \
    --name $resourcegroupname \
    --location $location
echo "Done."
echo ""

# Creating SQL Azure Database
echo "Creating the virtual SQL Server called" $servername"..."
az sql server create \
    --name $servername \
    --resource-group $resourcegroupname \
    --location $location \
    --admin-user $adminlogin \
    --admin-password $password
echo "Done."
echo ""

# Adding gerenal access rule to the server
echo "Creating a general access rule into the server..."
az sql server firewall-rule create \
    --resource-group $resourcegroupname \
    --server $servername \
    -n AllowYourIp \
    --start-ip-address $startip \
    --end-ip-address $endip
echo "Done."
echo ""

# Creating a SQL Database for catalogsdb
echo "Creating the database called" $databasename1"..."
az sql db create \
    --resource-group $resourcegroupname \
    --server $servername \
    --name $databasename1 \
    --service-objective S0
echo "Done."
echo ""

# Creating a SQL Database for identitydb
echo "Creating the database called" $databasename2"..."
az sql db create \
    --resource-group $resourcegroupname \
    --server $servername \
    --name $databasename2 \
    --service-objective S0
echo "Done."
echo ""