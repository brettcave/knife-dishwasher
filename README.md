knife-dishwasher
================

Knife plugin for Chef: Clean up unused/unnecessary nodes and clients

WORK IN PROGRESS. Not ready for use.
If you really need this now, there is a bash script that can loop through your chef nodes.

Usage:
./bash_script/chef_cleanup_bash.sh [seconds]

Please set your chef path in the script before use.
This will loop through your nodes, find any nodes with a check-in time older than [seconds] and delete them, along with any clients of the same name.
If no arguments are presented, it will default to 86400 (24 hours)
