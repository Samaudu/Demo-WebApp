# Create a public route table for Public Subnets
 
resource "aws_route_table" "jfs-public" {
  vpc_id = aws_vpc.jfs_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jfs-igw.id
  }
  tags = {
    Name        = "JFS Public Route Table"
    Terraform   = "true"
    }
}
 
# Attach a public route table to Public Subnets
 
resource "aws_route_table_association" "jfs-public-1a-association" {
  subnet_id = aws_subnet.jfs-public-1a.id
  route_table_id = aws_route_table.jfs-public.id
}
 
resource "aws_route_table_association" "jfs-public-1b-association" {
  subnet_id = aws_subnet.jfs-public-1b.id
  route_table_id = aws_route_table.jfs-public.id
}