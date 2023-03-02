#!/bin/bash
set -e

# Set variables
USERNAME=$1
PASSWORD=$2
DATABASE=$3
TABLE="service_provider"

# Check if the table already exists
query="SHOW TABLES LIKE '$TABLE';"
result=$(mysql -s -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e "$query")
if [ "$result" == "$TABLE" ]; then
  echo "Table '$TABLE' already exists."
else
  # Create table in database
  query="CREATE TABLE $TABLE (
      id int auto_increment primary key,
      date_created datetime null,
      date_modified datetime null,
      name varchar(256) not null,
      params json null,
      status enum('active', 'passive', 'deleted') not null
  )"
  mysql -s -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e "$query"
fi

# Read service data from JSON file
service_data=$(cat services.json)

# Loop through each service in the JSON data
while read -r service; do
  name=$(echo "$service" | jq -r '.name')
  params=$(echo "$service" |  jq -r '.params' | jq -c '.| to_entries | sort_by(.key) | from_entries')
  status=$(echo "$service" | jq -r '.status')
  date_created=$(date +"%Y-%m-%d %T")
  date_modified=$(date +"%Y-%m-%d %T")

  # Check if service provider already exists
  query="SELECT count(*) FROM $TABLE WHERE name = '$name';"
  count=$(mysql -s -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e "$query")
  if [ $count -eq 0 ];then
    # Insert service provider into database if it doesn't exist
    query="INSERT INTO $TABLE (date_created, date_modified, name, params, status) VALUES ('$date_created', '$date_modified', '$name', '$params', '$status');"
    mysql -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e "$query"
  else
    # Get existing params and status from database
    params_check=$(mysql -s -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e  "SELECT params FROM $TABLE WHERE name = '$name';")
    params_check=$(echo "$params_check" | jq -c '.| to_entries | sort_by(.key) | from_entries')
    status_check=$(mysql -s -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e  "SELECT status FROM $TABLE WHERE name = '$name';")

    if [ "$params" != "$params_check" ] || [ "$status" != "$status_check" ]; then
      query="UPDATE $TABLE SET params = '$params', status = '$status', date_modified = '$date_modified' WHERE name = '$name';"
      mysql -s -u "$USERNAME" -p"$PASSWORD" "$DATABASE" -e "$query"
    fi
  fi
done <<< "$(echo "$service_data" | jq -c '.[]')"
