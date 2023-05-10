resource "aws_vpc" "this" {
  provider    = aws.us-east-1

  cidr_block  = "10.0.0.0/16"

  tags = {
    Name = "dev"
  }

}

resource "aws_subnet" "this" {
  provider    = aws.us-east-1

  vpc_id      = aws_vpc.this.id
  cidr_block  = "10.0.1.0/24"

  tags = {
    Name = "app"
  }

}