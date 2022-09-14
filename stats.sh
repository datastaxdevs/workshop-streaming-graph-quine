curl -s --request GET \
     --url http://localhost:8080/api/v1/ingest \
     --header 'Content-Type: application/json' \
| jq '."INGEST-1".stats'