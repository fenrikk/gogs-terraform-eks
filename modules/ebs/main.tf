resource "aws_ebs_volume" "gogs_data" {
  availability_zone = var.availability_zone
  size              = 20
  type              = "gp3"
  
  tags = {
    Name = "${var.project_name}-ebs-volume"
  }
}