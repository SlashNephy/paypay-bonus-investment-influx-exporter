#!/bin/ash

set -eu

curl -i -X POST "${INFLUX_ADDR}/query" --data-urlencode "q=CREATE DATABASE ${INFLUX_DB}"

while true
do
    status=`curl -s -X GET "https://otbp-trnelb.onetapbuy.jp/v1/user/assets/expected?BRAND_UNIT_INFO_LIST=%5B%7B%22id%22%3A%2271%22%2C%22profitLossStartD%22%3A%222016%2F02%2F16%22%7D%2C%7B%22id%22%3A%2272%22%2C%22profitLossStartD%22%3A%222016%2F02%2F16%22%7D%5D" -H "Cookie: laravel_session=${LARAVEL_SESSION}" -A "Mozilla/5.0 (iPad; CPU OS 13_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari jp.pay2.app.ios/2.61.0" -H "Accept-Language: ja-jp" -H "Referer: https://otbp-trnelb.onetapbuy.jp/sp/"`
    standard=`echo $status | jq ".OPERATION_INFO_LIST[0].PROFIT_LOSS_INFO.PROFIT_LOSS_RATE | tonumber"`
    challenge=`echo $status | jq ".OPERATION_INFO_LIST[1].PROFIT_LOSS_INFO.PROFIT_LOSS_RATE | tonumber"`
    curl -s -X POST "${INFLUX_ADDR}/write?db=${INFLUX_DB}&precision=s" --data-binary "rate standard=${standard},challenge=${challenge}"

    sleep ${INTERVAL}
done
