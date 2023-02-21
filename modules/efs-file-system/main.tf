locals {
  cidr_blocks = [data.aws_vpc.vpc.cidr_block]
}

resource "aws_efs_file_system" "efs_file_system" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  kms_key_id = data.aws_kms_key.kms_key.arn
  encrypted  = true

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  tags = {
    Name = var.file_system_name
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.nfs_security_group.id]
}


resource "aws_security_group" "nfs_security_group" {
  name        = "${var.name_prefix}-nfs-sg"
  description = "NFS access"

  tags = {
    Name = "${var.name_prefix}-nfs-sg"
  }
}

resource "aws_security_group_rule" "allow_nfs_inbound_vpc" {
  type              = "ingress"
  description       = "Allow inbound traffic to NFS port inside VPC"
  security_group_id = aws_security_group.nfs_security_group.id

  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  cidr_blocks = local.cidr_blocks
}

resource "aws_security_group_rule" "allow_all_outbound_vpc" {
  type              = "egress"
  description       = "Allow all outbound traffic inside VPC"
  security_group_id = aws_security_group.nfs_security_group.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = local.cidr_blocks
}
