#!/bin/bash

# Cloudflare API URL and token
zone_id="0ddcd29980f96e1c6e9f2e92"
auth_token="Ntw1r3du-etaB0Kq9oh-IkoTXSL73Pm"

# Read each line (ID) from the ids.txt file and send DELETE request
while IFS= read -r id; do
    # Make DELETE request to Cloudflare API for each ID
    response=$(curl --location --request DELETE "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$id" \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $auth_token")
    
    # Check if the deletion was successful
    if echo "$response" | grep -q '"success":true'; then
        echo "Successfully deleted record with ID: $id"
    else
        echo "Failed to delete record with ID: $id"
        echo "Response: $response"
    fi
done < ids.txt

