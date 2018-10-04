#!/bin/bash

# Global variables
adminlogin={username}
password={username's password}
servername={server name}
rg={resource group}
location={location}
dbpool1={database pool 1 name}
dbpool1dtus={database pool 1 dtus}
dbpool1dtumax={database pool 1 dtus max}
dbpool1singlename={database inside database pool 1}
dbpool2={database pool 2 name}
dbpool2dtus={database pool 2 dtus}
dbpool2dtusmax={database pool 2 dtus max}
so={database pool sku}

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
