#!/usr/bin/env bash

counter=1
until [ -f /tmp/openvpn.log ] && [ "$(grep -c "Initialization Sequence Completed" /tmp/openvpn.log)" != 0 ] || [ "$counter" -ge 30 ]; do
  ((counter++))
  echo "Attempting to connect to VPN server..."
  sleep 1;
done

if [ ! -f /tmp/openvpn.log ] || (! grep -iq "Initialization Sequence Completed" /tmp/openvpn.log); then
  printf "\nUnable to establish connection within the allocated time ---> Giving up.\n"
else
  printf "\nVPN connected\n"
  printf "\nPublic IP is now %s\n" "$(curl -s http://checkip.amazonaws.com)"
fi