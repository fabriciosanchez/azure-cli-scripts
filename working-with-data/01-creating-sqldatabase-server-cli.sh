#!/bin/bash

# Server variables
servername=sqlservermoett
resourcegroupname=rgmoett-db
location=eastus
adminlogin=fabricio
password=admin@1029384756
startip=0.0.0.0
endip=255.255.255.255
databasename1=catalogdb
databasename2=identitydb

# Creating Resource Group
az group create --name $resourcegroupname --location $location

# Creating SQL Azure Database
az sql server create --name $servername --resource-group $resourcegroupname --location $location --admin-user $adminlogin --admin-password $password

# Adding gerenal access rule to the server
az sql server firewall-rule create --resource-group $resourcegroupname --server $servername -n AllowYourIp --start-ip-address $startip --end-ip-address $endip

# Creating a SQL Database for catalogsdb
az sql db create --resource-group $resourcegroupname --server $servername --name $databasename1 --service-objective S0

# Creating a SQL Database for identitydb
az sql db create --resource-group $resourcegroupname --server $servername --name $databasename2 --service-objective S0