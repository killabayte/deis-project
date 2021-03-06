resource "digitalocean_ssh_key" "deis-ssh-key" {
    name = "deis ssh key"
    public_key = "${file("${var.PUBLIC_SSH_KEY}")}"
}
resource "digitalocean_droplet" "deis-project-1" {
    image = "coreos-beta"
    name = "deis-project-1"
    region = "ams3"
    size = "1gb"
    private_networking = "true"
    ssh_keys = ["${digitalocean_ssh_key.deis-ssh-key.id}"]
}
resource "digitalocean_droplet" "deis-project-2" {
    image = "coreos-beta"
    name = "deis-project-2"
    region = "ams3"
    size = "1gb"
    private_networking = "true"
    ssh_keys = ["${digitalocean_ssh_key.deis-ssh-key.id}"]
}
resource "digitalocean_droplet" "deis-project-3" {
    image = "coreos-beta"
    name = "deis-project-3"
    region = "ams3"
    size = "1gb"
    private_networking = "true"
    ssh_keys = ["${digitalocean_ssh_key.deis-ssh-key.id}"]
}

resource "digitalocean_droplet" "loadbalancer" {
    image = "coreos-beta"
    name = "deis-lb-1"
    region = "ams3"
    size = "512mb"
    private_networking = "true"
    ssh_keys = ["${digitalocean_ssh_key.deis-ssh-key.id}"]
}
output "output-deis-project-1" {
  value = "- { host: ${digitalocean_droplet.deis-project-1.ipv4_address}, fqdn: ${digitalocean_droplet.deis-project-1.name}.example.com, ip: ${digitalocean_droplet.deis-project-1.ipv4_address_private} }"
}
output "output-deis-project-2" {
  value = "- { host: ${digitalocean_droplet.deis-project-2.ipv4_address}, fqdn: ${digitalocean_droplet.deis-project-2.name}.example.com, ip: ${digitalocean_droplet.deis-project-2.ipv4_address_private} }"
}
output "output-deis-project-3" {
  value = "- { host: ${digitalocean_droplet.deis-project-3.ipv4_address}, fqdn: ${digitalocean_droplet.deis-project-3.name}.example.com, ip: ${digitalocean_droplet.deis-project-3.ipv4_address_private} }"
}

output "output-deis-lb" {
  value = "Load balancer: ${digitalocean_droplet.loadbalancer.ipv4_address} - ${digitalocean_droplet.loadbalancer.ipv4_address_private}"
}

