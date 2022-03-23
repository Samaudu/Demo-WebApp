# CREATE RDS SECURITY GROUP

resource "aws_security_group" "jfs_db_sg" {
  name = "JFS RDS Security Group"
  vpc_id = aws_vpc.jfs_vpc.id
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [
      aws_security_group.jfs_asg_sg.id
    ]
  }
  tags = {
    Name        = "RDS Security Group"
    Terraform   = "true"
  }
}

# Create JFS Database Subnet Group

resource "aws_db_subnet_group" "jfs-db-subnet" {
  name = "jfs-database-subnet-group"
  subnet_ids = [
    aws_subnet.jfs-private-1a.id,
    aws_subnet.jfs-private-1b.id
    ]

  tags = {
    Name        = "DB Subnet Group"
    Terraform   = "true"
  }
}

# Create JFS Database Instance 

resource "aws_db_instance" "jfs-db" {
  allocated_storage       = "10"
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  multi_az                = "true"
  instance_class          = "db.t2.micro"
  name                    = "magento"
  username                = "admin"
  password                = var.db-master-password
  identifier              = "jfs-database"
  skip_final_snapshot     = "true"
  backup_retention_period = "7"
  port                    = "3306"
  storage_encrypted       = "false"
  db_subnet_group_name    = aws_db_subnet_group.jfs-db-subnet.name
  vpc_security_group_ids  = [aws_security_group.jfs_db_sg.id]
   tags = {
    Name        = "JFS Database"
    Terraform   = "true"
  }
}