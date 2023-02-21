output "file_system_id" {
  value = aws_efs_file_system.efs_file_system.id
}

output "file_system_endpoint" {
  value = aws_efs_file_system.efs_file_system.dns_name
}

output "nfs_security_group_id" {
  value = aws_security_group.nfs_security_group.id
}
