# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = 4
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  subnet_id = "subnet-0a86175c448873a6b"
  tags = {
    Name = "Udacity T2"
  }
}
# TODO: provision 2 m4.large EC2 instances named Udacity M4
#resource "aws_instance" "Udacity_M4" {
# count = 2
# ami           = "ami-0c2b8ca1dad447f8a"
# instance_type = "m4.large"
# subnet_id = "subnet-0a86175c448873a6b"
# tags = {
#   Name = "Udacity M4"
# }
#}