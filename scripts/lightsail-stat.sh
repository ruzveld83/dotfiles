#!/usr/bin/env bash

set -euo pipefail

let now=$(date +%s)
let month=31*24*3600
let day=24*3600
let month_ago=now-month

log () {
  echo $1
  echo -n 'Total for last month: '
  aws lightsail get-instance-metric-data --instance-name Debian-DE --metric-name $1 --period $month --start-time $month_ago --end-time $now --unit Bytes --statistics Sum | jq -r '.metricData[0] | "\(.sum/1024/1024/1024 | . * 100 | round | . / 100) GB"'
  echo "Days breakdown:"
  aws lightsail get-instance-metric-data --instance-name Debian-DE --metric-name $1 --period $day --start-time $month_ago --end-time $now --unit Bytes --statistics Sum | jq -r '.metricData[] | "\(.timestamp[:10])   \(.sum/1024/1024/1024 | . * 100 | round | . / 100)"' | sort
}

log "NetworkIn"
echo
log "NetworkOut"
