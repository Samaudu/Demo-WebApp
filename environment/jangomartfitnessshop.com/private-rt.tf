# Create first private route table and associate it with private subnet in eu-west-1a
 
resource "aws_route_table" "jfs_private_route_table_1a" {
    vpc_id = aws_vpc.jfs_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.jfs-nat-gateway-1a.id
  }
    tags =  {
        Name      = "JFS Private route table 1A"
        Terraform = "True"
  }
}
 
resource "aws_route_table_association" "Jfs-1a" {
    subnet_id = aws_subnet.jfs-private-1a.id
    route_table_id = aws_route_table.jfs_private_route_table_1a.id
}
 
# Create second private route table and associate it with private subnet in eu-west-1b 
 
resource "aws_route_table" "jfs_private_route_table_1b" {
    vpc_id = aws_vpc.jfs_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.jfs-nat-gateway-1b.id
  }
    tags =  {
        Name      = "JFS Private route table 1B"
        Terraform = "True"
  }
}
 
resource "aws_route_table_association" "jfs-1b" {
    subnet_id =  aws_subnet.jfs-private-1b.id
    route_table_id = aws_route_table.jfs_private_route_table_1b.id
}
