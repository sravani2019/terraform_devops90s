resource "aws_instance" "terraform_demo" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = lookup(var.instance_type, local.environment)
  vpc_security_group_ids = [aws_security_group.terraform_demo.id]

  tags = {
    Name        = "${var.project}-${local.environment}-workspace"
    project = var.project
    environment = "local.environment"
    
  }
}

resource "aws_security_group" "terraform_demo" {
  name        = "${var.project}-${local.environment}-workspace"
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "${var.project}-${local.environment}-workspace"
    project = var.project
  }
}