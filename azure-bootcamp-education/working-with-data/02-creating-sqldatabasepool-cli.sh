#!/bin/bash

# Global variables
adminlogin=fabricio
password=admin@1029384756
servername=sqlserverpoolmoett
rg=rgmoett-db
location=eastus
dbpool1=moettpool1
dbpool1dtus=50
dbpool1dtumax=20
dbpool1singlename=moettdb1
dbpool2=moettpool2
dbpool2dtus=100
dbpool2dtusmax=50
so=S2

# Create a logical server in the resource group
az sql server create \
	--name $servername \
	--resource-group $rg \
	--location $location \
	--admin-user $adminlogin \
	--admin-password $password

# Create two pools in the logical server
az sql elastic-pool create \
    --resource-group $rg \
    --server $servername \
    --name $dbpool1 \
    --dtu $dbpool1dtus \
    --db-dtu-max $dbpool1dtumax

az sql elastic-pool create \
	--resource-group $rg \
	--server $servername \
	--name $dbpool2 \
	--dtu $dbpool2dtus \
	--db-dtu-max $dbpool2dtusmax

# Create a database in the first pool
az sql db create \
    -n $dbpool1singlename \
    -g $rg \
    -s $servername \
    --elastic-pool $dbpool1

# Moving the database from a Database Pool to another with no stop
az sql db update \
    -n $dbpool1singlename \
    -g $rg \
    -s $servername \
    --elastic-pool $dbpool2

# Upgrading the database plan
az sql db update \
    -n $dbpool1singlename \
    -g $rg \
    -s $servername \
    --service-objective $so