resource "oci_load_balancer_load_balancer" "public" {
  compartment_id             = var.compartment_ocid
  display_name               = "portfolio-lb"
  shape                      = "flexible"
  subnet_ids                 = [oci_core_subnet.public.id]
  network_security_group_ids = [oci_core_network_security_group.lb.id]
  is_private                 = false

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 10 # forme Always Free, non modifiable
  }
}

# TLS termine chez Traefik, jamais au LB : les deux listeners sont
# de purs relais TCP (couche 4), pas des listeners HTTP/HTTPS.
resource "oci_load_balancer_backend_set" "http" {
  name             = "http"
  load_balancer_id = oci_load_balancer_load_balancer.public.id
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "TCP"
    port              = 80
    interval_ms       = 10000
    timeout_in_millis = 3000
    retries           = 3
  }
}

resource "oci_load_balancer_backend_set" "https" {
  name             = "https"
  load_balancer_id = oci_load_balancer_load_balancer.public.id
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "TCP"
    port              = 443
    interval_ms       = 10000
    timeout_in_millis = 3000
    retries           = 3
  }
}

resource "oci_load_balancer_listener" "http" {
  name                     = "http"
  load_balancer_id         = oci_load_balancer_load_balancer.public.id
  default_backend_set_name = oci_load_balancer_backend_set.http.name
  port                     = 80
  protocol                 = "TCP"
}

resource "oci_load_balancer_listener" "https" {
  name                     = "https"
  load_balancer_id         = oci_load_balancer_load_balancer.public.id
  default_backend_set_name = oci_load_balancer_backend_set.https.name
  port                     = 443
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend" "http" {
  for_each         = oci_core_instance.k3s
  load_balancer_id = oci_load_balancer_load_balancer.public.id
  backendset_name  = oci_load_balancer_backend_set.http.name
  ip_address       = data.oci_core_vnic.nodes[each.key].private_ip_address
  port             = 80
}

resource "oci_load_balancer_backend" "https" {
  for_each         = oci_core_instance.k3s
  load_balancer_id = oci_load_balancer_load_balancer.public.id
  backendset_name  = oci_load_balancer_backend_set.https.name
  ip_address       = data.oci_core_vnic.nodes[each.key].private_ip_address
  port             = 443
}
