#!/bin/bash

if [ -d build ]; then
    rm -R build 
fi

# Create clean build directory
mkdir build

# copy all src files into build
cp -R src/* build/

# ./build - Link Librarys into build dir
cd build && ln -s ../../../../../lib/GameQ files/lib/page/util/
# ./build/files - create files.tar
cd files && tar -chf ../files.tar * && cd ..
# ./build/templates - create templates.tar
cd templates && tar -chf ../templates.tar * && cd ..

# ./build/tmp
mkdir tmp && cd tmp
cp ../*.{xml,tar} .

# ./build - create installPackage.tar & back to ./
tar -chf ../installPackage.tar * && cd .. && rm -R tmp && cd ..

