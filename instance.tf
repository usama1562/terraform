provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "usa_tls" {
  name        = "usa_tls"
  description = "Allow SSH for all network"
  vpc_id      = "vpc-0b108c47b1923e4ae" # VPC ID should be a string

  ingress {
    description      = "SSH rule"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "usa_tls"
    Env  = "Dev"
  }
}

data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu) account ID

  filter {
    name   = "name"
    values = ["ubuntu-pro-server/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-pro-server-20240423"]
  }
}

resource "aws_instance" "instance2" {
  ami                    = data.aws_ami.my_ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.usa_tls.id]
  key_name               = "l1"

  tags = {
    Name = "usa_tls"
    Env  = "Dev"
  }
}

variable "instance_type" {
  type    = string
  default = "t4g.micro" # Changed to an arm64 compatible instance type
}

output "hellow" {
  value = "hello world" # Correct spelling
}

output "public_ip" {
  value = aws_instance.instance2.public_ip
}
