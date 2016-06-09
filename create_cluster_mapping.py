#!/usr/bin/env python
# -*- coding: utf-8 -*-

from zk import ArcusZooKeeper
import json
import os
import sys

def get_server_dict(ip, port):
    return {'ip': ip, 'config': {'port': port}}

def parse_cluster_mapping(cs):
    ca = cs.split(';')
    cd = dict(zip(ca[0::2], ca[1::2]))
    return {k: map(lambda x: get_server_dict(x.split(':')[0], x.split(':')[1]), v.split(',')) for k, v in cd.items()}

def build_clusters(cm):
    config = {'threads': 6, 'memlimit': 100, 'connections': 1000}
    return [{'serviceCode': k, 'servers': v, 'config': config} for k, v in cm.items()]

zk_addr = os.getenv('ZK_HOST', 'localhost') + ':' + os.getenv('ZK_PORT', '2181')
client = ArcusZooKeeper(zk_addr, 15000)
client.start()

client.init_structure()

cluster_mapping_s = os.getenv('CLUSTER_MAPPING')
clusters = build_clusters(parse_cluster_mapping(cluster_mapping_s))
for cluster in clusters:
    client.update_service_code(cluster)

client.stop()
