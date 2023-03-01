# #!/bin/bash

# # Check if all six parameters are provided
# if [ "$#" -ne 6 ]; then
#     echo "Usage: $0 <path> <num_subfolders> <folder_chars> <num_files> <file_chars> <file_size_kb>"
#     exit 1
# fi

# path="$1"
# num_subfolders="$2"
# folder_chars="$3"
# num_files="$4"
# file_chars="$5"
# file_size="$6"

# # Check if path exists and is a directory
# if [ ! -d "$path" ]; then
#     echo "$path does not exist or is not a directory"
#     exit 1
# fi

# # Check if folder_chars and file_chars contain only English alphabet letters
# if [[ ! "$folder_chars" =~ ^[a-zA-Z]+$ || ! "$file_chars" =~ ^[a-zA-Z]+$ ]]; then
#     echo "folder_chars and file_chars must contain only English alphabet letters"
#     exit 1
# fi

# # Check if folder_chars and file_chars have length less than or equal to 7
# if [[ ${#folder_chars} -gt 7 || ${#file_chars} -gt 7 ]]; then
#     echo "folder_chars and file_chars must have length less than or equal to 7"
#     exit 1
# fi

# # Check if file_size is less than or equal to 100
# # if [ "$file_size" -gt 100 ]; then
# #     echo "file_size must be less than or equal to 100 KB"
# #     exit 1
# # fi

# # Check if there is at least 1GB of free space left on the file system
# if [ "$(df -k / | awk '{print $4}' | tail -n 1)" -lt 1000000 ]; then
#     echo "There is less than 1GB of free space left on the file system"
#     exit 1
# fi

# # Create folders and files
# for ((i=1; i<=$num_subfolders; i++)); do
#     folder_name=$(echo $folder_chars | fold -w1 | shuf | tr -d '\n')
#     folder_path="$path/$folder_name$(date +%d%m%y)"
#     mkdir -p "$folder_path"
#     for ((j=1; j<=$num_files; j++)); do
#         file_name=$(echo $file_chars | fold -w1 | shuf | tr -d '\n')
#         file_ext=$(echo $file_chars | fold -w1 | shuf | tr -d '\n' | head -c 3)
#         file_path="$folder_path/$file_name$(date +%d%m%y)_$j.$file_ext"
#         dd if=/dev/urandom of="$file_path" bs=1024 count="$file_size" >/dev/null 2>&1
#         if [ "$(df -k / | awk '{print $4}' | tail -n 1)" -lt 1000000 ]; then
#             echo "There is less than 1GB of free space left on the file system"
#             exit 1
#         fi
#     done
# done



#!/bin/bash

# Check if all six parameters are provided
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <path> <num_subfolders> <folder_chars> <num_files> <file_chars> <file_size_kb>"
    exit 1
fi

path="$1"
num_subfolders="$2"
folder_chars="$3"
num_files="$4"
file_chars="$5"
file_size="$6"

# Check if path exists and is a directory
if [ ! -d "$path" ]; then
    echo "$path does not exist or is not a directory"
    exit 1
fi

# Check if folder_chars and file_chars contain only English alphabet letters
if [[ ! "$folder_chars" =~ ^[a-zA-Z]+$ || ! "$file_chars" =~ ^[a-zA-Z]+$ ]]; then
    echo "folder_chars and file_chars must contain only English alphabet letters"
    exit 1
fi

# Check if folder_chars and file_chars have length less than or equal to 7
if [[ ${#folder_chars} -gt 7 || ${#file_chars} -gt 7 ]]; then
    echo "folder_chars and file_chars must have length less than or equal to 7"
    exit 1
fi

# Check if file_size is less than or equal to 100
if [ "$file_size" -gt 100 ]; then
    echo "file_size must be less than or equal to 100 KB"
    exit 1
fi

# Check if there is at least 1GB of free space left on the file system
if [ "$(df -k / | awk '{print $4}' | tail -n 1)" -lt 1000000 ]; then
    echo "There is less than 1GB of free space left on the file system"
    exit 1
fi

# Create folders and files
for ((i=1; i<=$num_subfolders; i++)); do
    folder_name=$(echo $folder_chars | fold -w1 | shuf | tr -d '\n')
    folder_path="$path/$folder_name$(date +%d%m%y)"
    mkdir -p "$folder_path"
    for ((j=1; j<=$num_files; j++)); do
        file_name=$(echo $file_chars | fold -w1 | shuf | tr -d '\n')
        file_ext=$(echo $file_chars | fold -w1 | shuf | tr -d '\n' | head -c 3)
        file_path="$folder_path/$file_name$(date +%d%m%y)_$j.$file_ext"
        dd if=/dev/urandom of="$file_path" bs=1024 count="$file_size" >/dev/null 2>&1
        if [ "$(df -k / | awk '{print $4}' | tail -n 1)" -lt 1000000 ]; then
            echo "There is less than 1GB of free space left on the file system"
            exit 1
        fi
    done
done
