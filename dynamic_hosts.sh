#!/bin/bash

# Get the IP address of the EC2 instance
ip_address=$(terraform output instance_ip)

# Add the IP address to the hosts file
echo $ip_address > inventory
