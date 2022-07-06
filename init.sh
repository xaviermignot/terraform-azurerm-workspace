#!/bin/bash

read -r -p "Name of the resource group: " rgName
read -r -p "Name of the storage account: " storageAccountName
read -r -p "Azure region: " location

az group create -n "$rgName" -l "$location"
az storage account create -g "$rgName" -n "$storageAccountName" -l "$location" --sku Standard_LRS
az storage container create -n tfstate --account-name "$storageAccountName"

cat <<EOF > backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "$rgName"
    storage_account_name = "$storageAccountName"
    container_name       = "tfstate"
    key                  = "test"
  }
}
EOF
