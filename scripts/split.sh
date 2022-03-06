#!/bin/bash
# $1 : a file containing list of bed files
# $2 : chromosome_names separated by comma  
# $3 : file name prefix

for i in `cat $1`
do
    zcat -f $i 
done | python scripts/chrom_split.py "${2}" $3 
