#!/bin/bash

OWNER=""
MONTH=""

# ===== User help
help()
{
    echo "  *** HELP ***"
    echo "  The countilnes script accept the following options:"
    echo "  -o <owner>"
    echo "  To select files where the owner is <owner>"
    echo "  -m <month>"
    echo "  To select files where the creation month is <month>"
}

# ====== Script arguments
while getopts ":o:m:" options
do
    case "${options}"
    in
        o) OWNER=${OPTARG};;
        m) MONTH=${OPTARG}
            MONTH=$(echo "$MONTH" | awk '{print tolower($0)}');;
        :) help;;
        *) help;;
    esac
done

# ===== Validate argument
if [[ "$OWNER" != "" && "$MONTH" != "" || "$OWNER" == "" && "$MONTH" == "" ]]; then
    help

# ===== Look for Owner
elif [ "$OWNER" != "" ]; then
    echo "Looking for files where the owner is: $OWNER"
    FILES=$(ls -l | awk '{print $4, $NF}' | grep "$OWNER" | awk '{print $NF}')
    for FILE in $FILES
    do
        echo -n "File: $FILE, Lines: "; wc -l $FILE
    done

# ===== Look for Month
else
    echo "Looking for files where the month is: $MONTH"
    FILES=$(ls -l | awk '{print $6, $NF}' | grep "$MONTH" | awk '{print $NF}')
    for FILE in $FILES
    do
        echo -n "File: $FILE, Lines: "; wc -l $FILE
    done
fi

