#!/bin/bash
# store the whole response with the status at the and
HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X POST --header "Authorization: Basic <Authorization_code>" -F "file=@CI_CD_PROXY.zip" "https://api.enterprise.apigee.com/v1/organizations/<org_name>/apis?action=import&name=CI_CD_DEMO")

# extract the body
HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

# extract the status
HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

# print the body
echo "$HTTP_BODY" > temp.json
REVISION=$( grep -o '"revision" : *"[^"]*"' temp.json | grep -o '"[^"]*"$' | sed 's/"//g')
# example using the status
if [ $HTTP_STATUS -eq 201  ]
        then
        echo "Proxy is uploaded successfully [HTTP status: $HTTP_STATUS]"
        echo "$REVISION"

        else
         exit 1
fi
DEPLOY_HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X POST --header "Content-Type: application/x-www-form-urlencoded" --header "Authorization: Basic <Authorization_code>" "https://api.enterprise.apigee.com/v1/organizations/<org_name>/environments/test/apis/CI_CD_DEMO/revisions/$REVISION/deployments?override=true")
# extract the status
DEPLOY_HTTP_STATUS=$(echo $DEPLOY_HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')
if [ $DEPLOY_HTTP_STATUS -eq 200  ]
        then
        echo "Proxy is deployed successfully [HTTP status: $HTTP_STATUS]"
        else
         exit 1
fi
