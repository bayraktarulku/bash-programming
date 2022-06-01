#!/bin/bash
# -----------------------------------------------------------------------------
# AUTHENTICATOR.SH
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# This script generates random password based on current time and key.
# Script will generate the same password for the duration of $duration.
# -----------------------------------------------------------------------------

duration=3600
timestamp=$(date +%s)
key="test"

((seconds = $timestamp % $duration))

((validtime = timestamp - $seconds))

currentpass=`echo -n $validtime$key | md5sum | cut -d " " -f 1`

echo $currentpass
