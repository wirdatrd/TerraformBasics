# logon to your azure tenant
az login

# if you have multiple subscriptions then select the one you want to use
az account set -s "<subscription_id>"

# create environment variables to initialise a shared back end (azure storage account)
$env:RESOURCE_GROUP_NAME = 'terraform-resources'
$env:STORAGE_ACCOUNT_NAME = 'terraformstorage' + (Get-Random -minimum 1000 -maximum 9999).tostring()
$env:CONTAINER_NAME = 'terraform-state-files'

# Create resource group
az group create --name $env:RESOURCE_GROUP_NAME --location westus2

# Create storage account
az storage account create --resource-group $env:RESOURCE_GROUP_NAME --name $env:STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
$env:ACCOUNT_KEY = (az storage account keys list --resource-group $env:RESOURCE_GROUP_NAME --account-name $env:STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Create blob container
az storage container create --name $env:CONTAINER_NAME --account-name $env:STORAGE_ACCOUNT_NAME --account-key $env:ACCOUNT_KEY
