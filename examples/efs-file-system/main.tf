terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "my_vpc" {
  default = true
}

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

data "aws_subnet" "my_subnet" {
  availability_zone_id = data.aws_availability_zones.availability_zones.zone_ids[0]
  default_for_az       = true
}

resource "aws_kms_key" "my_kms_key" {
  description             = "Test Project KMS key"
  deletion_window_in_days = 7
}

module "my_efs_file_system" {
  source = "../../modules/efs-file-system"

  file_system_name = "test-project-uploads"
  name_prefix      = "test-project-staging"
  vpc_id           = data.aws_vpc.my_vpc.id
  subnet_id        = data.aws_subnet.my_subnet.id
  kms_key_id       = aws_kms_key.my_kms_key.id
}
