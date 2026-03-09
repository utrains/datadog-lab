provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  lab_name = "lab3"

  common_tags = {
    Project     = "datadog-observability-lab"
    ManagedBy   = "terraform"
    Environment = "lab"
    Lab         = local.lab_name
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

resource "aws_security_group" "lab" {
  name        = "${var.name_prefix}-${local.lab_name}-sg"
  description = "Security group for ${local.lab_name}"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_cidr]
  }

  ingress {
    description = "App direct access"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-${local.lab_name}-sg"
  })
}

resource "aws_instance" "lab" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.selected.ids[0]
  vpc_security_group_ids      = [aws_security_group.lab.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data_replace_on_change = true
  user_data                   = templatefile("${path.module}/user_data.sh.tftpl", {
    datadog_api_key = var.datadog_api_key
  })

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-${local.lab_name}"
  })
}
