#!bin/bash

set -e
user="sdcaglar";
repos=$(curl -s "https://api.github.com/users/$user/repos" | grep -o 'git@[^"]*')
path="/Users/sedacaglar/Desktop/github"

mkdir -p $path
cd $path

echo "################ create all repos under this path: $path ################"
for repo in $repos
do
    echo "################ creating this $repo ################"
    git clone $repo
done

