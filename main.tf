provider "aws" {
  region  = var.region
  profile = var.profile_name
}

resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    name = "app-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

resource "aws_subnet" "public_subnet" {
  availability_zone = var.region
  cidr_block        = var.public_subnet_cidr
  vpc_id            = aws_vpc.app_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_instance" "web" {
  ami           = "ami-094125af156557ca2" 
  instance_type = var.instance_type

  subnet_id              = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg.id]

   user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum install unzip wget httpd -y
  sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
  unzip main.zip -d /var/www/html
  cp -r /var/www/html/static-resume-main/iPortfolio/* /var/www/html/
  systemctl start httpd
  systemctl enable httpd
  echo "*** Completed Installing httpd"
  EOF

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}

