# create a vpc for terraform-jenkins-class-project 
resource "aws_vpc" "terraform-jenkins-prod-vpc" {
  cidr_block  =  var.vpc_prod_cidr

  tags = { 
    Name = "terraform-jenkins-prod-vpc"
  }
}

resource "aws_subnet" "terraform-jenkins-prod-subnet1" {
  vpc_id     = aws_vpc.terraform-jenkins-prod-vpc.id
  cidr_block = var.vpc_prod_subnet_cidr[0]
  availability_zone = var.vpc_prod_subnet_az[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "terraform-jenkins-prod-public-subnet1-az1"
  }
}

resource "aws_subnet" "terraform-jenkins-prod-subnet2" {
  vpc_id     = aws_vpc.terraform-jenkins-prod-vpc.id
  cidr_block = var.vpc_prod_subnet_cidr[1]
  availability_zone = var.vpc_prod_subnet_az[1]
  map_public_ip_on_launch = "true"
  
  tags = {
    Name = "terraform-jenkins-prod-public-subnet2-az2"
  }
}

resource "aws_subnet" "terraform-jenkins-prod-subnet3" {
  vpc_id     = aws_vpc.terraform-jenkins-prod-vpc.id
  cidr_block = var.vpc_prod_subnet_cidr[2]
  availability_zone = var.vpc_prod_subnet_az[0]

  tags = {
    Name = "terraform-jenkins-prod-private-subnet1-az1"
  }
}

resource "aws_subnet" "terraform-jenkins-prod-subnet4" {
  vpc_id     = aws_vpc.terraform-jenkins-prod-vpc.id
  cidr_block = var.vpc_prod_subnet_cidr[3]
  availability_zone = var.vpc_prod_subnet_az[1]

  tags = {
    Name = "terraform-jenkins-prod-private-subnet2-az2"
  }
}

# create internet gateway in vpc 
resource "aws_internet_gateway" "terraform-jenkins-prod-igw" {
  vpc_id = aws_vpc.terraform-jenkins-prod-vpc.id

  tags = {
    Name = "terraform-jenkins-prod-igw"
  }
}

# create a route tables for public subnet 
resource "aws_route_table" "terraform-jenkins-prod-public-rt" {
  vpc_id = aws_vpc.terraform-jenkins-prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-jenkins-prod-igw.id
  }
  tags = {
    Name = "terraform-jenkins-prod-public-rt"
  }
}

# create a private route table for management vpc 
resource "aws_route_table" "terraform-jenkins-prod-private-rt" {
  vpc_id = aws_vpc.terraform-jenkins-prod-vpc.id
  tags = {
    Name = "terraform-jenkins-prod-private-rt"
  }
}

# crate a subnet assosiation for public rt
resource "aws_route_table_association" "publicrtsubnet1assosiation" {
  subnet_id      = aws_subnet.terraform-jenkins-prod-subnet1.id
  route_table_id = aws_route_table.terraform-jenkins-prod-public-rt.id
}
resource "aws_route_table_association" "publicrtsubnet2assosiation" {
  subnet_id      = aws_subnet.terraform-jenkins-prod-subnet2.id
  route_table_id = aws_route_table.terraform-jenkins-prod-public-rt.id
}


# crate a subnet assosiation for private rt
resource "aws_route_table_association" "privatesubnet1assosiation" {
  subnet_id      = aws_subnet.terraform-jenkins-prod-subnet3.id
  route_table_id = aws_route_table.terraform-jenkins-prod-private-rt.id
}

resource "aws_route_table_association" "privatesubnet2assosiation" {
  subnet_id      = aws_subnet.terraform-jenkins-prod-subnet4.id
  route_table_id = aws_route_table.terraform-jenkins-prod-private-rt.id
}