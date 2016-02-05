#!/bin/sh

set -e
set -x

clean_exit () {
	kill ${PID_OF_MEMCACHE}
	sleep 1
}

wait_for_line () {
	while read line ; do
		echo "$line" | grep -q "$1" && break
	done < "$2"
	# Read the fifo for ever otherwise process would block
	cat "$2" >/dev/null &
}

trap clean_exit EXIT
/usr/bin/memcached -m 64 -p 11212 -u memcache -l 127.0.0.1 & PID_OF_MEMCACHE=$!
sleep 2

$@
