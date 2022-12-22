#!/bin/bash

NETWORK_ID=$(openssl rand -hex 20)

echo '{"networkId":"'"$NETWORK_ID"'"}' > /mnt/QA3/networkId.json
