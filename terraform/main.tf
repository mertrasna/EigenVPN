# the actual infrastructure
resource "aws-security-group" "eigenvpn" {
    name = "eigenvpn-sg"
    description = "EigenNPN security group"

    ingress {
        description = "WireGuard"
        from_port = 51820
        to_port = 51820
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"     # means allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
    }
}

