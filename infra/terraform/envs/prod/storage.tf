# Un volume de données PAR nœud — Longhorn réplique lui-même entre eux,
# il ne veut pas d'un disque partagé.
resource "oci_core_volume" "data" {
  for_each            = var.nodes
  compartment_id      = var.compartment_ocid
  availability_domain = oci_core_instance.k3s[each.key].availability_domain
  display_name        = "portfolio-data-${each.key}"
  size_in_gbs         = var.data_volume_size_gb
}

resource "oci_core_volume_attachment" "data" {
  for_each        = var.nodes
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.k3s[each.key].id
  volume_id       = oci_core_volume.data[each.key].id
  display_name    = "data-attachment-${each.key}"
  device          = "/dev/oracleoci/oraclevdb" # chemin stable, identique sur les 2 nœuds
  is_read_only    = false
  is_shareable    = false
}
