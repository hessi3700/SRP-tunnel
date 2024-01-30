#!/bin/bash

#Generate an RSA key pair
ssh-keygen -t rsa
#Prompt the user to enter the range of ports to forward
read -p "Enter the remote servers port(porte servere kharej-default:22) : " out_port
read -p "Enter the remote servers address(ip/domain e servere kharej) : " out_ip
read -p "Enter the remote servers username(username servere kharej-default:root) : " out_user
read -p "Enter the starting port range: " start_port
read -p "Enter the ending port range: " end_port
out_user=${out_user:-root}
out_port=${out_port:-22}
ssh-copy-id -i ~/.ssh/id_rsa.pub -p$out_port $out_user@$out_ip

#Create a persistent port forwarding tunnel
for port in $(seq $start_port $end_port); do
  ssh -p $out_port -f -N -L $port:localhost:$port $out_user@$out_ip
done 
