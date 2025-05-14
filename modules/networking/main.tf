terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-InternetGateway"
    }
  )
}

# Single EIP for NAT Gateway
resource "aws_eip" "nat" {
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-NAT-EIP"
    }
  )
}

# Single NAT Gateway in the first public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # Using first public subnet
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-NAT-Gateway"
    }
  )
  depends_on = [aws_internet_gateway.main]
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-Pub-${element(var.availability_zones_short, count.index)}"
    }
  )
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-Pvt-${element(var.availability_zones_short, count.index)}"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-Pub-RT"
    }
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Single route table for all private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-Pvt-RT"
    }
  )
}

# Single route pointing to our NAT Gateway
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = concat(
    [aws_route_table.public.id],
    [aws_route_table.private.id]  # Updated to use single private route table
  )
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-S3-Endpoint"
    }
  )
}
