#!/bin/sh
FILES=${1}*
for FILE1 in $FILES
do
    cp ${FILE1} /tmp/test/
    tar cvzf test.tar.gz /tmp/test/
    FILESIZE=$(stat -c%s "test.tar.gz")
    echo "single($FILE1,${FILESIZE})" >> testSingle.txt
    rm test.tar.gz
    rm /tmp/test/*
done
        
