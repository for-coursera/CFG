#!/bin/sh
if [[ $HOSTNAME == *local ]]
then
    echo "LOCAL"
elif [[ $HOSTNAME == VLN* ]]
then
   echo "THEIRS"
else
    echo "NOT LOCAL, NOT THEIRS"
fi
