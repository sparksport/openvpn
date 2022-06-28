#!/usr/bin/env bash

echo $VPN_CONFIG | base64 --decode > /tmp/config.ovpn

if grep -q auth-user-pass /tmp/config.ovpn; then
  if [ -z "${VPN_USERNAME:-}" ] || [ -z "${VPN_PASSWORD:-}" ]; then
    echo "Your VPN client is configured with a user-locked profile. Make sure to set the VPN_USERNAME and VPN_PASSWORD environment variables"
    exit 1
  else
    printf "%s" "$VPN_USERAME\\n$VPN_PASSWORD" > /tmp/vpn.login
  fi
fi

vpn_command=(sudo openvpn
  --config /tmp/config.ovpn
  --route 169.254.0.0 255.255.0.0 net_gateway
  --script-security 2
  --up /etc/openvpn/update-systemd-resolved --up-restart
  --down /etc/openvpn/update-systemd-resolved --down-pre
  --dhcp-option DOMAIN-ROUTE .)

if grep -q auth-user-pass /tmp/config.ovpn; then
  vpn_command+=(--auth-user-pass /tmp/vpn.login)
fi

ET_phone_home=$(ss -Hnto state established '( sport = :ssh )' | head -n1 | awk '{ split($4, a, ":"); print a[1] }')
echo $ET_phone_home

if [ -n "$ET_phone_home" ]; then
  vpn_command+=(--route "$ET_phone_home" 255.255.255.255 net_gateway)
fi

for IP in $(host runner.circleci.com | awk '{ print $4; }')
  do
    vpn_command+=(--route "$IP" 255.255.255.255 net_gateway)
    echo $IP
done

for SYS_RES_DNS in $(systemd-resolve --status | grep 'DNS Servers'|awk '{print $3}')
  do
    vpn_command+=(--route "$SYS_RES_DNS" 255.255.255.255 net_gateway)
    echo $SYS_RES_DNS
done

"${vpn_command[@]}" > /tmp/openvpn.log