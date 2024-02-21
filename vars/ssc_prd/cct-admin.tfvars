# Management group that will be created under the "Landingzones" management group
# NOTE: If parent_management_group_exists is set to true, both the parent_management_group_name and management_group_name must exist!!!!
parent_management_group_exists = true
management_group_name          = "admin" # translates to mg-ssc-tst-lz-${management_group_name}

# subscription details for the naming convention and tagging
subscription_type = "shared"
subscription_name = "cct-admin"
subscription_tags = { "costcenter" : "CCT", "environment" : "prd", "repository" : "jumphost" }
baseline_tags     = { "baseline" = "true" }

# list of stages to create (each stage is a subscription)
stages = ["prd"]

# list of user_principals to add to the contributer group (Optional)
contributors = []

# list of user_principals to add to the reader group (Optional)
readers = []

# VNET sizes for each stage, these are optional, if you do not define them, no network resources will be created
prd_vnet_size = "25"

# OIDC configuration for github
github_oidc = {
  # each key is the name of the github repository that you want to have your msi attched to
  "jumphost" = {
    environments = ["vwi_prd", "vwt_prd", "vwb_prd", "ssc_prd"] # optional
  }
}