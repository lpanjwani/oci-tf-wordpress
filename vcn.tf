# Create a virtual cloud network (VCN) for the instance
resource "oci_core_vcn" "wordpress_vcn" {
  cidr_block     = "10.0.0.0/16"
  display_name   = "WordPress VCN"
  compartment_id = var.compartment_ocid
}

# Create a security list to allow incoming traffic
resource "oci_core_security_list" "wordpress-security_list" {
  display_name   = "WordPress Security List"
  vcn_id         = oci_core_vcn.wordpress_vcn.id
  compartment_id = var.compartment_ocid

  egress_security_rules {
    description = "Allow all egress traffic"
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  # Allow incoming HTTP traffic
  ingress_security_rules {
    description = "Allow HTTP"
    source      = "0.0.0.0/0"
    protocol    = "6"

    tcp_options {
      min = 80
      max = 80
    }
  }

  # Allow incoming HTTPS traffic
  ingress_security_rules {
    description = "Allow HTTPS"
    source      = "0.0.0.0/0"
    protocol    = "6"

    tcp_options {
      min = 443
      max = 443
    }
  }

  # Allow incoming SSH traffic from a specific IP address
  ingress_security_rules {
    description = "Allow Dev SSH"
    source      = "2.51.5.226/32"
    protocol    = "6"
  }
}

# Create an internet gateway for the VCN
resource "oci_core_internet_gateway" "wordpress_igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.wordpress_vcn.id
  display_name   = "Internet Gateway"
}

# Define a route table for the subnet
resource "oci_core_route_table" "wordpress_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.wordpress_vcn.id
  display_name   = "Public Subnet Route Table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.wordpress_igw.id
  }
}

# Create a subnet within the VCN
resource "oci_core_subnet" "wordpress_public_subnet" {
  cidr_block        = "10.0.1.0/24"
  vcn_id            = oci_core_vcn.wordpress_vcn.id
  compartment_id    = var.compartment_ocid
  security_list_ids = [oci_core_security_list.wordpress-security_list.id]
  route_table_id    = oci_core_route_table.wordpress_route_table.id
  display_name      = "Public Subnet"
}
