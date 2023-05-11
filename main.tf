resource "aws_vpc" "this" {
  cidr_block  = "10.5.0.0/16"

  tags = {
    Name = "dev"
  }

}

resource "aws_subnet" "this" {
  vpc_id      = aws_vpc.this.id
  cidr_block  = "10.5.1.0/24"

  tags = {
    Name = "app"
  }

}

resource "aws_internet_gateway" "this" {
  vpc_id     = aws_vpc.this.id

  tags = {
    Name = "east-www"
  }

}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block         = "0.0.0.0/0"
    gateway_id         = aws_internet_gateway.this.id
  }

  tags    = {
    Name  = "east-www-route"
  }

}

resource "aws_route_table_association" "public" {
  subnet_id       = aws_subnet.this.id
  route_table_id  = aws_route_table.this.id
}

resource "aws_security_group" "this" {
  vpc_id      = aws_vpc.this.id
  name        = "great-security-practices"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags    = {
    Name  = "great-security-practices"
  }

}

resource "aws_network_interface_sg_attachment" "this" {
  security_group_id     = aws_security_group.this.id
  network_interface_id  = aws_instance.this.primary_network_interface_id
}

resource "aws_instance" "this" {
  ami                         = "ami-0f0ba639982a32edb"
  instance_type               = "t3.nano"
  subnet_id                   = aws_subnet.this.id
  associate_public_ip_address = true

  tags    = {
    Name  = "my-instance"
  }

}