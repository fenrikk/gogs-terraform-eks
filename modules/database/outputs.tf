output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_security_group_id" {
  value = aws_security_group.rds.id
}

output "db_secrets_AWS" {
  value = aws_secretsmanager_secret.rds_credentials.name
}