# create security group for public servers
resource "aws_security_group" "terraform-jenkins-dev-sg" {
  name        = "terraform-jenkins-dev-sg"
  description = "Security Group for terraform-jenkins-dev-sg "
  vpc_id = aws_vpc.terraform-jenkins-dev-vpc.id

    ingress {
      description = "Allow port ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "Allow port http"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
