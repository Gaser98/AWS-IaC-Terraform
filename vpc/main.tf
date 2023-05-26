resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count                = 2
  vpc_id               = aws_vpc.main.id
  cidr_block           = var.public_subnet_cidr_blocks[count.index]
  availability_zone    = var.availability_zones[count.index]
}

resource "aws_subnet" "private" {
  count                = 2
  vpc_id               = aws_vpc.main.id
  cidr_block           = var.private_subnet_cidr_blocks[count.index]
  availability_zone    = var.availability_zones[count.index]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "public" {
  subnet_id       = aws_subnet.public[0].id
  allocation_id   = aws_eip.nat.id
}

resource "aws_eip" "nat" {
  vpc   = true 
}

resource "aws_route_table" "public" {
  count           = 2
  vpc_id          = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
tags = {
    Name = "public route table"
  }
}
resource "aws_route_table" "private" {
  count           =  2
  vpc_id          = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }
tags = {
    Name = "private route table"
  }

}

resource "aws_route_table_association" "public" {
  count           = 2
  subnet_id       = aws_subnet.public[count.index].id
  route_table_id  = aws_route_table.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count           = 2
  subnet_id       = aws_subnet.private[count.index].id
  route_table_id  = aws_route_table.private[count.index].id
}


