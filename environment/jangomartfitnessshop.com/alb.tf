# Create Application Load Balancer Security Group

resource "aws_security_group" "jfs_alb_sg" {
  vpc_id = aws_vpc.jfs_vpc.id
  name = "ALB Security Group"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name        = "JFS ALB Security Group"
    Terraform   = "True"   
  } 
}

# Create Application Load Balancer

resource "aws_lb" "jfs_alb" {
  name               = "jfs-app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jfs_alb_sg.id]
  subnets = [
    aws_subnet.jfs-public-1a.id,
    aws_subnet.jfs-public-1b.id,
  ]
  enable_deletion_protection = false
  tags = {
    Name        = "JFS Application Load Balancer"
    Terraform   = "True"   
  } 
}