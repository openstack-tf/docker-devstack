#/bin/sh

TOKEN=`cat ./token`
echo "token: $TOKEN"

case $1 in
    list )
        curl -sX GET http://127.0.0.1:9009/v1/device -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" | jq
        ;;
    new )
        curl -sX POST http://127.0.0.1:9009/v1/device -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" -d '{"name": "device-001", "dtype":"device-type-001", "vendor": "tongfangcloud", "version": "device-version-001"}' | jq
        ;;
    detail )
        NAME=$2
        curl -sX GET http://127.0.0.1:9009/v1/device/$NAME -H "Content-Type: application/json" -H "X-Auth-Token: $TOKEN" | jq
        ;;
    del )
        NAME=$2
        curl -sX DELETE -H "X-Auth-Token: $TOKEN" http://127.0.0.1:9009/v1/device/$NAME | python -m json.tool
        ;;
    * )
        echo "Usage:"
    echo "./opt_devices.sh {list | new | detail DEVICE_ID | del DEVICE_ID}"
        echo ""
        exit 1
        ;;
esac
