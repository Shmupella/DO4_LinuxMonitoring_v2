#!/bin/bash

count_rm_path=$(awk 'END{print NR}' infod.log)
i=1

while [[ $i -le $count_rm_path ]]
do
    path_name=$(awk 'NR == '$i' {print $1}' infod.log)
    sudo rm -vr "$path_name"
    ((i++))
done

rm "path_dir"
