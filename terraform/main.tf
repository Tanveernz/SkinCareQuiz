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
  region = "ap-south-1"
}

# Create security group for the EC2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 22"

  # Allow SSH access
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
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

# Create EC2 instance for monitoring
resource "aws_instance" "Monitoring_server" {
  ami               = "ami-0f5ee92e2d63afc18"  # Amazon Linux 2023
  instance_type     = "t2.micro"
  security_groups   = [aws_security_group.ec2_security_group.name]
  key_name          = var.key_name
  
  # Disable detailed monitoring to save costs
  monitoring        = false

  tags = {
    Name        = var.instance_name
    Environment = "Learning"
    Project     = "Jenkins-CICD"
    CostCenter  = "Training"
    ManagedBy   = "Terraform"
  }

  # Lifecycle configuration
  lifecycle {
    ignore_changes = [ami]  # Prevent recreation when AMI updates
  }
}

# Output the public IP address
output "public_ip" {
  description = "Public IP address of the monitoring server"
  value       = aws_instance.Monitoring_server.public_ip
}

# Output the instance ID
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.Monitoring_server.id
}

# Variables
variable "key_name" {
  description = "SSH key pair name for EC2 instance"
  type        = string
  default     = "skinCare1"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "Monitoring_server"
}