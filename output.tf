output "vault-namespace" {
  description = "The full path of the namespace created."
  value = vault_namespace.namespace.path
}

output "vault-token" {
  description = "The Vault token created for managing the namespace."
  value = vault_token.namespace-admin-token.client_token
  sensitive = true
}