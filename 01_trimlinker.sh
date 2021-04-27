path=`pwd`
mkdir trim_out
for i in `ls *R1.fq*|cut -d _ -f1-2`;
do 
# trimLinker from ChIA-PET2 
trimLinker -t 30 -m 1 -t 25 -k 2 -e 1 -l 15 -n ${j}  -A ACGCGATATCTTATC -B AGTCAGATAAGATAT -o $path/trim_out $path/${i}_R1.fq.gz $path/${i}_R2.fq.gz;

done
