#!/bin/bash
Path=**/Cleandata
# erythroblast H3K4me3 peak 
active_bed=**/Cleandata/ENCFF339CXH.bed
cd $Path
mkdir homer
for i in `ls *R1.fq*|cut -d _ -f1-2`;
do 
# homer PCA  
awk '{print $1,$2,$3,$4,$5,$6,$7}' OFS='\t' $Path/hic-pro_results/hic_results/data/${i}/${i}_allValidPairs > $Path/homer/${i}_allValidPairs.homer
   makeTagDirectory $Path/homer/${i}.homer/ -format HiCsummary $Path/homer/${i}_allValidPairs.homer
   runHiCpca.pl ${i}_PCA $Path/homer/${i}.homer/ -active $active_bed -res 1000000 -superRes 1000000 -cpu 28
   runHiCpca.pl ${i}_PCA $Path/homer/${i}.homer/ -active $active_bed -res 50000 -cpu 28 ;
done
