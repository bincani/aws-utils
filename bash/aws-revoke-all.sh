#!/bin/bash

# assumes all protocol and all ports all the time

if [ -z "$1" ] ; then
    profile="factoryx-prod"
else
    profile=$1
fi

if [ -z "$2" ] ; then
    sg="sg-86d348e3"
else
    sg=$2
fi

echo get sg $sg for profile $profile

# get the cidrs for the ingress rule
rules=$(aws --profile $profile ec2 describe-security-groups --group-ids $sg --output text --query 'SecurityGroups[*].IpPermissions')

cidr="^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$"
for rule in $rules; do
    if [[ $rule =~ $cidr ]]; then
        result=$(aws --profile $profile ec2 revoke-security-group-ingress --group-id $sg --protocol all --port 0-65535 --cidr $rule --output text)
        echo -n "remove $rule "
        if [ -z "$result" ] ; then
            echo "OK"
        else
            echo "FAIL"
        fi
    fi
done
