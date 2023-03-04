#!/bin/bash

path=$1
count_d=$2
dir_letters=$3
count_f=$4
file_letters=$(echo $5| awk -F . '{print $1}')
ex_letters=$(echo $5| awk -F . '{print $2}')
file_size=$6

free_memory=$(df / | awk 'NR==2{print $4}')
free_memory_mb=$(echo "$free_memory 1024" | awk '{printf "%.0f", $1 / $2}')
date=_$(date +"%d%m%y")

root_dir=$dir_letters
root_file=$file_letters
max_file_length=248

if [[ ${#root_dir} < 4 ]] #основа директории, не менее 4 символов
then
    for (( i = ${#root_dir}; i < 4; i++ ))
    do
        root_dir="${dir_letters:0:1}$root_dir"
    done
fi


if [[ ${#root_file} < 4 ]]  #основа файлов, не менее 4 символов
then
    for (( i = ${#root_file}; i < 4; i++ ))
    do
        root_file="${file_letters:0:1}$root_file"
    done
fi


for (( letter_num=0, dir_count = 0; $dir_count < $count_d; letter_num++ )) #цикл, чтобы бежать по буквам, заданным для директории
do
    dir_name=$root_dir
    index=0
    while [[ ${dir_name:$index:1} != "${dir_letters:$letter_num:1}" ]] #определение индекса в строке, куда нужно вставить букву
        do
            ((index++))
        done

    for ((  ; ${#dir_name} < $max_file_length && $dir_count < $count_d; dir_count++ )) #вставка буквы в название директории
        do
            dir_name="${dir_name:0:$((index+1))}${dir_letters:$letter_num:1}${dir_name:$((index+1)):${#dir_name}}"
            mkdir "$path/$dir_name$date"
            # echo "dir=$path/$dir_name$date" #создание директории

        for (( fletter_num=0, file_count = 0; $file_count < $count_f; fletter_num++ )) #цикл, чтобы бежать по буквам, заданным для файла
        do
            file_name=$root_file
            indx=0
            while [[ ${file_name:$indx:1} != "${file_letters:$fletter_num:1}" ]] #определяем индекса в строке, куда нужно вставить букву
                do
                    ((indx++))
                done
            for ((  ; ${#file_name} < $max_file_length && $file_count < $count_f; file_count++ )) #вставка буквы в название директории
                    do
                        file_name="${file_name:0:$((indx+1))}${file_letters:$fletter_num:1}${file_name:$((indx+1)):${#file_name}}"
                        fallocate -l $file_size "$path/$dir_name$date/$file_name.$ex_letters" #создание файла
                        # echo "file=$path/$dir_name$date/$file_name.$ex_letters"
                    done
        done
    done
done