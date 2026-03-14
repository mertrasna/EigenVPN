# server IP
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "server_ip" {
  value       = aws_eip.eigenvpn.public_ip
  description = "EigenVPN server public IP"
}