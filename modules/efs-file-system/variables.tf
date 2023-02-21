variable "file_system_name" {
  description = "EFS File System name"
  type        = string
}

variable "name_prefix" {
  description = "Prefix to prepend resource names. Example: myproject-staging"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where to create EFS File System"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to add the EFS File System mount target to"
  type        = string
}

variable "kms_key" {
  description = "AWS KMS Customer-managed key alias for EFS File System encryption"
  type        = string
}
