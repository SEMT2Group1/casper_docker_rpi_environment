#!/bin/bash


cd $(dirname $0)
BASEDIR="${PWD}"
VOL=/home/data/casper/c++/p0015
RESTVOL="/home/data/casper/python/p0006"
CPPVOL=/home/data/casper/c++/p0010
MOUNT=/home/builder/catkin_ws/src/casper_lidar_scanner_driver
RESTMOUNT=/home/builder/src/restful
CPPMOUNT=/home/builder/src/cpp



if [ "$#" == 0 ]; then 
	echo "no params, cmd=bash"
	PAR=bash
else
	echo "par is $1"
	PAR=$1
fi
USBDIR=/dev/ttyUSB0
USBMOUNT=/dev/ttyUSB0

DBDIR=/home/data/db.db
DBMOUNT=/home/builder/db.db

docker stop rosrpitest && docker rm rosrpitest
echo "running: docker run -d --name rosrpitest -it -v $VOL:$MOUNT -v $RESTVOL:$RESTMOUNT -v $CPPVOL:$CPPMOUNT --device=$USBDIR:$USBMOUNT \
-v $DBDIR:$DBMOUNT -p 9999:9999/udp -p 6000:6000/udp -p 9998:9998/udp -p 10000:10000 casper/ros $PAR"
#docker run -d --name rosrpitest -it -v $VOL:$MOUNT casper/ros $
docker run --name rosrpitest -it -v $VOL:$MOUNT -v $RESTVOL:$RESTMOUNT -v $CPPVOL:$CPPMOUNT --device=$USBDIR:$USBMOUNT \
-v $DBDIR:$DBMOUNT -p 9999:9999/udp -p 6000:6000/udp -p 9998:9998/udp -p 10000:10000 casper/ros $PAR
#docker exec --user root rosrpitest /bin/sh -c "source /opt/ros/indigo/setup.sh;"
docker exec -d -it --user builder rosrpitest bash -v /runRest.sh 
sleep 2
docker exec -d -it --user builder rosrpitest bash -v /runScore.sh 
sleep 2
docker exec -d -it --user builder rosrpitest bash -v /buildLidar.sh
sleep 2
docker exec -it --user builder rosrpitest bash -v /runSlam.sh 
sleep 2
#docker exec -it --user builder rosrpitest bash -v /buildLidar.sh
sleep 2
#docker exec -it --user builder rosrpitest bash -v /runVideo.sh
docker exec -it --user builder rosrpitest bash

