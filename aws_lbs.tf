resource "aws_lb" "SevenLBS" {
  name               = "SevenLBS"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [TaskMaster]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}
