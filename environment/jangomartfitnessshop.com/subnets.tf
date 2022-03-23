# Create Public Subnets

resource "aws_subnet" "jfs-public-1a" {
  vpc_id = aws_vpc.jfs_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "JFS Pblic Subnet - 1A"
    Terraform   = "True"
  }
}
resource "aws_subnet" "jfs-public-1b" {
  vpc_id = aws_vpc.jfs_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name        = "JFS Pblic Subnet - 1B"
    Terraform   = "True"
  }
}


# Create Private Subnets


resource "aws_subnet" "jfs-private-1a" {
  vpc_id = aws_vpc.jfs_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = "false"
  tags = {
    Name        = "JFS Private Subnet - 1A"
    Terraform   = "True"
  }
}

resource "aws_subnet" "jfs-private-1b" {
  vpc_id = aws_vpc.jfs_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = "false"
  tags = {
    Name        = "JFS Private Subnet - 1B"
    Terraform   = "True"
  }
}