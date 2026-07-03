terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"

  tags = {
    Env  = "prod"
    Team = "platform"
  }
}

resource "aws_db_instance" "main" {
  identifier     = "prod-db"
  engine         = "postgres"
  engine_version = "15"
  instance_class = "db.t3.micro"

  allocated_storage   = 20
  storage_encrypted   = true
  deletion_protection = true

  username = "admin"
  password = "changeme"

  skip_final_snapshot = true

  tags = {
    Env  = "prod"
    Team = "platform"
  }
}
