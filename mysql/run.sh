#!/bin/bash 
#echo "mounting volume: "$VOLUME"/data"
#DATAVOL=$VOLUME"/data"


docker run -p 10080:27017 -p 10081:28017 --name "mysql" \
-v "$VOLUME:/data/db"  \
"$TAG/$DIR" 