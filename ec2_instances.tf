resource "aws_instance" "ecs-cluster-01" {
  ami = "ami-0245697ee3e07e755"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet-a.id
  associate_public_ip_address = true

  vpc_security_group_ids = [ aws_security_group.ecs-sg.id ]

  root_block_device {
    delete_on_termination = true
    volume_type = "gp2"
    volume_size = 8
  }
tags = {
    "Name" = "ecs-cluster-01"
  }
}
resource "aws_instance" "ecs-cluster-02" {
  ami = "ami-0245697ee3e07e755"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet-b.id
  associate_public_ip_address = true

  vpc_security_group_ids = [ aws_security_group.ecs-sg.id ]

  root_block_device {
    delete_on_termination = true
    volume_type = "gp2"
    volume_size = 8
  }
tags = {
    "Name" = "Server2"
  }
}

output "publicip1" {
  value = aws_instance.ecs-cluster-01.public_ip
}

output "publicip2" {
  value = aws_instance.ecs-cluster-02.public_ip
}
