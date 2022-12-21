resource "aws_security_group" "sg" {
    name = "allow_ssh_http"
    description = "allow ssh http inbound traffic"
    vpc_id = aws_vpc.app_vpc.id


    ingress {
        description       = "ssh from vpc"
        from_port         = 22
        to_port           = 22
        cidr_blocks       = ["0.0.0.0/0"]
        ipv6_cidr_blocks  = ["::/0"]
    }
    ingress {
        description      = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_ssh_http"
    }
}