#!/bin/bash

##define function
multiplication() {
      return $(($1 * $2))
}

##main body
a=$1
b=$2

multiplication $a $b
ret=$?
echo "multiplied value: $ret"

sh addition.sh $ret



