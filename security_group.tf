resource "aws_security_group" "sg" {
   name = "allow_ssh_http"
   description = "allow ssh http inbound traffic"
   vpc_id = aws_vpc.app_vpc.id
}

ingress {
    description       = "ssh from vpc"
    from_port         = 22
    to_port           = 22
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
}
