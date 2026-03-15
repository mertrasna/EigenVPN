# the actual infrastructure
resource "aws_security_group" "eigenvpn" {
  name        = "eigenvpn-sg"
  description = "EigenNPN security group"

  ingress {
    description = "WireGuard"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "eigenvpn" {
  ami           = var.ami
  instance_type = var.instance_type
  # VPC (virtual private cloud) -> your own private network inside AWS - Every account comes with default VPC already created in each region
  vpc_security_group_ids = [aws_security_group.eigenvpn.id]
  key_name               = aws_key_pair.eigenvpn.key_name

  user_data = templatefile("startup_script.sh", { client_public_key = var.client_public_key }) # special argument for EC2s, EC2 will execute this on first boot, automatically 

  tags = {
    Name = "Eigen VPN"
  }
}

resource "aws_eip" "eigenvpn" { # Elastic IP 
  domain = "vpc"

  tags = {
    Name = "EigenVPN"
  }
}

resource "aws_eip_association" "eigenvpn" { # links EIP to the EC2 instance 
  instance_id   = aws_instance.eigenvpn.id
  allocation_id = aws_eip.eigenvpn.id
}

resource "aws_key_pair" "eigenvpn" { # registers your public key in AWS's system
  key_name   = "eigenvpn-key"
  public_key = var.ssh_public_key
}
