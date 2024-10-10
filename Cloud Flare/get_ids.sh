#!/bin/bash

# Cloudflare API URL
url="https://api.cloudflare.com/client/v4/zones/0ddcd29980f96ec6e9f2e92/dns_records?per_page=400"

# Cloudflare API Token
auth_token="Ntw1r3du-etaB0F3oh-I1koTXSL73Pm"

# Curl command to fetch DNS records
response=$(curl --location "$url" \
--header "Authorization: Bearer $auth_token" \
--header "Content-Type: application/json")

# Use jq to filter the result where "content" is "dev.galaxefi.com" and get the "id"
ids=$(echo "$response" | jq -r '.result[] | select(.content == "dev.galaxefi.com") | .id')

# Check if any IDs were found
if [ -n "$ids" ]; then
    # Store the IDs in a file
    echo "$ids" > ids.txt
    echo "IDs with content 'dev.galaxefi.com' have been saved to ids.txt"
else
    echo "No records found with content 'dev.galaxefi.com'"
fi

