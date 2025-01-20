output "ebs_volume_id" {
  value       = aws_ebs_volume.gogs_data.id
}

output "ebs_size" {
  value = aws_ebs_volume.gogs_data.size
}

output "ebs_type" {
  value = aws_ebs_volume.gogs_data.type
}