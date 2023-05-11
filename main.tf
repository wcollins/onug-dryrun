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

resource "aws_route_table" "public" {
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