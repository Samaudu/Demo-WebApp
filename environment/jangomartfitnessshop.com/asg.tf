# Create Security Group for ASG

resource "aws_security_group" "jfs_asg_sg" {
  vpc_id = aws_vpc.jfs_vpc.id
  name = "ASG Security Group"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
 ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [
      aws_security_group.jfs_alb_sg.id
    ]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.jfs_bastion_sg.id
    ]
  }
  tags = {
    Name        = "JFS ASG Security Group"
    Terraform   = "true"
  } 
}

# Template File Data Source
 
data "template_file" "userdata_template" {
  template = file("user-data.tpl")
  vars = {
    db_host         = "${aws_db_instance.jfs-db.address}",
    db_username     = "${aws_db_instance.jfs-db.username}"
    db_password     = "${var.db-master-password}"
    db_name         = "${aws_db_instance.jfs-db.name}"
    cache_host      = "${aws_elasticache_replication_group.jfs_elasticache.primary_endpoint_address}",
    efs-endpoint    = "${aws_efs_file_system.jfs_efs.dns_name}"
  }
}

# Create Launch Configuration

resource "aws_launch_configuration" "jfs_launch_config" {
  name_prefix     = "JFS Launch Configuration"
  image_id        = "ami-0640d96d1333f62f2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.jfs_asg_sg.id]
  key_name        = aws_key_pair.ssh-key.key_name
  user_data       = data.template_file.userdata_template.rendered
  lifecycle {
    create_before_destroy = true
  }
}

# Create DFSC FrontEnd ASG

resource "aws_autoscaling_group" "jfs_front_end" {
  name                 = "JFS FrontEnd ASG"
  launch_configuration = aws_launch_configuration.jfs_launch_config.name
  health_check_type    = "ELB"
  min_size             = 0
  max_size             = 0
  desired_capacity     = 0

  vpc_zone_identifier = [
    aws_subnet.jfs-private-1a.id,
    aws_subnet.jfs-private-1b.id
  ]
  target_group_arns = [aws_lb_target_group.jfs-front-end-tg.arn]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "JFS FrontEnd ASG"
    propagate_at_launch = true  
  }
}

# Create JFS Backend ASG

resource "aws_autoscaling_group" "jfs_back_end" {
  name                 = "JFS BackEnd ASG"
  launch_configuration = aws_launch_configuration.jfs_launch_config.name
  health_check_type    = "ELB"
  min_size             = 0
  max_size             = 0
  desired_capacity     = 0

  vpc_zone_identifier = [
    aws_subnet.jfs-private-1a.id,
    aws_subnet.jfs-private-1b.id
  ]
  target_group_arns = [aws_lb_target_group.jfs-back-end-tg.arn]
  lifecycle {
    create_before_destroy = true
  }
 tag {
    key                 = "Name"
    value               = "JFS BackEnd ASG"
    propagate_at_launch = true  
  }
}