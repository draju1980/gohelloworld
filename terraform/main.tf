provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "app_node" {
  ami                    = "ami-0694d931cee176e7d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_security_group.id]

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              apt-get update -y
              apt-get install -y docker.io
              sudo usermod -aG docker ec2-user
              EOF

  tags = {
    Name = "app_node"
  }
}

resource "aws_security_group" "app_security_group" {
  name        = "app_security_group"
  description = "Security group for app instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
