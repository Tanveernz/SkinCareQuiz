terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 22"

  # allow access on port 22
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Monitoring server security group"
  }
}

resource "aws_instance" "Monitoring_server" {
  ami               = "ami-00bb6a80f01f03502"  
  instance_type     = "t3.micro"  # ← CHANGED from t2.medium to t3.micro
  security_groups   = [aws_security_group.ec2_security_group.name]
  key_name          = var.key_name
  
  tags = {
    Name = var.instance_name
  }
}

# Output the public IP address
output "public_ip" {
  value = aws_instance.Monitoring_server.public_ip
}

# Variables
variable "access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "skinCare1"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "Monitoring_server"
}