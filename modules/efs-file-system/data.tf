data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_kms_key" "kms_key" {
  key_id = "alias/${var.kms_key}"
}
