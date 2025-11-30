terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 22"

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
  ami               = "ami-0f5ee92e2d63afc18"
  instance_type     = "t3.micro"
  
  # Use Spot Instance to bypass Free Tier restrictions
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.005  # Maximum bid price (very low)
    }
  }
  
  security_groups   = [aws_security_group.ec2_security_group.name]
  key_name          = var.key_name
  monitoring        = false

  tags = {
    Name        = var.instance_name
    Environment = "Learning"
    Project     = "Jenkins-CICD"
    CostCenter  = "Training"
    ManagedBy   = "Terraform"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

output "public_ip" {
  value = aws_instance.Monitoring_server.public_ip
}

output "instance_id" {
  value = aws_instance.Monitoring_server.id
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