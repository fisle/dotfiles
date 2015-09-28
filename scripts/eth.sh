#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    gksudo ~/scripts/eth.sh
    exit
fi
ETH="enp0s25"
INET="wlp2s0"
ip addr add 10.200.40.1 dev $ETH
ip route add 10.200.40.0/24 dev $ETH
echo 1 > /proc/sys/net/ipv4/ip_forward
INETIP=$(ip a s dev $INET | grep inet | grep -P -o '([0-9\.]{1,4}){4}' | head -1)
iptables -t nat -A POSTROUTING -o $INET -j SNAT --to-source $INETIP
