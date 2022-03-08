#!/bin/bash

# Method 1: Using <<comment

x=6

<<comment
The following script calculates
the square value of the number, 6.
comment

((area=x*x))
echo "$x x $x = $area"

# Method 2: Using  : ‘ 

: '
The following script calculates
if less than 10.
'

if [[ $x -le 10 ]];then
    echo "$x less than 10"
fi
