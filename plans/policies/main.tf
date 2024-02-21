variable "lz_scoped_policies" {
  type = map(any)
  default = { 
    "name" : "1", "id" :"/providers/Microsoft.Management/managementGroups/mg-ssc-tst/providers/Microsoft.Authorization/policyDefinitions/pol0019-deny_udr",
    "name" : "2", "id" :"/providers/Microsoft.Management/managementGroups/mg-ssc-tst/providers/Microsoft.Authorization/policyDefinitions/Deny-Subnet-Without-Nsg",
    "name" : "3", "id" :"/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9",
    "name" : "4", "id" :"/providers/Microsoft.Authorization/policyDefinitions/98d0b9f8-fd90-49c9-88e2-d3baf3b0dd86",
    "name" : "5", "id" :"/providers/Microsoft.Authorization/policyDefinitions/a8eff44f-8c92-45c3-a3fb-9880802d67a7",
    "name" : "6", "id" :"/providers/Microsoft.Authorization/policyDefinitions/94de2ad3-e0c1-4caf-ad78-5d47bbc83d3d",
    "name" : "7", "id" :"/providers/Microsoft.Authorization/policyDefinitions/36d49e87-48c4-4f2e-beed-ba4ed02b71f5",
    "name" : "8", "id" :"/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d",
    "name" : "9", "id" :"/providers/Microsoft.Management/managementGroups/mg-ssc-tst/providers/Microsoft.Authorization/policySetDefinitions/Deny-PublicPaaSEndpoints",
    "name" : "10", "id" :"/providers/Microsoft.Management/managementGroups/mg-ssc-tst/providers/Microsoft.Authorization/policySetDefinitions/Enforce-EncryptTransit",
    "name" : "11", "id" :"/providers/Microsoft.Management/managementGroups/mg-ssc-tst/providers/Microsoft.Authorization/policyDefinitions/Deny-MgmtPorts-From-Internet",
    "name" : "12", "id" :"/providers/Microsoft.Authorization/policyDefinitions/95edb821-ddaf-4404-9732-666045e056b4",
    "name" : "13", "id" :"/providers/Microsoft.Authorization/policyDefinitions/564feb30-bf6a-4854-b4bb-0d2d2d1e6c66",
    "name" : "14", "id" :"/providers/Microsoft.Authorization/policyDefinitions/25da7dfb-0666-4a15-a8f5-402127efd8bb",
    "name" : "15", "id" :"/providers/Microsoft.Authorization/policyDefinitions/1c6e92c9-99f0-4e55-9cf2-0c234dc48f99",
    "name" : "16", "id" :"/providers/Microsoft.Management/managementGroups/mg-ssc-tst/providers/Microsoft.Authorization/policySetDefinitions/Enforce-Guardrails-KeyVault",
    "name" : "17", "id" :"/providers/Microsoft.Authorization/policyDefinitions/88c0b9da-ce96-4b03-9635-f29a937e2900",
    "name" : "18", "id" :"/providers/Microsoft.Authorization/policyDefinitions/6c112d4e-5bc7-47ae-a041-ea2d9dccd749",
    "name" : "19", "id" :"/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114",
  }
}



resource "azurerm_management_group_policy_assignment" "lz_scoped_policy_assignments" {
  for_each = var.lz_scoped_policies
  
  name                 = each.value.id
  policy_definition_id = each.value.id
  management_group_id  = "/providers/Microsoft.Management/managementGroups/mg-ssc-tst/mg-ssc-tst/mg-ssc-tst-landing-zones"
}