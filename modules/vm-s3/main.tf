locals {
  env = terraform.workspace

  common_tags = {
    Team        = "Cloud"
    Owner       = "Me"
    Environment = local.env
    Purpose     = "VM-S3-Creation-Workspace"
  }
}

data "aws_ami" "wsp_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
  
}

resource "aws_key_pair" "local_key" {
  key_name   = "${terraform.workspace}-local-ssh-key"
  public_key = file("~/.ssh/local-ssh-key.pub")
}

resource "aws_instance" "wsp_vm" {

  for_each = var.vm_names

  ami           = data.aws_ami.wsp_ami.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.local_key.key_name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.env}-Workspace-${each.key}"
    }
  )
}

resource "aws_s3_bucket" "wsp_s3_bucket" {

     bucket = "${terraform.workspace}-workspace-s3-bucket-chintan-06"
    tags = merge(
        local.common_tags,
        {
            Name = "${local.env}-Workspace-S3-Bucket"
        }
    )
  
}

