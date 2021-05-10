#!/bin/bash

DEFAULT_ROUTE=$(ip route | egrep '^default ' | head -n1)
PUBLIC_INTERFACE=${DEFAULT_ROUTE##*dev }
PUBLIC_INTERFACE=${PUBLIC_INTERFACE/% */}

# IP ADDR
REMOTE_IP=$(ip addr show $PUBLIC_INTERFACE | \
            ack "inet .* dynamic .*$PUBLIC_INTERFACE( |$)" | \
            awk '{print $2}' | cut -d "/" -f1)

echo $REMOTE_IP
