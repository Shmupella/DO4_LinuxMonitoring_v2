#!/bin/bash

. ./check.sh
. ./create.sh


dir_letters=$1
file_letters=$2
file_size=$3
count_param=$#

chmod +x check.sh create.sh

check $dir_letters $file_letters $file_size $count_param
creation_directory_with_files

find -type d -cmin -20 -ls | awk '{printf "%s %s%s %s\n", $11, $9, $8, $10}' > info.log #create log for directory  #проверить логи, записывается лишнее и будто по времени создания
find -type f -cmin -20 -ls | awk '{printf "%s %s%s %s %sKb\n", $11, $9, $8, $10, $7}' >> info.log #create log for file
