# CREATE EFS SECURITY GROUP

resource "aws_security_group" "jfs_efs_sg" {
  name = "JFS EFS Security Group"
  vpc_id = aws_vpc.jfs_vpc.id
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    security_groups = [aws_security_group.jfs_asg_sg.id]
  }
  tags = {
    Name        = "EFS Security Group"
    Terraform   = "true"
  }
}

# CREATE ELASTIC FILE SYSTEM

resource "aws_efs_file_system" "jfs_efs" {
  creation_token = "jfs-elastic-file-system" 
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  tags = {
    Name        = "JFS Elastic File System"
    Terraform   = "true"
  }
}

# CREATE ELASTIC FILE SYSTEM MOUNT TARGETS

resource "aws_efs_mount_target" "jfs-mount-priavte-1a" {
  file_system_id = aws_efs_file_system.jfs_efs.id
  subnet_id      = aws_subnet.jfs-private-1a.id
  security_groups = [
    aws_security_group.jfs_efs_sg.id
  ]
}
resource "aws_efs_mount_target" "jfs-mount-priavte-1b" {
  file_system_id = aws_efs_file_system.jfs_efs.id
  subnet_id      = aws_subnet.jfs-private-1b.id
  security_groups = [
    aws_security_group.jfs_efs_sg.id
  ]
}