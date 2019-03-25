#!/bin/bash

#set -x

# client ip address
CLIENT_IP=$(echo $SSH_CLIENT | awk '{ print $1"/32"}')
echo "CLIENT_IP: ${CLIENT_IP}"

# get current bucket policy --output json escapes quotes
aws s3api get-bucket-policy --bucket fx-backup-media --profile factoryx-prod --output text --query 'Policy' > policy.json

# get the number of ip addresses to use as an index
IP_CNT=$(cat policy.json | jq '.Statement[0].Condition.IpAddress["aws:SourceIp"] | length')
IP_CNT=$((IP_CNT-1))
# echo "IP_CNT: ${IP_CNT}"

# generate an updated policy and pipe to file
UPDATED_POLICY=$(cat policy.json | jq -r --arg IP $CLIENT_IP --arg IP_CNT $IP_CNT '.Statement[0].Condition.IpAddress["aws:SourceIp"][$IP_CNT | tonumber] = $IP')
now=$(date +"%Y%m%d-%H%M%S")
echo "$UPDATED_POLICY" > "policy-$now.json"

# update the policy
aws s3api put-bucket-policy --bucket fx-backup-media --profile factoryx-prod --policy file://policy-${now}.json
echo "add $CLIENT_IP to policy"

