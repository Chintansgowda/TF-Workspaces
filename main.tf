module "workspace_vm_s3" {
    source = "./modules/vm-s3"

    aws_region = var.aws_region
    instance_type = var.instance_type
  



}