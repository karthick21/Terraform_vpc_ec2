
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "ecs-vpc"

  load_balancer_type = "application"

  vpc_id             =  aws_vpc.ecs-vpc.id
  subnets            = [aws_subnet.public-subnet-a.id, aws_subnet.public-subnet-b.id]
  security_groups    = [aws_security_group.ecs-sg.id]


  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = aws_instance.ecs-cluster-01.id
          port = 80
        },
        {
          target_id = aws_instance.ecs-cluster-02.id
          port = 80
        }
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-east-2:642748747910:certificate/58ad3bfb-f258-4e30-b974-fa55dba54033"
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    Environment = "ecs-alb"
  }
}
