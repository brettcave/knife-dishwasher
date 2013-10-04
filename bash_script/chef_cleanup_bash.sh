#!/bin/bash

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# chef_cleanup_bash.sh 
# Written by Stephen Coetzee for Project https://github.com/stephencoetzee/knife-dishwasher
#
# Usage: ./chef_cleanup_bash.sh [seconds]

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
