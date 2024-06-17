output "wordpress_instance_public_ip" {
  value = oci_core_instance.wordpress_instance.public_ip
}
