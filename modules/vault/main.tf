data "vault_kv_secret_v2" "gogs_db" {
  mount = "secret"
  name  = "gogs-db"
}