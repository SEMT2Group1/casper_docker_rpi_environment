#!/bin/bash

cd $(dirname $0)

DIR=$(basename $1)

TAG=casper

if [ ! -d "$DIR" ] || [ ! -f "$DIR/build/Dockerfile" ] ; then
	echo "Usage: $0 <basedirectory-of-service>"
	exit 1
fi    

# inherit container specific run-configuration?
if [ ! -f "$DIR/run.sh" ]; then
	echo "Missing container specific run script, aborting..."
    exit 1
fi

VOLUME="/home/data/casper/"$TAG"-"$DIR"/data"

echo "Running " $DIR " specific run script.. "
export VOLUME
export TAG
export DIR
. "$DIR/run.sh"

