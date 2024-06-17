resource "oci_core_instance" "wordpress_instance" {

  compartment_id      = var.compartment_ocid
  display_name        = "WordPressInstance"
  shape               = local.instance_shape
  availability_domain = data.template_file.availability_domains_names.*.rendered[0]

  create_vnic_details {
    subnet_id        = oci_core_subnet.wordpress_public_subnet.id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.template_file.ubuntu_shape_id.*.rendered[0]
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  timeouts {
    create = "30m"
  }

  # Use remote-exec provisioner to install software
  provisioner "remote-exec" {
    inline = [
      "sudo sudo apt update",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker $USER",
      "sudo systemctl start docker",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sleep 30",
      "git clone https://github.com/litespeedtech/ols-docker-env.git",
      "cd ols-docker-env",
      "docker-compose up -d",
      "bash bin/webadmin.sh admin",
      "bash bin/domain.sh --add ${var.domain_name}",
      "bash bin/database.sh --domain ${var.domain_name}",
      "bash bin/appinstall.sh --app wordpress --domain ${var.domain_name}",
      "bash bin/acme.sh --install --email ${var.admin_email}",
      "bash bin/acme.sh --domain ${var.domain_name} --domain www.${var.domain_name}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }
}
