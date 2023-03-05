#!/bin/bash

. ./check.sh
. ./create.sh

chmod +x check.sh create.sh

path=$1
count_d=$2
dir_letters=$3
count_f=$4
file_letters=$5
file_size=$6
count_param=$#


check $path $count_d $dir_letters $count_f $file_letters $file_size $count_param
creation_directory_with_files
