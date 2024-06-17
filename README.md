# Terraform Configuration Project

This project uses Terraform to provision and manage infrastructure on Oracle Cloud Infrastructure (OCI). It includes configurations for creating a Virtual Cloud Network (VCN), instances, and other necessary resources to deploy a WordPress application.

## Prerequisites

- An Oracle Cloud Infrastructure account.
- Terraform installed on your local machine.
- An OCI API signing key pair for authentication.

## Configuration

Before running Terraform commands, you need to configure your OCI credentials and other necessary variables. Use the `variables.tfvars.sample` as a template to create your own `variables.tfvars` file with your specific values.

```hcl
tenancy_ocid         = "<your_tenancy_ocid>"
user_ocid            = "<your_user_ocid>"
compartment_ocid     = "<your_compartment_ocid>"
region               = "me-dubai-1"
oci_private_key_path = "<path_to_your_private_key>"
ssh_private_key_path = "<path_to_your_ssh_private_key>"
ssh_public_key_path  = "<path_to_your_ssh_public_key>"
fingerprint          = "<your_api_key_fingerprint>"
```

## Usage

1. Initialize Terraform:

```sh
terraform init
```

2. Plan the deployment to see the resources that will be created/modified:

```sh
terraform plan -var-file="variables.tfvars"
```

3. Apply the configuration to create the resources:

```sh
terraform apply -var-file="variables.tfvars"
```

4. To destroy the resources:

```sh
terraform destroy -var-file="variables.tfvars"
```