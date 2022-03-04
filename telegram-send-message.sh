#!/bin/bash 

TOKEN_BOT=5260446580:AAF7vB6sLhcAcGqEx3GywSd-o692c9Rx7xU
ID_CHAT=802315307
URL="https://api.telegram.org/bot$TOKEN_BOT/sendMessage"

curl -v -X GET $URL -d chat_id=$ID_CHAT -d text="Test Message"
