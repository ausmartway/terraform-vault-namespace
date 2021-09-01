output "vault-namespace" {
  value = vault_namespace.namespace.path
}

output "vault-token" {
  value = vault_token.namespace-admin-token.client_token
  sensitive = true
}