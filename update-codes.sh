#!/bin/sh
pull_cmd='git pull origin'
origin_dir=`pwd`
pull_origin()
{
    cd $1
    echo " ====>>>>>>>>>>>>>> entering ${1}"
    echo $pull_cmd
    $pull_cmd
    echo " <<<<<<<<<<<<<<==== leaving ${1}"
    cd $origin_dir
    echo ''
}

for sub_dir in deps/*;
do
    pull_origin $sub_dir
done
cd $origin_dir

echo $pull_cmd
$pull_cmd

echo ./rebar co
./rebar co
