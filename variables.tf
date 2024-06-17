variable "tenancy_ocid" {
  description = "Tenancy's OCID"
}

variable "user_ocid" {
  description = "User's OCID"
}

variable "compartment_ocid" {
  description = "Compartment's OCID where VCN will be created. "
}

variable "region" {
  description = "OCI Region"
  default     = "me-dubai-1"
}

variable "oci_private_key_path" {
  description = "The private key path to access instance."
}

variable "ssh_private_key_path" {
  description = "The private key path to access instance."
}

variable "ssh_public_key_path" {
  description = "The public key path to access instance."
}

variable "fingerprint" {
  description = "Key Fingerprint"
}

variable "domain_name" {
  description = "Domain Name"
}

variable "admin_email" {
  description = "Admin Email"
}
