#!/bin/bash
while :
do
  nvidia-smi -pl 53
  sleep $(( $1 * 2 ))
done
