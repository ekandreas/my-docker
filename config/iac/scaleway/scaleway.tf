provider "scaleway" {
  organization = "${var.org}"
  token = "${var.token}"
  region = "ams1"
}

resource "scaleway_ip" "ip" {
  server = "${scaleway_server.my_docker.id}"

  provisioner "local-exec" {
    command = "echo ${scaleway_ip.ip.ip} > .ip_address.txt"
  }

}

resource "scaleway_server" "my_docker" {
  name = "my_docker"
  image = "b33c14a6-3e2a-42f8-bebe-2f64a3ef6217"
  type = "START1-S"
}

resource "scaleway_ssh_key" "my_docker" {
  key = "${var.authorized_keys}"
}

resource "scaleway_security_group" "http" {
  name = "http"
  description = "allow HTTP and HTTPS traffic"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 443
}

resource "scaleway_security_group" "docker" {
  name = "docker"
  description = "allow Docker deploy"
}

resource "scaleway_security_group_rule" "docker_accept" {
  security_group = "${scaleway_security_group.docker.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 2375
}
