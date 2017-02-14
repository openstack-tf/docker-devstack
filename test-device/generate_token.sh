#/bin/sh

source keystone_admin

RAW_TOKEN=`curl -s -X POST http://127.0.0.1:5000/v2.0/tokens -H "Content-Type: application/json"  -d '{"auth": {"tenantName": "admin", "passwordCredentials":{"username": "admin", "password": "abcd1234"}}}'`

if [ -n "$RAW_TOKEN" ]; then
    TOKEN=`echo $RAW_TOKEN | python -c "import sys; import json; tok = json.loads(sys.stdin.read()); print tok['access']['token']['id'];"`
    echo "TOKEN: $TOKEN"
    echo "$TOKEN" > ./token
else
    echo "Not Found RAW_TOKEN..."
fi
echo ""
