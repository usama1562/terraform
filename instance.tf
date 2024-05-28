

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami                    = "ami-0bb84b8ffd87024d8"
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-00eb56845dea9da55", "sg-0cd1acafcca4103b2"]
  key_name               = "tf"
}

