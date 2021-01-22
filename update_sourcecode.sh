#!/bin/bash

sourcecode_folders=(
  "/home/hsowan/go/src/github.com/bangwork"
  "/home/hsowan/workspace/ones"
)

for sourcecode_folder in ${sourcecode_folders[@]};do
  sub_folders=`ls ${sourcecode_folder}`
  for sub_folder in ${sub_folders[@]};do
    folder="${sourcecode_folder}/${sub_folder}"
    if [ ! -d ${folder} ];then
      echo "Not a directory: ${folder}"
      continue
    fi
    cd ${folder}
    if [ ! -d .git ];then
      echo "Not a git repository: ${folder}"
    fi
    echo "Update sourcecode: ${folder}"
    git fetch
  done
done
