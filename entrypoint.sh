#!/bin/sh

set -e

if [ ! -z "$CLUSTER_MAPPING" ]; then
    /usr/local/zookeeper/bin/zkServer.sh start
    python /opt/create_cluster_mapping.py
    /usr/local/zookeeper/bin/zkServer.sh stop
fi

exec "$@"
