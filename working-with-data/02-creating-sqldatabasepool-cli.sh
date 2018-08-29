#!/bin/bash

# Global variables
adminlogin=fabricio
password=admin@1029384756
servername=arecibo-sqlserverpool
rg=arecibo-db
location=eastus
dbpool1=arecibo-pool1
dbpool1dtus=50
dbpool1dtumax=20
dbpool1singlename=arecibo-db1
dbpool2=arecibo-pool2
dbpool2dtus=100
dbpool2dtusmax=50
so=S2

# Create a logical server in the resource group
echo "Creating logical server" $servername"..."
az sql server create \
	--name $servername \
	--resource-group $rg \
	--location $location \
	--admin-user $adminlogin \
	--admin-password $password
echo "Done."
echo ""

# Create two pools in the logical server
echo "Adding pools ("$dbpool1 "and" $dbpool2") into" $servername"..."
az sql elastic-pool create \
    --resource-group $rg \
    --server $servername \
    --name $dbpool1 \
    --dtu $dbpool1dtus \
    --db-dtu-max $dbpool1dtumax
echo $dbpool1 "added succefully."

az sql elastic-pool create \
	--resource-group $rg \
	--server $servername \
	--name $dbpool2 \
	--dtu $dbpool2dtus \
	--db-dtu-max $dbpool2dtusmax
echo $dbpool2 "added sucessfully."
echo "Done."
echo ""

# Create a database in the first pool
echo "Creating database" $dbpool1singlename "into" $dbpool1"..."
az sql db create \
    -n $dbpool1singlename \
    -g $rg \
    -s $servername \
    --elastic-pool $dbpool1
echo "Created."
echo ""

# Moving the database from a Database Pool to another with no stop
echo "Moving database" $dbpool1singlename "from" $dbpool1 "to" $dbpool2 "with no stop..."
az sql db update \
    -n $dbpool1singlename \
    -g $rg \
    -s $servername \
    --elastic-pool $dbpool2
echo "Done."
echo ""

# Upgrading the database plan and removing from Pool (converting to standalone)
echo "Upgrading database" $dbpool1singlename "to a superior tier with no stop..."
az sql db update \
    -n $dbpool1singlename \
    -g $rg \
    -s $servername \
    --service-objective $so
echo "Done."