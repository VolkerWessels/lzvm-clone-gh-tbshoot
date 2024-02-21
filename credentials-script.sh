## WHEN RUNNING THIS SCRIPT, ADD A "." IN FRONT: . ./credentials-script.sh
## OTHERWISE IT WILL NOT SET THE ENVIRONMENT VARIABLES FOR YOUR CURRENT SHELL

# This script will prompt you for the following:
# which tenant you want to use
# which subscription you want to use
# It will login using your azure credentials
# and retreive the secrets from the keyvaults for the service principals of:
# ENTRA, ESLZ, SCL, SCP
# You can pick which SP to set as default: SCP or SCL
# This will set their credentials as the default ARM_SUBSCRIPTION_ID and ARM_CLIENT_SECRET
# It will also set the launchpad subscription as "arm_tfstate_subscription"
# These are set as environment variables for your local environment
# you should be able to run Terraform now with the correct flags
# NOTE: make sure you set the storage account, container name and statefile yourself
#### INIT ####
#   terraform init \
#   -backend-config="key=${backend_key}.tfstate" \
#   -backend-config="subscription_id=$arm_tfstate_subscription" \
#   -backend-config="storage_account_name=${storage_account_name}" \
#   -backend-config="resource_group_name=${resource_group_name}" \
#   -backend-config="container_name=${container_name}"
#### PLAN/APPLY ####
#   terraform plan \
#   -var-file=<path_to_tfvars_file> \
#   -var-file=../../globals/<tenant_name>/globals.tfvars \
#   -no-color

#!/bin/bash

# Define the list of tenant names and corresponding IDs
tenant_names=("vwt-p" "vwi-p" "ssc-p" "vwb-p")
tenant_ids=("be36ab0a-ee39-47de-9356-a8a501a9c832" "cdc477bf-b6e3-4345-b1be-3b225394e17e" "5b6f3507-92dd-490b-8b8a-c286c591002a" "0ef544fb-3d5c-4c60-932e-735bcef00405")
launchpad_ids=("a933fd90-5c0e-4058-b8c4-99a2f0feba65" "00dcbe64-83d1-49ed-ade8-0d6458f767fc" "9a2c2ab9-4127-401a-a199-e25f7f0c7368" "5a00ea59-36b4-45d5-a01a-4f66eecf3f97")
default_sp=("ENTRA" "SCL" "SCP" "IPAM")

# Prompt the user to select a tenant name
echo "Select a tenant name:"
for i in "${!tenant_names[@]}"; do
    echo "$((i+1)). ${tenant_names[$i]}"
done
read -p "Enter the number of the tenant name: " tenant_number

# Validate the user input
if ! [[ "$tenant_number" =~ ^[1-5]$ ]]; then
    echo "Invalid input. Please enter a number between 1 and 4."
    exit 1
fi

echo "Select default SP:"
for i in "${!default_sp[@]}"; do
    echo "$((i+1)). ${default_sp[$i]}"
done
read -p "Wich SP do you want to set as the default? SCL/SCP/ENTRA: " default_sp_number

# Validate the user input
if ! [[ "$default_sp_number" =~ ^[1-3]$ ]]; then
    echo "Invalid input. Please enter a number between 1 and 3."
    exit 1
fi

# Set the tenant name and ID based on the user input
tenant_name=${tenant_names[$((tenant_number-1))]}
tenant_id=${tenant_ids[$((tenant_number-1))]}
launchpad_id=${launchpad_ids[$((tenant_number-1))]}
default_sp=${default_sp[$((default_sp_number-1))]}

# Prompt the user to enter the target subscription ID
read -p "Enter the target subscription ID: " target_subscription

# Login to Azure
# Login to Azure
if az login --tenant $tenant_id --allow-no-subscriptions -o none; then
  echo "Successfully logged in to Azure."
else
  echo "Failed to log in to Azure. Please check your credentials and try again."
  exit 1
fi

if [ -z $target_subscription ]; then
  echo "-------------------------------- TARGET SUBSCRIPTION: NOT SET ----------------------------------------------------"
  echo "No target subscriptions set, use 'az account set --subscription <subscription_id>' to set the target subscription"
  echo "Setting launchpad as the ID for the ARM_SUBSCRIPTION_ID"
  export ARM_SUBSCRIPTION_ID=$launchpad_id
  az account set --subscription $launchpad_id -o none
  echo "------------------------------------------------------------------------------------------------------------------"
  echo ""
else
  echo "-------------------------------- TARGET SUBSCRIPTION: ${target_subscription} --------------------------------------"
  az account set --subscription $target_subscription -o none
  echo "$(az account show --query "name" -o tsv) set as target subscription"
  az account set --subscription $target_subscription -o none
  export ARM_SUBSCRIPTION_ID=$(az account show --query "id" -o tsv)
  echo "------------------------------------------------------------------------------------------------------------------"
  echo ""
fi

