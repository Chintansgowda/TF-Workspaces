output "public_ips" {
  value = module.workspace_vm_s3.instance_public_ips
}

output "public_dns" {
  value = module.workspace_vm_s3.instance_public_dns
}

output "private_ips" {
  value = module.workspace_vm_s3.instance_private_ips
}

output "instance_ids" {
  value = module.workspace_vm_s3.instance_ids
}
