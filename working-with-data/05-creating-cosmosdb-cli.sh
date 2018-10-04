#!/bin/bash

# Set variables for the new account, database, and collection
resourceGroupName={resource group name}
location={location}
name={cosmosdb account name}
databaseName={database name}
collectionName={collection name}

# Create a resource group
echo "Creating a new resource group:" $resourceGroupName"..."
az group create \
	--name $resourceGroupName \
	--location $location
echo "Done."
echo ""

# Create a DocumentDB API Cosmos DB account
echo "Creating a new CosmosDB Account:" $name"..."
az cosmosdb create \
	--name $name \
	--kind GlobalDocumentDB \
	--resource-group $resourceGroupName \
	--max-interval 10 \
	--max-staleness-prefix 200 
echo "Done."
echo ""

# Create a database
echo "Creating a new CosmosDB Database into" $databaseName"..." 
az cosmosdb database create \
	--name $name \
	--db-name $databaseName \
	--resource-group $resourceGroupName
echo "Done."
echo ""

# Create a collection
echo "Creating a new CosmosDB Collection into" $databaseName"..."
az cosmosdb collection create \
	--collection-name $collectionName \
	--name $name \
	--db-name $databaseName \
	--resource-group $resourceGroupName
echo "Done."
