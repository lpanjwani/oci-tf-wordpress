
data "oci_core_images" "ubuntu_shape" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "20.04"
  shape                    = local.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "template_file" "ubuntu_shape_id" {
  count    = length(data.oci_core_images.ubuntu_shape.images)
  template = lookup(data.oci_core_images.ubuntu_shape.images[0], "id")
}

