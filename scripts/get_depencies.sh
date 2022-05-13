#! /usr/bin/bash
poetry export --without-hashes -o ./requirements.txt

while read lib;
do
    pip install "${lib}" --python-version=3.5 --target=./python-lib/ --only-binary=:all: --upgrade
done < ./requirements.txt