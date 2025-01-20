resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow inbound traffic to RDS from VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "${var.project_name}-rds-secrets"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    dbname   = var.db_name
    endpoint = aws_db_instance.default.endpoint
  })
}

resource "aws_db_instance" "default" {
  engine               = "postgres"
  engine_version       = data.aws_rds_engine_version.postgresql.version
  instance_class       = "db.t4g.micro"
  allocated_storage    = 20
  storage_type         = "gp3"
  identifier           = "${var.project_name}-db"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_rds_engine_version" "postgresql" {
  engine  = "postgres"
  version = "16.3"
}