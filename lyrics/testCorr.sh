#!/bin/sh
FILES=${1}*
mkdir /tmp/test/
for FILE1 in $FILES
do
    for FILE2 in $FILES
    do
        cp ${FILE1} /tmp/test/
        cp ${FILE2} /tmp/test/
        tar cvzf test.tar.gz /tmp/test/
        FILESIZE=$(stat -c%s "test.tar.gz")
        echo "combination($FILE1,$FILE2,${FILESIZE})" >> testCorr.txt
        rm test.tar.gz
        rm /tmp/test/*
    done
done
        
