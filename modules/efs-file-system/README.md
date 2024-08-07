# EFS Volume

Current version: `v0.0.2`

This Terraform module creates AWS EFS File System encrypted with AWS KMS Custom-managed key.


## Usage

```terraform
module "my_efs_file_system" {
  source = "github.com/code87/tf-aws-storage//modules/efs-file-system?ref=v0.0.2"

  file_system_name = "myproject-uploads"
  name_prefix      = "myproject-staging"
  vpc_id           = data.aws_vpc.my_vpc.id
  subnet_id        = data.aws_subnet.my_subnet.id
  kms_key_id       = aws_kms_key.my_kms_key.id
}
```

_See also_: [examples/efs-file-system.tf](../examples/efs-file-system.tf)


## Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.3.0, < 2.0.0 |
| `aws`       | ~> 5.0            |


## Resources

| Name                     | Type                      |
|--------------------------|---------------------------|
| `efs_file_system`        | `aws_efs_file_system`     |
| `efs_mount_target`       | `aws_efs_mount_target`    |
| `nfs_security_group`     | `aws_security_group`      |
| `allow_nfs_inbound_vpc`  | `aws_security_group_rule` |
| `allow_all_outbound_vpc` | `aws_security_group_rule` |


## Inputs

* `file_system_name` (required, `string`) - EFS File System name.

* `name_prefix` (required, `string`) - prefix to prepend resource names.<br/>
  Example: `myproject-staging`

* `vpc_id` (required, `string`) - the ID of the VPC where to create EFS File System.

* `subnet_id` (required, `string`) - the ID of the subnet to add the EFS File System mount target to.

* `kms_key_id` (required, `string`) - AWS KMS Customer-managed key ID for EFS File System encryption.


## Outputs

* `file_system_id` - the ID of created EFS File System.

* `file_system_endpoint` - DNS endpoint of created EFS File System.

* `nfs_security_group_id` - the ID of created NFS access security group.
