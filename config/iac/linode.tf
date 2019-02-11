# Configure the Linode provider
provider "linode" {
  token = ""
}

resource "linode_instance" "web" {
  label = "my-docker"
  image = "linode/ubuntu18.04"
  region = "eu-central"
  type = "g6-standard-1"
  authorized_keys = [""]
  root_pass = "my-docker-linode"

  group = "wp"
  tags = [ "my-docker" ]
  swap_size = 256
  private_ip = false

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable\"",
      "sudo apt update",
      "sudo apt install -y docker-ce",
      "sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "docker-compose --version",
      "sudo apt install -y git",
      "sudo apt install -y composer",
      "git clone https://github.com/ekandreas/my-docker",
      "cd ~/my-docker && composer install --no-dev",
      "cd ~/my-docker && docker-compose up -d",
    ]
  }

  provisioner "local-exec" {
    command = "echo ${linode_instance.web.ip_address} > .linode_ip_address.txt"
  }

}