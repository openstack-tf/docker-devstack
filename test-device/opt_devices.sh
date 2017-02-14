#/bin/sh

TOKEN=`cat ./token`
echo "token: $TOKEN"

echo "response:"
case $1 in
    list )
        curl -sX GET http://127.0.0.1:9009/v1/device -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" | jq
        ;;
    new )
        curl -sX POST http://127.0.0.1:9009/v1/device -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" -d '{"name": "device-001", "active": 1, "dataReady":0, "blockChainID":"block chain id", "dataExternal":"external data", "dataModel":"data model id"}' | jq
        ;;
    update )
        NAME=$2
        curl -sX PUT http://127.0.0.1:9009/v1/device/$NAME -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" -d '{"name": "device-998", "dataReady":1}' | jq
        ;;
    detail )
        NAME=$2
        curl -sX GET http://127.0.0.1:9009/v1/device/$NAME -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" | jq
        ;;
    del )
        NAME=$2
        curl -sX DELETE -H "X-Auth-Token: $TOKEN" http://127.0.0.1:9009/v1/device/$NAME | jq
        ;;
    * )
        echo "Usage:"
    echo "./opt_devices.sh {list | new | update DEVICE_ID | detail DEVICE_ID | del DEVICE_ID}"
        echo ""
        exit 1
        ;;
esac
echo ""
