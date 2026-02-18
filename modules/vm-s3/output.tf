output "instance_ids" {
  value = {
    for key, instance in aws_instance.wsp_vm :
    key => instance.id
  }
}


output "instance_public_ips" {
  value = {
    for key, instance in aws_instance.wsp_vm :
    key => instance.public_ip
  }
}


output "instance_private_ips" {
  description = "Private IP addresses of all EC2 instances"

  value = {
    for key, instance in aws_instance.wsp_vm :
    key => instance.private_ip
  }
}

output "instance_public_dns" {
  description = "Public DNS names of all EC2 instances"

  value = {
    for key, instance in aws_instance.wsp_vm :
    key => instance.public_dns
  }
}
