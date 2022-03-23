# Create Bastion Host Security Group

resource "aws_security_group" "jfs_bastion_sg" {
  vpc_id = aws_vpc.jfs_vpc.id
  name = "Bastion Host Security Group"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name        = "JFS Bastion Security Group"
    Terraform   = "true"
    } 
}


# CREATE BASTION HOST IN EU-WEST-1A PUBLIC SUBNET

resource "aws_instance" "Jfs_bastion_host-1a" {
  ami = "ami-0b4b2d87bdd32212a"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.jfs_bastion_sg.id]
  subnet_id = aws_subnet.jfs-public-1a.id
  tags = {
    Name = "JFS Bastion Host - 1A"
    Terraform = true
  }
}

# CREATE BASTION HOST IN EU-WEST-1B PUBLIC SUBNET

resource "aws_instance" "jfs_bastion_host-1b" {
  ami = "ami-0b4b2d87bdd32212a"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.jfs_bastion_sg.id]
  subnet_id = aws_subnet.jfs-public-1b.id
  tags = {
    Name = "JFS Bastion Host - 1B"
    Terraform = true
  }
}