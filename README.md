# paypay-bonus-investment-influx-exporter
🔌 A tiny tool to export PayPay Bonus investment metrics

Demo -> [dashboard.starry.blue](https://dashboard.starry.blue/d/q0ujosPGk/paypay?orgId=1&refresh=10s)

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/slashnephy/paypay-bonus-investment-influx-exporter/latest)](https://hub.docker.com/r/slashnephy/paypay-bonus-investment-influx-exporter)

`docker-compose.yml`

```yaml
version: '3.8'

services:
  influxdb:
    container_name: InfluxDB
    image: influxdb
    restart: always
    volumes:
      - influxdb:/var/lib/influxdb

  paypay-bonus-investment-exporter:
    container_name: paypay-bonus-investment-exporter
    image: slashnephy/paypay-bonus-investment-influx-exporter:latest
    restart: always
    environment:
      # メトリックの取得間隔 (秒)
      INTERVAL: 60
      # InfluxDB アドレス
      INFLUX_ADDR: http://influxdb:8086
      # InfluxDB データベース名
      INFLUX_DB: paypay

volumes:
  influxdb:
    local: driver
```
