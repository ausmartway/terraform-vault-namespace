# terraform-vault-namespace
A Terraform module for Vault namespace. This module will create namespace, a management policy for the namespace, also a vault token that's associated with the policy.

## usage
```terraform
module "vault_namespace_example" {
    source =""ausmartway/namespace/vault""
    version = "0.0.3"
    name = "example"
} 
```

