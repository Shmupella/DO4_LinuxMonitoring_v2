#!/bin/bash


## крашится на создании большого кол-ва файлов, так как неправильно задано условие перехода на новую букву, имя файла получается больше 255 символов
path_check='^/+'
folder_check='^[A-Za-z]{1,7}$'
# letters_list='^A?a?B?b?C?c?D?d?E?e?F?f?G?g?H?h?I?i?J?j?K?k?L?l?M?m?N?n?O?o?P?p?Q?q?R?r?S?s?T?t?U?u?V?v?W?w?X?x?Y?y?Z?z?$'
file_check='^[A-Za-z]{1,7}\.+[A-Za-z]{1,3}$'
# letters_list='^[A-Za-z]?$'
count_folder='^[1-9]+'
count_file='^[0-9]+$'
size_of_file='^[0-9]+kb|Kb|kib|Kib|KB|kB|KIB$'
file_letters=$(echo $5| awk -F . '{print $1}')
ex_letters=$(echo $5| awk -F . '{print $2}')

free_memory=$(df / | awk 'NR==2{print $4}')
# echo $free_memory
free_memory_mb=$(echo "$free_memory 1024" | awk '{printf "%.0f", $1 / $2}')
# echo $free_memory_mb


dir_letters=$3

# for (( i = 0; i < ${#dir_letters}; i++ ))
# do
#     echo ${dir_letters:$i:1}
# done

date=_$(date +"%d%m%y")
root_dir=$dir_letters
root_file=$file_letters

if [[ ${#dir_letters} < 4 ]]
then
    for (( i = ${#root_dir}; i < 4; i++ ))
    do
        root_dir+=${dir_letters:0:1}
    done
fi


for (( count_dir = 0, j = 0; free_memory_mb > 13084 && count_dir < $2 && j < ${#dir_letters}; j++ ))
do 
    # echo "date=$date"
    dir_name=$root_dir
    # echo "root=$root_dir"
    for (( k = j; free_memory_mb > 13084 && count_dir < $2 && ${#dir_name} < 248; count_dir++))
    do
        # echo "k=$k"
        # echo "file_first=$file_name"
        dir_name+="${dir_letters:$k:1}$date"
        mkdir "$1/$dir_name"
        # echo "file_after=$dir_name"
        dir_name=$(echo $dir_name | sed 's/'$date'//')
        # echo "dir_name=$dir_name"

        if [[ ${#file_letters} < 4 ]]
        then
            for (( i = ${#root_file}; i < 4; i++ ))
            do
                root_file+=${file_letters:0:1}
            done
        fi

        for (( count_file = 0, g = 0; free_memory_mb > 13084 && count_file < $4 && g < ${#file_letters}; g++ ))
        do
            file_name=$root_file
            for (( n = jg; free_memory_mb > 13084 && count_file < $4 && ${#file_name} < 248; count_file++))
            do
                file_name+="${file_letters:$n:1}$date"
                # echo "file_name=$1/$dir_name/$file_name.$ex_letters"
                fallocate -l $6 "$1/$dir_name$date/$file_name.$ex_letters"
                file_name=$(echo $file_name | sed 's/'$date'//') ##reset root_file
                # echo "reset_name=$file_name"
            done
        done
        # echo "dir=$count_dir"
    done
        echo "dir=$count_dir"
done

# echo $root_dir

# if [ $# -ne 6 ]
# then
#     echo "Incorrect input! Run the script using 6 parameters."
#     exit 1

# elif ! [[ $1 =~ $path_check  ]]
# then
#     echo "Incorrect inpit! The first parameter must be an absolute path to directory."
#     exit 2

# elif ! [[ -d $1 ]]
# then
#     echo "Incorrect input! No such directory $1."
#     exit 3

# elif ! [[ -w $1 ]]
# then
#     echo "$1: permissions denied"
#     exit 4

# elif ! [[ $2 =~ $count_folder ]]
# then
#     echo "Incorrect input in the second parameter! Use only numbers and count of folder should be at least 1."
#     exit 5


# elif ! [[ $3 =~ $folder_check ]] ##&& $3 =~ $letter_list
# then
#     echo "Incorrect input in the third parameter! A folder's name must contain only A-Z, a-z not repeat letters and you can use not more 7 letters."
#     exit 6

# elif ! [[ $4 =~ $count_file ]]
# then
#      echo "Incorrect input in the fourth parameter! Use only numbers."
#      exit 7

# elif ! [[ $5 =~ $file_check ]] ##&& $letters_namefile =~ $letters_list && $letters_ex =~ $letters_list
# then
#     echo "Incorrect input in the fifth parameter!"
#     echo "A file\`s name must contain only A-z, a-z letters and you can use not more 7 letters for a name and not more 3 letters for an extension. Letters in a name and in an extension can\`t repeat. Example: sdf.ex"

# elif ! [[ $6 =~ $size_of_file ]]
# then
#     echo "Input error in the sixth parameter! Please, write size of files. Example: 123kb."
#     exit 9
# fi

