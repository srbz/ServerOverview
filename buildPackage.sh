#!/bin/bash

if [ -d build ]; then
    rm -R build 
fi

mkdir build
cd src
cd files && tar -cf ../../build/files.tar * && cd ..
cd templates && tar -cf ../../build/templates.tar * && cd ..
cp *.xml ../build/ && cd ..
cd build && tar -cf installPackage.tar * && cd ..
