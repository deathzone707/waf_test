resource "google_compute_instance" "vm" {
  name = var.name
  machine_type = var.machine_type
  zone = var.zone
  tags = ["http-server"]
  labels = var.labels


  boot_disk {
      initialize_params {
          image = var.image
      } 
  }


  metadata = {
    "ssh-keys" = "austindunn:${file("~/.ssh/id_rsa.pub")}"
  }

  connection {
    private_key = file(var.private_key)
    user        = var.ansible_user
    host        = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
  }

  // Install python for ansible to function on remote host
  provisioner "remote-exec" {
    inline = ["sudo apt-get -qq install python3 python-apt -y "]
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral External IP
    }
  }
  
  // Call Ansible playbook to install apache2 & modsec & modsec rules
  provisioner "local-exec" {
    command = <<EOT
      sleep 30;
	      >apache.ini;
        echo "[host]\n" | tee -a apache.ini;
	      echo "${google_compute_instance.vm.network_interface.0.access_config.0.nat_ip}" | tee -a apache.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	      ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -e "inv=host" -i apache.ini ../ansible/waf_rule_deploy.yml
    EOT
  }  
}

resource "google_compute_firewall" "vm" {
  name    = var.fwname
  network = google_compute_network.vm.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "vm" {
  name = var.netname
}