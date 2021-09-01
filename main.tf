# Vault namespace,policy and admin token for namespaces
resource "vault_namespace" "project-namespace" {
  path = var.namespace
}


resource "vault_policy" "project-namespace-admin-policy" {
  name   = "project-namespace-admin-policy"
  policy = <<EOP
# Manage namespaces


#adding below to allow creation of child token
path "auth/token/create" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "${vault_namespace.project-namespace.path}/sys/namespaces/*" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage policies
path "${vault_namespace.project-namespace.path}/sys/policies/acl/*" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List policies
path "${vault_namespace.project-namespace.path}/sys/policies/acl" {
   capabilities = ["list"]
}

# Enable and manage secrets engines
path "${vault_namespace.project-namespace.path}/sys/mounts/*" {
   capabilities = ["create", "read", "update", "delete", "list"]
}

# List available secrets engines
path "${vault_namespace.project-namespace.path}/sys/mounts" {
  capabilities = [ "read" ]
}

# Create and manage entities and groups
path "${vault_namespace.project-namespace.path}/identity/*" {
   capabilities = ["create", "read", "update", "delete", "list"]
}

# Manage tokens
path "${vault_namespace.project-namespace.path}/auth/token/*" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secrets at '*'
path "${vault_namespace.project-namespace.path}/*" {
   capabilities = ["create", "read", "update", "delete", "list"]
}
EOP

}

resource "vault_token" "project-namespace-admin-token" {
  policies        = ["default", vault_policy.project-namespace-admin-policy.name]
  renewable       = true
  no_parent       = true
  ttl             = "768h"
  renew_min_lease = 43200
  renew_increment = 86400
}
