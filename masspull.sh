#!bin/bash

# pull all repos under ~/github/

for repo in ~/github/*
do
    echo "################ pulling this $repo ################"
    cd $repo
    git pull
done

cd ~/github

