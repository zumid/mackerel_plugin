#!/bin/bash

DATE=`date +%s`

PREFIX="df"

result=`df -h | tail -n +2 | grep -v tmp | grep "/dev/"`

while read line
do
	metric=`echo ${line} | awk '{print $5}'` 
	metric=`echo ${metric} | sed -e 's/%//g'`
	name=`echo ${line} | awk '{print $6}' | sed -e 's%/%_%g'` 
	name="${PREFIX}.${name}" 
	echo -e "${name}\t${metric}\t${DATE}"
done << EOF
$result
EOF

