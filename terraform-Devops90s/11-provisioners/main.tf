resource "aws_instance" "terraform_demo" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.terraform_demo.id]

  tags = {
    Name        = "Terraform-demo"
    project     = "roboshop"
    environment = "dev"
  }
  provisioner "local-exec" {
     command = "echo The server's IP address is ${self.private_ip} > inventory.ini"
  }
   provisioner "local-exec" {
     command = "echo instance created"
  }
   provisioner "local-exec" {
    when = destroy
     command = "echo instance destroyed"

  }
  provisioner "local-exec" {
    when = destroy
     command = "echo > inventory.ini"

  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "echo 'hello from terraform remote-exec' | sudo tee /var/www/html/index.html",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]
  }
  provisioner "remote-exec" {
    when = destroy
    inline = [
      
      "sudo systemctl disable",
      "sudo systemctl stop nginx"
    ]
  }
     connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      password = "DevOps321"
      timeout     = "5m"
    }
  }



resource "aws_security_group" "terraform_demo" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "terraform_demo"
  }
}