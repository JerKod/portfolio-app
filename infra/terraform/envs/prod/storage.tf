# Un seul volume de données, détaché du cycle de vie de l'instance.
# availability_domain DOIT correspondre à celui du nœud auquel il
# s'attache — un volume bloc ne traverse pas les AD.
resource "oci_core_volume" "app_data" {
  compartment_id      = var.compartment_ocid
  availability_domain = oci_core_instance.k3s["server"].availability_domain
  display_name        = "portfolio-app-data"
  size_in_gbs         = var.data_volume_size_gb

  # Garde-fou supplémentaire : un "terraform destroy" accidentel,
  # ou une recréation mal anticipée, ne supprimera jamais ce volume
  # sans confirmation explicite (retirer cette ligne à la main d'abord)
  lifecycle {
    prevent_destroy = true
  }
}

resource "oci_core_volume_attachment" "app_data" {
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.k3s["server"].id
  volume_id       = oci_core_volume.app_data.id
  display_name    = "app-data-attachment"
  is_read_only    = false
  is_shareable    = false
}
