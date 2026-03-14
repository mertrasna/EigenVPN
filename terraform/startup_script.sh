#!/bin/bash

# Update and install WireGuard
apt-get update -y
apt-get install -y wireguard

# Generate server keys 
wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key
chmod 600 /etc/wireguard/server_private.key

# Store priv key in variable
SERVER_PRIVATE_KEY=$(cat /etc/wireguard/server_private.key) # runs everything as a command first to let us save 

cat > /etc/wireguard/wg0.conf << EOF # herodoc for keys
[Interface]
PrivateKey = $SERVER_PRIVATE_KEY
Address = 10.0.0.1/24
ListenPort = 51820

[Peer]
PublicKey = ${client_public_key} # reads the terraform variable
AllowedIPs = 10.0.0.2/32
EOF

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# Enable and start WireGuard
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0




