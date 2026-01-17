#!/usr/bin/env bash

PROJECT_PATH="$HOME/D/orion-services/experience/api"

pnpm -C "$PROJECT_PATH" openapi

APIDOG_PROJECT_ID=815821
OPENAPI_SPEC_PATH="$PROJECT_PATH/generated/openapi.json"

if [ ! -f "$OPENAPI_SPEC_PATH" ]; then
	echo "Error: File '$OPENAPI_SPEC_PATH' not found"
	exit 1
fi

echo "Uploading OpenAPI spec to Apidog from: $OPENAPI_SPEC_PATH"

# Build the complete JSON payload using jq
PAYLOAD=$(jq -n \
	--arg input "$(cat "$OPENAPI_SPEC_PATH" | jq -c '.')" \
	'{
	input: $input,
	options: {
		endpointOverwriteBehavior: "AUTO_MERGE",
		schemaOverwriteBehavior: "OVERWRITE_EXISTING"
	}
	}')

RESPONSE=$(curl --http1.1 --location -g --request POST "https://api.apidog.com/v1/projects/$APIDOG_PROJECT_ID/import-openapi?locale=en-US" \
	--header 'X-Apidog-Api-Version: 2024-03-28' \
	--header "Authorization: Bearer $APIDOG_TOKEN" \
	--header 'Content-Type: application/json' \
	--data "$PAYLOAD" \
	--write-out "\n%{http_code}")

HTTP_STATUS=$(echo "$RESPONSE" | tail -n 1)
RESPONSE_BODY=$(echo "$RESPONSE" | head -n -1)

echo "$RESPONSE_BODY"

if [[ "$HTTP_STATUS" =~ ^2[0-9][0-9]$ ]]; then
	echo "OpenAPI spec successfully uploaded to Apidog"
else
	echo "Failed to upload OpenAPI spec to Apidog (HTTP $HTTP_STATUS)"
	exit 1
fi