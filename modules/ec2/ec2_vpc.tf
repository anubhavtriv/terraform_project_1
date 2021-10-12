resource "aws_vpc" "web_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_tag_name}"
  }
}
resource "aws_internet_gateway" "web_igw" {
      vpc_id = aws_vpc.web_vpc.id

    tags = {
      Name = "${var.igw_tag_name}"
    }
}

resource "aws_subnet" "web_subnet" {
  vpc_id     = aws_vpc.web_vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = "${var.availability_zone}"
  tags = {
    Name = "${var.web_subnet_tag_name}"
  }
}

#************************* Security grp part ***********************************

resource "aws_security_group" "web_secgroup" {
  name        = "${var.secgroup_name}"
  description = "${var.secgroup_description}"
  vpc_id      = aws_vpc.web_vpc.id

    ingress {
        description      = "TLS from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH for VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
    Name = "${var.secgroup_name}"
  }
}

#********************************* rout_table_part *************************************
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }

  tags = {
    Name = "Routing_Table_web"
  }

}

resource "aws_route_table_association" "associate_rt" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rt.id
}