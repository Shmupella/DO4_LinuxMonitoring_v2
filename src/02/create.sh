#!/bin/bash

free_memory_kb=$(df / | awk 'NR==2{print $4}')
free_memory_mb=$(echo "$free_memory_kb 1024" | awk '{printf "%.0f", $1 / $2}')
date=_$(date +"%d%m%y")

max_file_length=248
ex_letters=$(echo $2| awk -F . '{print $2}')

root_dir=$1
root_file=$(echo $2| awk -F . '{print $1}')

count_d=11 #change 100!!
count_f=$(( $RANDOM % 5 + 1 ))
# find / -type d | sed '/bin/d' > path_dir #make path_file CHECK IT! BE CARIFULL!!!
count_path=$(awk 'END{print NR}' path_dir)



creation_directory_with_files() {
    if [[ ${#root_dir} < 5 ]] #основа имени директории, не менее 5 символов
    then
        for (( i = ${#root_dir}; i < 5; i++ ))
        do
            root_dir="${dir_letters:0:1}$root_dir"
        done
    fi

    if [[ ${#root_file} < 5 ]]  #основа имени файлов, не менее 5 символов
    then
        for (( i = ${#root_file}; i < 5; i++ ))
        do
            root_file="${file_letters:0:1}$root_file"
        done
    fi

    for (( num_path_d=1; num_path_d <= count_path; num_path_d++ ))
    do
        for (( letter_num=0, dir_count = 0 ; $dir_count < $count_d; letter_num++)) #цикл, чтобы бежать по буквам, заданным для директории
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
                    # echo "$(awk 'NR == '$x' {print $1}' path_dir)/$dir_name$date"
                    mkdir "$(awk 'NR == '$num_path_d' {print $1}' path_dir)/$dir_name$date"
                    count_f=$(( $RANDOM % 5 + 1 ))
                
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
                                # echo "$(awk 'NR == '$x' {print $1}' path_dir)/$dir_name$date/$file_name.$ex_letters"
                                fallocate -l $num_size "$(awk 'NR == '$num_path_d' {print $1}' path_dir)/$dir_name$date/$file_name.$ex_letters" #создание файла
                            done
                done
            done
        done
    done
}