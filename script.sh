
# JSONNET_PATH=grafonnet-lib \
#   jsonnet mssql.jsonnet > mssql.json


 JSONNET_PATH=grafonnet-lib \
  jsonnet elk.jsonnet > elk.json


payload="{\"dashboard\": $(jq . elk.json), \"overwrite\": true}"


curl -X POST $BASIC_AUTH \
  -H 'Content-Type: application/json' \
  -d "${payload}" \
  "http://admin:admin@localhost:3000/api/dashboards/db"