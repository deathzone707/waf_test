variable "project_id" {
    description = "Google cloud project ID."
    type = string
    default = "apache-modsec"
}

variable "region" {
    description = "Google cloud region."
    type = string
    default = "us-west1"
}

variable "name" {
  description = "Web server name."
  type = string
  default = "apache-modsec"
}

variable "machine_type" {
  description = "GCP VM instance type."
  type = string
  default = "f1-micro"
}

variable "zone" {
  description = "GCP zone name."
  type = string
  default = "us-west1-a"
}

variable "image" {
    description = "GCE compute engine image."
    type = string
    default = "debian-cloud/debian-9"
}

variable "netname" {
    description = "Network name."
    type = string
    default = "waf-example-network"
}

variable "fwname" {
    description = "Firewall name."
    type = string
    default = "waf-example-firewall"
}

variable "labels" {
  description = "List of labels to attach to VM instance."
  type = map
}

variable "private_key" {
  type = string
  default = "~/.ssh/id_rsa"
}

variable "ansible_user" {
  type = string
  default = "austindunn"
}

variable "cloud_key" {
  type = string
  default = "./creds/apache-modsec-952a08a33240.json"
}