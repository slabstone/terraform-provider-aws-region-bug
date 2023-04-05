terraform {
  required_version = "1.4.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

locals {
  shared_config_filepath = "${path.module}/config/shared_config"
}

resource "local_file" "shared_config" {
  content = <<EOF
[profile bugreport]
region = us-east-1
EOF

  filename = local.shared_config_filepath
}

provider "aws" {
  access_key = "access-key"
  secret_key = "secret-key"

  shared_config_files = [local.shared_config_filepath]

  profile = "bugreport"
}

resource "aws_iam_user" "dummy" {
  name = "dummy"
}
