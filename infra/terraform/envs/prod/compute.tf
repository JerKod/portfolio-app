data "oci_core_images" "ubuntu_arm" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = var.node_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "k3s" {
  for_each            = var.nodes
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  display_name        = "k3s-${each.key}"
  shape               = var.node_shape

  shape_config {
    ocpus         = var.node_ocpus
    memory_in_gbs = var.node_memory_gb
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu_arm.images[0].id
    boot_volume_size_in_gbs = var.boot_volume_size_gb
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
    nsg_ids          = [oci_core_network_security_group.nodes.id]
  }

  metadata = {
    user_data = base64encode(templatefile("${path.module}/cloud-init.yaml.tftpl", {
      tailscale_authkey = var.tailscale_authkey
      hostname          = "k3s-${each.key}"
    }))
  }
}

# --- Résolution des IP privées, nécessaires pour les backends du LB ---
data "oci_core_vnic_attachments" "nodes" {
  for_each       = oci_core_instance.k3s
  compartment_id = var.compartment_ocid
  instance_id    = each.value.id
}

data "oci_core_vnic" "nodes" {
  for_each = data.oci_core_vnic_attachments.nodes
  vnic_id  = each.value.vnic_attachments[0].vnic_id
}
