terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

variable "key_content" {
  description = "SSH private key content"
  type        = string
  default     = ""
}

resource "aws_key_pair" "ssh_keys"{
    key_name = "ssh_keys"
    public_key = file("/var/lib/jenkins/workspace/terraform-ansible/id_rsa.pub")
}
    

resource "aws_instance" "example_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_keys.key_name 
 

  user_data = <<-EOF
              #!/bin/bash
              echo "${aws_key_pair.ssh_keys.public_key}" >> /home/ubuntu/.ssh/authorized_keys
              chmod 600 /home/ubuntu/.ssh/authorized_keys
              chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys
              echo "jenkins" | sudo tee /etc/hostname
              sudo hostnamectl set-hostname jenkins
              EOF
}

output "instance_id" {
  value = aws_instance.example_instance.id
}

output "instance_ip" {
  value = aws_instance.example_instance.public_ip
}

