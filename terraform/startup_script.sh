#!/bin/bash

# Update and install WireGuard
apt-get update -y
apt-get install -y wireguard

# Generate server keys 
wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key
chmod 600 /etc/wireguard/server_private.key

# Store priv key in variable
SERVER_PRIVATE_KEY=$(cat /etc/wireguard/server_private.key) 

cat > /etc/wireguard/wg0.conf << EOF 
[Interface]
PrivateKey = $SERVER_PRIVATE_KEY
Address = 10.0.0.1/24
ListenPort = 51820

[Peer]
PublicKey = ${client_public_key} 
AllowedIPs = 10.0.0.2/32
EOF

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# NAT - forward traffic to internet
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o ens5 -j MASQUERADE
iptables -A FORWARD -i wg0 -j ACCEPT
iptables -A FORWARD -o wg0 -j ACCEPT

# Save iptables rules so they persist on reboot
DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
netfilter-persistent save


# Enable and start WireGuard
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0




