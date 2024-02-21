# Management group that will be created under the "Landingzones" management group
# NOTE: If parent_management_group_exists is set to true, both the parent_management_group_name and management_group_name must exist!!!!
parent_management_group_exists = false
management_group_name          = "neworkload" # translates to mg-ssc-tst-lz-${management_group_name}

# subscription details for the naming convention and tagging
subscription_type = "shared"
subscription_name = "demowl"
subscription_tags = { "costcenter" : "823423", "environment" : "tst", "repository" : "cloud-platform-lzvm" }
baseline_tags     = { "baseline" = "true" }

# list of stages to create (each stage is a subscription)
stages = ["dev", "tst"]

# list of user_principals to add to the contributer group (Optional)
contributors = ["aybn1@vwssc.onmicrosoft.com"]

# list of user_principals to add to the reader group (Optional)
readers = ["aybn1@vwssc.onmicrosoft.com"]

# VNET sizes for each stage, these are optional, if you do not define them, no network resources will be created
dev_vnet_size = "28"
# tst_vnet_size = "27"
# acc_vnet_size = "27"
# prd_vnet_size = "27"

# DO NOT ADD SUBNETS BEFORE YOU HAVE CREATED THE VNETS

# Example of how to add subnets to the VNETs
# if you do not define subnets, none will be created
# if you do not add a delegation, none will be created

# IMPORTANT: to provision subnets, you will need to run the lzvm on an already existing landingzone that has a vnet
# You will need to know the address space of the vnet to determine the address_prefix of the subnets, you need to manually calculate the address_prefix
# Here is a link to a subnet calculator: https://www.davidc.net/sites/default/subnets/subnets.html

subnets = [
  { 
    "name" : "subnet1",
    "address_prefix" : "10.0.0.0/26",
    "delegation" : {
      "name" : "delegation1",
      "service_delegation" : {
        "service_name" : "GitHub.Network/networkSettings",
        "actions" : [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }
  },
  { 
    "name" : "subnet2",
    "address_prefix" : "10.0.0.64/26" 
  },
  { 
    "name" : "subnet3",
    "address_prefix" : "10.0.0.128/26" 
  },
]
