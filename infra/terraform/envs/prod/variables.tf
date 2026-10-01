# --- Authentification (toutes injectées via TF_VAR_*) ---
variable "tenancy_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "private_key" {
  type      = string
  sensitive = true
}
variable "private_key_password" {
  type      = string
  sensitive = true
  default   = ""
}
variable "compartment_ocid" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-frankfurt-1"
}

# --- Nouveau prérequis : une clé de pré-authentification Tailscale ---
# Admin console Tailscale → Settings → Keys → Generate auth key
# (coche "Reusable", décoche "Ephemeral" pour que le nœud reste visible
# même déconnecté temporairement ; durée de vie max de 90 jours)
variable "tailscale_authkey" {
  type      = string
  sensitive = true
}

# --- Dimensionnement, avec des valeurs par défaut pour rester dans le Free Tier ---
variable "node_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "node_ocpus" {
  type    = number
  default = 1
}

variable "node_memory_gb" {
  type    = number
  default = 6
}

variable "boot_volume_size_gb" {
  type    = number
  default = 48
}

variable "data_volume_size_gb" {
  type    = number
  default = 48
}

variable "nodes" {
  description = "Un nœud = une entrée. 'server' porte le control plane k3s."
  type = map(object({
    role = string # "server" ou "agent"
  }))
  default = {
    server = { role = "server" }
    agent  = { role = "agent" }
  }
}
