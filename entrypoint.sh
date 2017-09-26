#!/bin/sh

set -e
set -x

if [ ! "$1" ]; then
    exec /bin/sh
fi

#for fio_test in $(find /fio/*); do
#    echo $fio_test
#    
#    fio \
#     --directory=$1 \
#     --output-format=json \
#     $fio_test
#done

exec "$@"
