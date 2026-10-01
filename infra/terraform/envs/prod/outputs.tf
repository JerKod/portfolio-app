output "lb_public_ip" {
  value = oci_load_balancer_load_balancer.public.ip_address_details[0].ip_address
}

output "node_public_ips" {
  value = { for k, v in oci_core_instance.k3s : k => v.public_ip }
}

output "node_private_ips" {
  value = { for k, v in data.oci_core_vnic.nodes : k => v.private_ip_address }
}
