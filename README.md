# TF-Workspaces

## 📄 Project Description

TF-Workspaces is a Terraform-based Infrastructure as Code (IaC) project designed to provision AWS infrastructure across multiple environments (dev, stage, prod) using Terraform Workspaces and modular architecture.

This project demonstrates how to:

* Use Terraform Workspaces for environment isolation
* Implement modular Terraform design
* Provision EC2 instances dynamically using `for_each`
* Create environment-aware S3 buckets
* Manage SSH key pairs securely
* Use environment-specific `.tfvars` files
* Expose module outputs cleanly to the root module

Each workspace maintains its own state file, enabling safe separation of infrastructure per environment while reusing the same Terraform codebase.

---

##  Key Features

* Workspace-based environment separation (dev, stage, prod)
* Modular architecture (`modules/vm-s3`)
* Dynamic EC2 provisioning using `for_each`
* Workspace-prefixed resource naming
* Environment-specific `.tfvars` configuration
* Clean root-to-module output referencing

---

##  Tech Stack

Infrastructure as Code: Terraform

Cloud Provider: AWS

Services Used:

* EC2
* S3
* Key Pairs

---

##  Project Structure

```
TF-Workspaces/
├── main.tf
├── provider.tf
├── variables.tf
├── output.tf
├── dev.tfvars
├── stage.tfvars
├── prod.tfvars
├── modules/
│   └── vm-s3/
│       ├── main.tf
│       ├── variables.tf
│       ├── output.tf
│       └── locals.tf

```

---

##  Architecture Overview

Each workspace (dev, stage, prod) creates:

* EC2 Instances
* S3 Bucket (workspace-prefixed)
* SSH Key Pair (workspace-prefixed)

Resource naming pattern:

```
<workspace>-<resource-name>
```

Example:

```
dev-Workspace-VM-app1
stage-Workspace-VM-app1
prod-Workspace-VM-app1
```

---

##  Running the Project

### 1️ Clone the Repository

```
git clone https://github.com/Chintansgowda/TF-Workspaces.git
```

```
cd TF-Workspaces
```

---

### 2️ Initialize Terraform

```
terraform init
```

---

### 3️ Create Workspaces

```
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
```

---

### 4️ Apply Infrastructure Per Environment

For dev:

```
terraform workspace select dev
terraform apply -var-file="dev.tfvars"
```

For stage:

```
terraform workspace select stage
terraform apply -var-file="stage.tfvars"
```

For prod:

```
terraform workspace select prod
terraform apply -var-file="prod.tfvars"
```

---

##  Destroy Infrastructure

To destroy infrastructure for a specific workspace:

```
terraform workspace select dev
terraform destroy -var-file="dev.tfvars"
```

Each workspace destroys only its own resources.

---

##  SSH Key Management

SSH keys are generated locally and uploaded to AWS using Terraform.

Recommended approach:

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/local-ssh-key
```

Terraform reads the public key:

```
file("~/.ssh/local-ssh-key.pub")
```

Key pairs are prefixed with workspace name to prevent duplication:

```
<workspace>-local-ssh-key
```

---

##  Outputs

The module exposes:

* Instance IDs
* Private IPs
* Public DNS

Root module references them using:

```
module.workspace_vm_s3.instance_private_ips
module.workspace_vm_s3.instance_public_dns
```

---

##  Best Practices Implemented

* Modular design
* Workspace-based environment isolation
* `for_each` instead of `count` for stability
* Environment-aware resource naming
* Separation of variable files per environment
* Clean output propagation from module to root

---

##  Important Notes

* S3 bucket names are globally unique
* Key pairs are region-specific
* Each workspace maintains separate state
* Terraform only manages resources recorded in state

---

##  Learning Objectives Demonstrated

* Terraform Workspaces
* for_each vs count
* Module design
* Resource chaining
* Environment-specific configuration
* State isolation concepts

---

##  License

This project is for learning and demonstration purposes.

---

