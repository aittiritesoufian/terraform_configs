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
  public_key = ""
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