# Define the list of Key Vault names
kv_names=("${tenant_name}-kv-idl0" "${tenant_name}-kv-es" "${tenant_name}-kv-scl" "${tenant_name}-kv-scp" "${tenant_name}-kv-ipam-01")

# export the launchpad id as arm_tfstate_subscription (for use with backend-config in terraform)
export arm_tfstate_subscription_id=$launchpad_id
export default_sp=$default_sp
export ARM_TENANT_ID=${tenant_id}

# Loop through each Key Vault and retrieve the specified secrets
for kv_name in "${kv_names[@]}"
do
    if [[ "${kv_name}" == "${tenant_name}-kv-idl0" ]]; then

        echo "-------------------------------- ENTRA: ${kv_name} ----------------------------------------------------------"
        echo "setting arm_client_id_entra"
        echo "setting arm_client_secret_entra"
         export TF_VAR_azurerm_client_id_entra=$(az keyvault secret show --name sp-client-id --vault-name $kv_name --query value -o tsv)
         export TF_VAR_azurerm_client_secret_entra=$(az keyvault secret show --name sp-client-secret --vault-name $kv_name --query value -o tsv)
         export TF_VAR_azuread_client_id_entra=$(az keyvault secret show --name sp-client-id --vault-name $kv_name --query value -o tsv)
         export TF_VAR_azuread_client_secret_entra=$(az keyvault secret show --name sp-client-secret --vault-name $kv_name --query value -o tsv)
        if [[ "${default_sp}" == "ENTRA" ]]; then
            echo "ENTRA SET AS DEFAULT SP"
            export ARM_CLIENT_ID=${TF_VAR_azurerm_client_id_entra}
            export ARM_CLIENT_SECRET=${TF_VAR_azurerm_client_secret_entra}
        fi
        echo "------------------------------------------------------------------------------------------------------------#"
        echo ""
    fi
    if [[ "${kv_name}" == "${tenant_name}-kv-es" ]]; then
        echo "-------------------------------- ESLZ: ${kv_name} ----------------------------------------------------------"
        echo "setting arm_client_id_eslz"
        echo "setting arm_client_secret_eslz"
         export TF_VAR_azurerm_client_id_eslz=$(az keyvault secret show --name sp-client-id --vault-name $kv_name --query value -o tsv)
         export TF_VAR_azurerm_client_secret_eslz=$(az keyvault secret show --name sp-client-secret --vault-name $kv_name --query value -o tsv)
        echo "------------------------------------------------------------------------------------------------------------"
        echo ""
    fi
    if [[ "${kv_name}" == "${tenant_name}-kv-scl" ]]; then
        echo "-------------------------------- SCL: ${kv_name} ----------------------------------------------------------"
        echo "setting arm_client_id_scl"
        echo "setting arm_client_secret_scl"
         export TF_VAR_azurerm_client_id_scl=$(az keyvault secret show --name sp-client-id --vault-name $kv_name --query value -o tsv)
         export TF_VAR_azurerm_client_secret_scl=$(az keyvault secret show --name sp-client-secret --vault-name $kv_name --query value -o tsv)
        # Set SCL as the default ARM_SUBSCRIPTION_ID / SECRET
        if [[ "${default_sp}" == "SCL" ]]; then
            echo "SCL SET AS DEFAULT SP"
            export ARM_CLIENT_ID=${TF_VAR_azurerm_client_id_scl}
            export ARM_CLIENT_SECRET=${TF_VAR_azurerm_client_secret_scl}
        fi
        echo "------------------------------------------------------------------------------------------------------------"
        echo ""
    fi
    if [[ "${kv_name}" == "${tenant_name}-kv-scp" ]]; then
        echo "-------------------------------- SCP: ${kv_name} ----------------------------------------------------------"
        echo "setting arm_client_id_scp"
        echo "setting arm_client_secret_scp"
         export TF_VAR_azurerm_client_id_scp=$(az keyvault secret show --name sp-client-id --vault-name $kv_name --query value -o tsv)
         export TF_VAR_azurerm_client_secret_scp=$(az keyvault secret show --name sp-client-secret --vault-name $kv_name --query value -o tsv)
        # Set SCP as the default ARM_SUBSCRIPTION_ID / SECRET
        if [[ "${default_sp}" == "SCP" ]]; then
            echo "SCP SET AS DEFAULT SP"
            export ARM_CLIENT_ID=${TF_VAR_azurerm_client_id_scp}
            export ARM_CLIENT_SECRET=${TF_VAR_azurerm_client_secret_scp}
        fi
        echo "------------------------------------------------------------------------------------------------------------"
        echo ""
    elif [[ "${kv_name}" == "${tenant_name}-kv-ipam-01" ]]; then
        echo "setting arm_client_id_ipam"
        echo "setting arm_client_secret_ipam"
         export TF_VAR_arm_client_id_ipam=$(az keyvault secret show --name UI-ID --vault-name $kv_name --query value -o tsv)
         export TF_VAR_arm_client_secret_ipam=$(az keyvault secret show --name ENGINE-SECRET --vault-name $kv_name --query value -o tsv)
    fi
done
