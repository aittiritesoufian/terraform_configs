# Configure the AWS Provider
provider "aws" {
  version = "2.65.0"
  region  = "eu-west-1"
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  #associate_public_ip_address = true // si l'on souhaite ajouter une adresse IP publique
  key_name = "${aws_key_pair.deployer.key_name}" // utilisera la clé créer dans le ressource plus bas dans la configuration.
  // SInon créer une clé depuis l'interface AWS puis placer son nom entre qote dans la valeur du key_name.

  tags = {
    Name = "tp-terraform-test"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIERFBHCauRveovZ9qkeWV8iMGbuideFj/VqQD4mO0CoU9waWkTkYJKiQxEXz3fea2+MlMWCYi0H7FgyZjzPZvzXBz/yOmEnFoQ/oz4Q1EPw8yCB1za0Wh9pwavu2YIcnA3oQ0tlxswLADHrf8MO260LV3F0eU6j+V5VXr+0PW7jngPstRibqN4c0o+WvB+1cJ6rcqdrNEfhxcwz7Tq0vVdwYCFnyyEcczrqjmhjCJBeshblgC3dbkzu9Qp3dAEm5vHnzKOrOpiotsUR4IXzdY6EZoBJxHrefpvVzBztlTSCW+8Q0a8BwBy2JcWqBqtWWznjLlMM4aeaKgViRe3AQcCCgBEVnp9XflSijhMiFfQ6/ffuc5ZCNCyzt2jNHsB7ujCM5stNtAVVjlTMLSGSOTIlNL8AGaEOaq/No93DtKKJ668yIASiCPTNDUlp4iZ3aaFKkdd3GmGsGE2CkTl42wJ3DL837mUPgmMN9qyzNT7E2mi3HXXtkd2NWcD4t3i5cv2UamLMsP+1K8VjC8oWDavjBuIFnrmxDfpbTcYDHHUs48IwTaSwssZPOSpAYG7iNTP59R8mNTR6u4WIYW83gQTnouxnjXIuRhGKQrOjv5h6svgR12rVTNMD5LfEQFuZmwvm53u/snLogCddq/gsPZmZRt8hS4uNKM6MrPkU7nzQ== aittirite.soufian@gmail.com"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
