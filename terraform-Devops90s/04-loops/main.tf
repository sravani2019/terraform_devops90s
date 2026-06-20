resource "aws_instance" "roboshop" {
  count = length(var.instances)
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop[count.index].id,
                            aws_security_group.common.id]

  tags = {
    Name = "${var.project}-${var.environment}-${var.instances[count.index]}"

  }
  lifecycle {
    create_before_destroy = true

}

}

resource "aws_security_group" "roboshop" {
  count = length(var.instances)
  name        = "${var.project}-${var.environment}-${var.instances[count.index]}"
  description = var.sg_description
  #vpc_id      = aws_vpc.main.id

  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }



  tags = {
    Name = "${var.project}-${var.environment}-${var.instances[count.index]}"
  }

}
resource "aws_security_group" "common" {
  
  name        = "${var.project}-${var.environment}-common"
  description = var.sg_description
  #vpc_id      = aws_vpc.main.id

  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }



  tags = {
    Name = "${var.project}-${var.environment}-common"
  }

}