resource "aws_vpc" "ecs-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = "ecs-vpc"
  }
}

resource "aws_internet_gateway" "internet-GW" {
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
      "Name" = "IG"
  }
}

resource "aws_subnet" "public-subnet-a" {
  vpc_id = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "Public-1-a"
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id = aws_vpc.ecs-vpc.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "us-east-2b"
  tags = {
    "Name" = "Public-2-B"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.ecs-vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.internet-GW.id
  }
  tags = {
    "Name" = "main_route"
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.routetable.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id = aws_subnet.public-subnet-b.id
  route_table_id = aws_route_table.routetable.id
}
