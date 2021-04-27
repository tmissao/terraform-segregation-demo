module "environment" {
  source = "../terraform_modules/environment_parameters"
}

data "terraform_remote_state" "network" {
  backend   = "s3"
  workspace = terraform.workspace
  config    = var.network_state_backend
}

data "terraform_remote_state" "storage" {
  backend   = "s3"
  workspace = terraform.workspace
  config    = var.storage_state_backend
}

data "aws_vpc" "selected" {
  id = data.terraform_remote_state.network.outputs.vpc_id
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "template_file" "init" {
  template = file("${path.module}/scripts/init.cfg")
}

data "template_file" "shell-script" {
  template = file("${path.module}/scripts/setup.sh")
  vars = {
    S3_BUCKET = data.terraform_remote_state.storage.outputs.id
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}

resource "aws_security_group" "server" {
  name        = "Server Security Group"
  description = "Allow Connection with Server"
  vpc_id      =  data.aws_vpc.selected.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    map(
      "Name", "Server Security Group",
    )
  )
}

resource "aws_instance" "server" {
  instance_type          = var.instance_size
  vpc_security_group_ids = [aws_security_group.server.id]
  subnet_id              = element(data.terraform_remote_state.network.outputs.public_subnets, 0)
  ami                    = data.aws_ami.amazon-linux-2.id
  iam_instance_profile   = module.server-role.iam_instance_profile_name
  user_data_base64       = data.template_cloudinit_config.config.rendered
  tags = merge(
    var.tags,
    map(
      "Name", "nginx-server",
    )
  )
  volume_tags = merge(
    var.tags,
    map(
      "Name", "nginx-server",
    )
  )
}