data "template_cloudinit_config" "ubuntu_init" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/oci-ubuntu-install.sh", {})
  }
}
