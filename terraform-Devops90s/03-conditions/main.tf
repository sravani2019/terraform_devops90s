resource "aws_instance" "terraform_demo" {
  ami                    = var.ami_id
  instance_type          = var.environment== "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [aws_security_group.terraform_demo.id]

  tags = var.ec2_tags


}

resource "aws_security_group" "terraform_demo" {
  name        = var.sg_name
  description = var.sg_description
  #vpc_id      = aws_vpc.main.id

  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }



  tags = var.ec2_tags

}