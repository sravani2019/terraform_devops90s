resource "aws_instance" "terraform_demo" {
  ami                    = data.aws_ami.joindevops.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.terraform_demo.id]

  tags = {
    Name        = "Terraform-demo"
    project     = "roboshop"
    environment = "dev"
  }
}

resource "aws_security_group" "terraform_demo" {
  name        = "allow_terraform_state"
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "terraform_demo"
  }
}