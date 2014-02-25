#!/bin/bash

echo "Spawned BTC Parsing Loop."

remove_lock() {
	rm -f $LOCK_FILE
}

# Ctrl-C trap. Catches INT signal
trap "remove_lock 1 $$; exit 0" EXIT

APPDIR=`pwd`
DATADIR="/var/lib/omniwallet/btc"
LOCK_FILE=$DATADIR/btc_cron.lock

mkdir -p $DATADIR

while true
do

	# check lock (not to run multiple times)
	if [ ! -f $LOCK_FILE ]; then

		# lock
		touch $LOCK_FILE

		cd $DATADIR

		# Actually doing the work here.

		touch $DATADIR/BTC_PARSED.log
	
		# unlock
		rm -f $LOCK_FILE
	fi

	# Wait a minute, and do it all again.
	sleep 60
done
