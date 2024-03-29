# Management group that will be created under the "Landingzones" management group
# NOTE: If parent_management_group_exists is set to true, both the parent_management_group_name and management_group_name must exist!!!!
parent_management_group_exists = false
management_group_name          = "ghtst" # translates to mg-ssc-tst-lz-${management_group_name}

# subscription details for the naming convention and tagging
subscription_type = "shared"
subscription_name = "workload1"
subscription_tags = { "costcenter" : "823423", "environment" : "tst", "repository" : "cloud-platform-lzvm" }
baseline_tags     = { "baseline" = "true" }

# list of stages to create (each stage is a subscription)
stages = ["dev", "tst"]

# list of user_principals to add to the contributer group (Optional)
contributors = ["aaa1@vwssc.onmicrosoft.com"]

# list of user_principals to add to the reader group (Optional)
readers = ["aaa1@vwssc.onmicrosoft.com", "bbb2@vwssc.onmicrosoft.com"]

# VNET sizes for each stage, these are optional, if you do not define them, no network resources will be created
dev_vnet_size = "28"
# tst_vnet_size = "27"
# acc_vnet_size = "27"
# prd_vnet_size = "27"

github_oidc = {
  # each key is the name of the github repository that you want to have your msi attched to
  "my-first-awesome-repository" = {
    # at least one of the following is required (wildcards are not supported)
    environments = ["dev", "tst", "acc", "prd"] # optional
  },
  "my-second-awesome-repository" = {
    # at least one of the following is required (wildcards are not supported)
    environments = ["dev", "prd"] # optional
    branches     = ["main"]       # optional
  }
}
#
