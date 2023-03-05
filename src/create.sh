#!/bin/bash

free_memory_kb=$(df / | awk 'NR==2{print $4}')
free_memory_mb=$(echo "$free_memory_kb 1024" | awk '{printf "%.0f", $1 / $2}')
date=_$(date +"%d%m%y")
dir_letters=$(echo $5| awk -F . '{print $1}')

max_file_length=248
ex_letters=$(echo $5| awk -F . '{print $2}')
root_dir=$3
root_file=$(echo $5| awk -F . '{print $1}')

creation_directory_with_files() {
    if [[ ${#root_dir} < 4 ]] #основа имени директории, не менее 4 символов
    then
        for (( i = ${#root_dir}; i < 4; i++ ))
        do
            root_dir="${dir_letters:0:1}$root_dir"
        done
    fi

    if [[ ${#root_file} < 4 ]]  #основа имени файлов, не менее 4 символов
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

    for ((  ; $free_memory_mb > 1024 && ${#dir_name} < $max_file_length && $dir_count < $count_d; dir_count++ )) #вставка буквы в название директории
        do
            dir_name="${dir_name:0:$((index+1))}${dir_letters:$letter_num:1}${dir_name:$((index+1)):${#dir_name}}" #создание директории
            mkdir "$path/$dir_name$date"

        for (( fletter_num=0, file_count = 0; $file_count < $count_f; fletter_num++ )) #цикл, чтобы бежать по буквам, заданным для файла
        do
            file_name=$root_file
            indx=0
            while [[ ${file_name:$indx:1} != "${file_letters:$fletter_num:1}" ]] #определяем индекса в строке, куда нужно вставить букву
                do
                    ((indx++))
                done
            for ((  ; $free_memory_mb > 1024 && ${#file_name} < $max_file_length && $file_count < $count_f; file_count++ )) #вставка буквы в название директории
                    do
                        file_name="${file_name:0:$((indx+1))}${file_letters:$fletter_num:1}${file_name:$((indx+1)):${#file_name}}"
                        fallocate -l $num_size "$path/$dir_name$date/$file_name.$ex_letters" #создание файла
                    done
        done
    done
done
}