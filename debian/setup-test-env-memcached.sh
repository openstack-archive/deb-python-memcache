#!/bin/sh

set -e
set -x

clean_exit () {
	kill ${PID_OF_MEMCACHE}
	sleep 1
}

trap clean_exit EXIT
/usr/bin/memcached -m 64 -p 11212 -u memcache -l 127.0.0.1 & PID_OF_MEMCACHE=$!
sleep 2

$@
