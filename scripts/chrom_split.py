import sys
from collections import defaultdict
import gzip
import re
import pickle

chrom_list = sys.argv[1].split(",") 
filenam_prefix = sys.argv[2]
# I will have to make sure that all files are created - even lines 
fp_dict  = {} 
chrom_flag = defaultdict(lambda : False)
for i in chrom_list:
    fname = filenam_prefix + "_chrom_" + i + ".bed"
    tmp_fp = open(fname, "w") 
    fp_dict[i] = tmp_fp
    chrom_flag[i] = True
for line in sys.stdin:
    chrom_name = line [0: line.find("\t")]
    if chrom_flag[chrom_name] == True:
        fp_dict[chrom_name].write(line)
for i in chrom_list:
    fp_dict[i].close()
