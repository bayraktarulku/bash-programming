#!/bin/bash

DEFAULT_ROUTE=$(ip route | egrep '^default ' | head -n1)
PUBLIC_INTERFACE=${DEFAULT_ROUTE##*dev }
PUBLIC_INTERFACE=${PUBLIC_INTERFACE/% */}

# MAC ADDR
REMOTE_MAC=$(ip addr show $PUBLIC_INTERFACE | \
            sed -nre 's@.*link\/ether (\S+).*@\1@p')

echo $REMOTE_MAC
