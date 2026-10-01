data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_ocid
  display_name   = "portfolio-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
  dns_label      = "portfolio"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "portfolio-igw"
}

resource "oci_core_default_route_table" "default" {
  manage_default_resource_id = oci_core_vcn.main.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

# Sous-réseau régional (pas lié à un AD précis) : pratique recommandée
# actuelle sur OCI, les instances choisissent leur AD indépendamment.
resource "oci_core_subnet" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  cidr_block     = "10.0.1.0/24"
  display_name   = "portfolio-public"
  dns_label      = "public"
  route_table_id = oci_core_vcn.main.default_route_table_id
}

# --- NSG dédié au Load Balancer : seul élément exposé au monde entier ---
resource "oci_core_network_security_group" "lb" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "nsg-lb"
}

resource "oci_core_network_security_group_security_rule" "lb_ingress_http" {
  network_security_group_id = oci_core_network_security_group.lb.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source                    = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "lb_ingress_https" {
  network_security_group_id = oci_core_network_security_group.lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "lb_egress_all" {
  network_security_group_id = oci_core_network_security_group.lb.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = "0.0.0.0/0"
}

# --- NSG dédié aux nœuds : 80/443 ouverts UNIQUEMENT depuis le NSG du LB,
# jamais directement depuis Internet. Port 22 : absent, volontairement —
# tout accès admin passe par Tailscale, jamais par le réseau public. ---
resource "oci_core_network_security_group" "nodes" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "nsg-nodes"
}

resource "oci_core_network_security_group_security_rule" "nodes_ingress_http_from_lb" {
  network_security_group_id = oci_core_network_security_group.nodes.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source_type               = "NETWORK_SECURITY_GROUP"
  source                    = oci_core_network_security_group.lb.id
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nodes_ingress_https_from_lb" {
  network_security_group_id = oci_core_network_security_group.nodes.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source_type               = "NETWORK_SECURITY_GROUP"
  source                    = oci_core_network_security_group.lb.id
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

# Trafic inter-nœuds k3s : API server, kubelet, Flannel VXLAN —
# autorisé uniquement entre membres de ce même NSG (source = lui-même)
resource "oci_core_network_security_group_security_rule" "nodes_internal_tcp" {
  network_security_group_id = oci_core_network_security_group.nodes.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source_type               = "NETWORK_SECURITY_GROUP"
  source                    = oci_core_network_security_group.nodes.id
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nodes_internal_kubelet" {
  network_security_group_id = oci_core_network_security_group.nodes.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source_type               = "NETWORK_SECURITY_GROUP"
  source                    = oci_core_network_security_group.nodes.id
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nodes_internal_flannel" {
  network_security_group_id = oci_core_network_security_group.nodes.id
  direction                 = "INGRESS"
  protocol                  = "17" # UDP
  source_type               = "NETWORK_SECURITY_GROUP"
  source                    = oci_core_network_security_group.nodes.id
  udp_options {
    destination_port_range {
      min = 8472
      max = 8472
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nodes_egress_all" {
  network_security_group_id = oci_core_network_security_group.nodes.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = "0.0.0.0/0"
}
