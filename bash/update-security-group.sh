#!/bin/bash

## add ip address to my security group
aws --profile factoryx-prod ec2 authorize-security-group-ingress --group-id sg-86d348e3 --protocol all --port all --cidr `echo $SSH_CLIENT | awk '{ print $1"/32"}'` > /dev/null 2>&1
aws --profile factoryx-stage ec2 authorize-security-group-ingress --group-id sg-4cfb6329 --protocol all --port all --cidr `echo $SSH_CLIENT | awk '{ print $1"/32"}'` > /dev/null 2>&1

