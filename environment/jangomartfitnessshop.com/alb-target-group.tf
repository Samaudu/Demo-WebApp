# Create Frontend Target Group

resource "aws_lb_target_group" "jfs-front-end-tg" {
  port = 80
  protocol = "HTTP"
  name = "jfs-front-end-target-group"
  vpc_id = aws_vpc.jfs_vpc.id
  stickiness {
    type = "lb_cookie"
    enabled = true
  }
  health_check {
    protocol = "HTTP"
    path = "/healthy.html"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
  }
  tags = {
    Name        = "jFS Front End Target Group"
    Terraform   = "True"   
  } 
}

# Create Backend Target Group


resource "aws_lb_target_group" "jfs-back-end-tg" {
  port = 80
  protocol = "HTTP"
  name = "jfs-back-end-target-group"
  vpc_id = aws_vpc.jfs_vpc.id
  stickiness {
    type = "lb_cookie"
    enabled = true
  }
  health_check {
    protocol = "HTTP"
    path = "/healthy.html"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
  }
  tags = {
    Name        = "JFS Back End Target Group"
    Terraform   = "True"   
  } 
}