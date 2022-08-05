#!/bin/bash

for i in {1..10};
do
    declare foo_$i=$i
done

echo $foo_2
echo $foo_8
