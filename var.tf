variable "aws_region" {
    description = "The AWS region to deploy the VM instance."
    type        = string
    default     = "us-east-1"
  
}

variable "vm_names" {
  type = set(string)

  default = [ "VM-01" , "VM-02" ]   #Terraform converts the set into a map like this internally: Hence we can use for_each to create multiple resources: { "VM-01" = "VM-01" , "VM-02" = "VM-02" }
}

variable "instance_type" {
    description = "The AWS instance type to use for the VM instances."
    type        = string
    default     = "t2.micro"
  
}