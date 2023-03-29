#!/bin/bash


# добавить проверки на корректность ввода: параметр только один и это цифра от 1 до 3. И сопоставление вводимых с клавы данных с регуляркой
date=$(date +"%d%m%y")

if [[ $1 -eq 1 ]] #удаление по лог файлу
then
    count_rm_path=$(awk 'END{print NR}' ../02/infod.log)
    i=1
    while [[ $i -le $count_rm_path ]]
    do
        path_name=$(awk 'NR == '$i' {print $1}' ../02/infod.log)
        sudo rm -vr "$path_name"
        ((i++))
    done

elif [[ $1 -eq 2 ]] #удаление по точному промежутку времени
then
    start_date=0
    start_time=0
    end_date=0
    end_time=0
    echo "Please, enter the start of time interval - date and time (up to the minute) for deleting files. You should use this format:YYYY-MM-DD HH:MM:SS"
    read start_date start_time
    echo "Please, enter the end of time interval - date and time (up to the minute) for deleting files. You should use this format:YYYY-MM-DD HH:MM:SS"
    read end_date end_time
    echo $start_date $start_time $end_date $end_time

    sudo find / -type d -name "*_$date" -newermt "$start_date $start_time" ! -newermt "$end_date $end_time" -exec rm -rv '{}' \;
elif [[ $1 -eq 3 ]] #удаление по маске имени
then
    sudo find / -type d -name "*_$date" -exec rm -rv '{}' \;
fi

# sudo ls / -l - отобразить полную информацию, где будет время и дата.