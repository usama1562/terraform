

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami                    = "ami-0bb84b8ffd87024d8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0cd1acafcca4103b2", "sg-00eb56845dea9da55"]
  key_name               = "tf"
}

