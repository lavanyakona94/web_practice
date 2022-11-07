resource "oci_core_instance" "ubuntu_oci_instance" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  fault_domain        = var.default_fault_domain

  create_vnic_details {
    assign_private_dns_record = true
    assign_public_ip          = var.is_private == true ? false : true
    subnet_id                 = var.is_private == true ? var.private_subnet_id : var.public_subnet_id
  }

  display_name = "my_test_Instance"

  metadata = {
    "ssh_authorized_keys" = file(var.PATH_TO_PUBLIC_KEY)
    "user_data"           = data.template_cloudinit_config.ubuntu_init.rendered
  }

  shape = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = "6"
    ocpus         = "1"
  }

  source_details {
    source_id   = var.os_image_id
    source_type = "image"
  }

  freeform_tags = local.tags
}
