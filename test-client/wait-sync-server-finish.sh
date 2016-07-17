#!/bin/bash -x

set -e

waitFile="$1"
cmd="$2"

until test -e $waitFile
do
  >&2 echo "Waiting mirror server to finish sync. Waiting for file [$waitFile]."
  sleep 1
done

>&2 echo "Mirror server finished sync. File [$waitFile] exists."
exec $cmd
echo "Test client OK!"