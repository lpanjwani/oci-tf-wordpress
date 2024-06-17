data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

data "template_file" "availability_domains_names" {
  count    = length(data.oci_identity_availability_domains.availability_domains.availability_domains)
  template = lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[0], "name")
}
