# cloud-platform-lzvm

## Usage

1. Create a new feature branch
2. Create a new workload tfvars file for the new landingzone in the vars/**$tenant**/ folder, each workload has its own tfvars file, you can create multiple at once
3. The tfvars file should be named **$workload.tfvars** (e.g. **workload1.tfvars**)
4. The variables are listed below
5. Create a PR and assign it to the CCT team
6. Once the PR is approved and merged, the pipeline will run and create the landingzone(s)

## Variables (tfvars file)

- **(required)** **management_group_name**: Should be descriptive of the workloads that will be deployed under it. It has to be a 11 characters or less. it will be used in the naming as such: "mg-\*\*\*-tst-lz-**management_group_name**"
- *(required)* **parent_management_group_exists**: Determines if you are using an existing management group or not. If set to true, the parent_management_group_name must exist (see previous point). If set to false, a new management group will be created under the "Landingzones" management group
- *(required)* **subscription_type**: The type of subscription, allowed types are:
```
oa:	Office Automation
shared:	Shared Components
client:	Customer facing environment
iam:	Identity and access management: e.g Domain Controllers
erp:	Business Central
bi:	Business Intelligence and Data Warehousing
iot:	Internet of Things
```
| Variable                 | Required | Description                                                                                    |
|--------------------------|----------|--------------------------------------------------------------------------------------------------|
**subscription_name** | *(required)* |  The name of the subscription, it will be used in the naming as such: "nl-\*\*\*-\*\*\*-**subscription_name**-prd"
**subscription_tags** | *(required)* |  Tags that will be applied to the subscription, **Afdeling**, **Product** and repository are required tags. The rest are optional
**stages** | *(required)* |  List of stages to create (each stage is a subscription). Should contain at least 1 stage. Can contain max 4 stages. Allowed stages are: dev, tst, acc, prd
**baseline_tags** | *(optional)* |  Tags that will be applied to all resources in the subscription
**contributors** | *(optional)* |  List of user_principals to add to the AAD contributer group
**readers** | *(optional)* |  List of user_principals to add to the AAD reader group
**dev_vnet_size** | *(optional)* |  If stage contains "dev" and you require a VNET, you can specify the size of the VNET here. Allowed sizes are: 28, 27, 26, 25, 24, 23, 22, 21, 20
**tst_vnet_size** | *(optional)* |  If stage contains "tst" and you require a VNET, you can specify the size of the VNET here. Allowed sizes are: 28, 27, 26, 25, 24, 23, 22, 21, 20
**acc_vnet_size** | *(optional)* |  If stage contains "acc" and you require a VNET, you can specify the size of the VNET here. Allowed sizes are: 28, 27, 26, 25, 24, 23, 22, 21, 20
**prd_vnet_size** | *(optional)* |  If stage contains "prd" and you require a VNET, you can specify the size of the VNET here. Allowed sizes are: 28, 27, 26, 25, 24, 23, 22, 21, 20
**subnets** | *(optional)* |  A list of subnets that you want to create in the VNETs. If you do not define subnets, none will be created. If you do not add a delegation, none will be created. IMPORTANT: to provision subnets, you will need to run the lzvm on an already existing landingzone that has a vnet. You will need to know the address space of the vnet to determine the address_prefix of the subnets, you need to manually calculate the address_prefix. Here is a link to a subnet calculator: https://www.davidc.net/sites/default/subnets/subnets.html
**github_oidc** | *(optional)* |  This is an object that will enable OIDC for the serviceprincipal of the subscription. It is a map of the following: <BR> - key = The name of the github repository that you want to have your sp attched to<BR>- environments = List of github environments that you want to be able to use OIDC with<BR>- branches = List of branches that you want to be able to use OIDC with

```
# Example of the github_oidc object
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
```

|CIDR |# OF USABLE IP ADDRESSES||
|--|--|--|
|/28 |9 |
|/27 |25 |
|/26 |57 |
|/25 |121 |
|/24 |249 |
|/23 |505 |
|/22 |1,017 |
|/21 |2,041 |
|/20 |4,089 |

### Example tfvars file

```js
# Management group that will be created under the "Landingzones" management group
# NOTE: If parent_management_group_exists is set to true, both the parent_management_group_name and management_group_name must exist!!!!
parent_management_group_exists = false
management_group_name        = "nieuweworkload" # translates to mg-ssc-tst-lz-${management_group_name}

# subscription details for the naming convention and tagging
subscription_type     = "shared"
subscription_name     = "workload1"
subscription_tags     = { "costcenter" : "823423", "environment" : "tst", "repository" : "cloud-platform-lzvm" }
baseline_tags = {"baseline" = "true"}

# list of stages to create (each stage is a subscription)
stages = ["dev", "tst"]

# list of user_principals to add to the contributer group *(optional)*
contributors = ["aaa1@vwssc.onmicrosoft.com"]

# list of user_principals to add to the reader group *(optional)*
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
    environments = ["dev"] # optional
    branches = ["main"] # optional
  }
}

```
