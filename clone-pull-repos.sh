#!bin/bash
set -e

user="sdcaglar";
repos=$(curl -s "https://api.github.com/users/$user/repos" | grep -o 'git@[^"]*')
path="$HOME/Desktop/github/"

mkdir -p $path
cd $path

echo "################ create all repos under this path: $path ################"
for repo in $repos
do
    folder=`echo $repo | sed 's%^.*/\([^/]*\)\.git$%\1%g'`
    if [ ! -d "$path$folder" ]; then
    	echo "################ creating this $folder ################"
    	git clone $repo
    else
    	echo "################ pulling this $folder ################"
    	cd $folder
	git pull
	cd ..
    fi
done

