#!/bin/bash
py=~/miniconda2/envs/hicpro3.0.0/bin/python
sparse2dense=~/software/HiC-Pro/HiC-Pro_3.0.0/bin/utils/sparseToDense.py
bin40kbed=***/hic-pro_results/hic_results/matrix/*/raw/40000/*_40000_abs.bed
matrixfolder=***/Cleandata/hic-pro_results/hic_results/matrix
matrix2insulation=/data1/yangk/software/crane-nature-2015/scripts/matrix2insulation.pl
for i in `ls *R1.fq*|cut -d _ -f1-2`;
do 
# convert HiC-Pro output into dense format
$py $sparse2dense -i -b $bin40kbed $matrixfolder/$i/iced/40000/${i}_40000_iced.matrix --perchr;
done
# insulation
for i in `ls|grep dense.matrix`;
do perl $matrix2insulation -i $i -is 1000000 -ids 200000 -im mean -nt 0.1 -v;
done
cat sample_40000_iced_chr*.boundaries.bed|sed '/name/d'|awk 'BEGIN{OFS="\t"}{print $1,$2,$3,$5 }'| sort -k 1,1 -k 2,2n > sample_TAD.boundary.bed


