#!/bin/bash
yc compute instance create \
  --name reddit-test01 \
  --hostname reddit-test01 \
  --memory=2 \
  --create-boot-disk image-folder-id="b1gaitl24uq20bhcooso",image-family=reddit-base,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yaml \

