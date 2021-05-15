#!bin/bash

echo "What is your project_name?"
read PROJECT_NAME
path="$HOME/Desktop/$PROJECT_NAME"

folder_name=(templates api static static/js static/css)
file_name=(run.py Makefile config.py requirements.txt
            app/__init__.py app/api/__init__.py app/templates/index.html)

for i in "${folder_name[@]}"
do
    mkdir -p $path/app/$i
done
for i in "${file_name[@]}"
do
    touch $path/$i
done
