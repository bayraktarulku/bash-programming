#!/bin/bash

echo "Total arguments : $#"

i=1;
for arg in "$@" 
do
    echo $i"st argument: $arg";
    i=$((i + 1));
done
