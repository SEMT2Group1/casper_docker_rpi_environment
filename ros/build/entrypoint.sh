#!/bin/bash
set -e

INDIGO=/opt/ros/indigo
SRC=/src/ros/

if [ "$1" == "buildrun" ]; then
	cd $INDIGO && source setup.sh
	cd $SRC && make
	if [ ! -f $SRC/build/lidarserver ]; then
		echo "build failed..."
		exit 1
	fi	
	exec $SRC/build/lidarserver
	
elif [ "$1" == "run" ]; then
	if [ ! -f $SRC/build/lidarserver ]; then
		echo "no executable present..."
		exit 1
	fi
	exec $SRC/build/lidarserver
fi
exec bash
#exec "$@"