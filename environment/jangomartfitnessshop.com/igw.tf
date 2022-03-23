# Create and Attach internet gateway

resource "aws_internet_gateway" "jfs-igw" {
  vpc_id = aws_vpc.jfs_vpc.id
  tags = {
    Name        = "JFS Internet Gateway"
    Terraform   = "true"
  }
}