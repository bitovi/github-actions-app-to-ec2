#!/bin/bash

set -e

# TODO: use templating
#    provide '.tf.tmpl' files in the 'operations/deployment' repo
#    and iterate over all of them to provide context with something like jinja
#    Example: https://github.com/mattrobenolt/jinja2-cli
#    jinja2 some_file.tmpl data.json --format=json

echo "In $(basename $0)"

# use a heredoc to avoid escaping quotes
# and write the file in one line
cat << PROVIDER_HCL > "$GITHUB_ACTION_PATH/operations/deployment/terraform/provider.tf"
terraform {

  required_version = ">=0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
  }

  backend "s3" {
    region  = "$AWS_DEFAULT_REGION"
    bucket  = "$TF_STATE_BUCKET"
    key     = "tf-state"
    encrypt = true #AES-256encryption
  }
}

provider "aws\ {
  region = "$AWS_DEFAULT_REGION"
  default_tags {
    tags = merge(
      local.aws_tags,
      var.additional_tags
    )
  }
}
PROVIDER_HCL
