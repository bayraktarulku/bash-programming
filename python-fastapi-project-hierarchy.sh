#!bin/bash

echo "What is your fastapi project_name?"
read PROJECT_NAME
path="$HOME/Desktop/$PROJECT_NAME"

folder_name=(app migrations tests app/db app/helper app/models app/models/enums)
file_name=(run.py Makefile requirements.txt alembic.ini README.md
            app/__init__.py app/db/__init__.py app/helper/__init__.py app/models/__init__.py app/models/enums/__init__.py
	    app/base_config.py app/config.py app/db/database.py app/models/enums/base.py)

for i in "${folder_name[@]}"
do
    mkdir -p $path/$i
done
for i in "${file_name[@]}"
do
    touch $path/$i
done
