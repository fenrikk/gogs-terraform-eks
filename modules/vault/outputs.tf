output "db_name" {
  value = data.vault_kv_secret_v2.gogs_db.data["db_name"]
}

output "db_username" {
  value = data.vault_kv_secret_v2.gogs_db.data["db_username"]
}

output "db_password" {
  value     = data.vault_kv_secret_v2.gogs_db.data["db_password"]
  sensitive = true
}