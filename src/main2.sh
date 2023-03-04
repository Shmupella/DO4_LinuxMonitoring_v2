# #!/bin/bash


# ## крашится на создании большого кол-ва файлов, так как неправильно задано условие перехода на новую букву, имя файла получается больше 255 символов
# path_check='^/+'
# dir_check='^[A-Za-z]{1,7}$'
# # letters_list='^A?a?B?b?C?c?D?d?E?e?F?f?G?g?H?h?I?i?J?j?K?k?L?l?M?m?N?n?O?o?P?p?Q?q?R?r?S?s?T?t?U?u?V?v?W?w?X?x?Y?y?Z?z?$'
# file_check='^[A-Za-z]{1,7}\.+[A-Za-z]{1,3}$'
# # letters_list='^[A-Za-z]?$'
# count_dir_check='^[1-9]+'
# count_file_check='^[0-9]+$'
# size_of_file_check='^[0-9]+kb|Kb|kib|Kib|KB|kB|KIB$'
# file_letters=$(echo $5| awk -F . '{print $1}')
# ex_letters=$(echo $5| awk -F . '{print $2}')

# free_memory=$(df / | awk 'NR==2{print $4}')
# free_memory_mb=$(echo "$free_memory 1024" | awk '{printf "%.0f", $1 / $2}')

# dir_letters=$3

# date=_$(date +"%d%m%y")
# root_dir=$dir_letters
# root_file=$file_letters

# if [[ ${#dir_letters} < 4 ]]
# then
#     for (( i = ${#root_dir}; i < 4; i++ ))
#     do
#         root_dir="${dir_letters:0:1}$root_dir"
#     done
# fi
# echo $root_dir


# dir_name=$dir_letters

# if [[ ${#dir_letters} < 4 ]]
# then
#     for (( i = ${#dir_name}; i < 4; i++ ))
#     do
#         dir_name="${dir_letters:0:1}$dir_name"
#     done
# fi
# echo $dir_name


# for (( count_dir_check = 0, j = 0; free_memory_mb > 13084 && count_dir_check < $2 && j < ${#dir_letters}; j++ ))
# do 
#     # echo "date=$date"
#     dir_name=$root_dir
#     # echo "root=$root_dir"
#     for (( k = j; free_memory_mb > 13084 && count_dir_check < $2 && ${#dir_name} < 248; count_dir_check++))
#     do
#         # echo "k=$k"
#         # echo "file_first=$file_name"
#         dir_name+="${dir_letters:$k:1}$date"
#         mkdir "$1/$dir_name"
#         # echo "file_after=$dir_name"
#         dir_name=$(echo $dir_name | sed 's/'$date'//')
#         # echo "dir_name=$dir_name"

#         if [[ ${#file_letters} < 4 ]]
#         then
#             for (( i = ${#root_file}; i < 4; i++ ))
#             do
#                 root_file+=${file_letters:0:1}
#             done
#         fi

#         for (( count_file_check = 0, g = 0; free_memory_mb > 13084 && count_file_check < $4 && g < ${#file_letters}; g++ ))
#         do
#             file_name=$root_file
#             for (( n = g; free_memory_mb > 13084 && count_file_check < $4 && ${#file_name} < 248; count_file_check++))
#             do
#                 file_name+="${file_letters:$n:1}$date"
#                 # echo "file_name=$1/$dir_name/$file_name.$ex_letters"
#                 fallocate -l $6 "$1/$dir_name$date/$file_name.$ex_letters"
#                 file_name=$(echo $file_name | sed 's/'$date'//') ##reset root_file
#                 # echo "reset_name=$file_name"
#             done
#         done
#         # echo "dir=$count_dir_check"
#     done
#         echo "dir=$count_dir_check"
# done

# echo $root_dir



