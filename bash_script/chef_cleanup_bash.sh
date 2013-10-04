#!/bin/bash

chef_path="${HOME}/Projects/chef"
knife="/usr/bin/knife"
seconds=${1:-"86400"}
counter=0

cd ${chef_path}

for node in $(${knife} node list | grep i-) ; do 
	delta=$(echo $(date +%s)-$(${knife} node show ${node} -a ohai_time | grep -v ^i- |  awk '{print $2}' | awk -F'.' '{print $1}') | bc)
	
	if [ "${delta}" -gt "${seconds}" ]; then 
		echo "PURGE ${node} : time = ${delta}"
	else 
		echo "KEEP  ${node} : time = ${delta}"
	fi ; done | grep ^PURGE | while read list ; do 
	id="$(echo $list | awk '{print $2}')" 
	
	let counter=$counter+1
	echo "Node and client pair ${id} is ${delta} too old, destroying." 
	${knife} node delete -y ${id} ; ${knife} client delete -y ${id}
done
echo "Node and Client cleanup complete. $counter Nodes cleaned."
