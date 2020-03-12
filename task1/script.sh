#!/bin/bash
filepath=$1

# get list of users based on sample logfile pattern
users=($(cat $filepath | grep -Po '(?<=sudo:\s{5}).*(?=\s:)' | uniq -u))

for user in "${users[@]}"
do
    commands="$(cat $filepath | grep $user | grep -Po '(?<=COMMAND\=).*')"
    most_used_command=$(echo "$commands" | sort | uniq -c | sort -nr | head -1 | cut -c 9-)
    echo $user: $most_used_command
done