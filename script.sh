!/usr/bin/env bash

# JSONNET_PATH=grafonnet-lib \
#   jsonnet dashboard.jsonnet > dashboard.json

# JSONNET_PATH=grafonnet-lib \
#   jsonnet jvm.jsonnet > jvm.json

  # JSONNET_PATH=grafonnet-lib \
  # jsonnet server_pending.jsonnet > server_pending.json

  JSONNET_PATH=grafonnet-lib \
  jsonnet temp.jsonnet 


payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"



curl -X POST $BASIC_AUTH \
  -H 'Content-Type: application/json' \
  -d "${payload}" \
  "http://admin:admin@localhost:3000/api/dashboards/db"