#!/bin/bash
chromsizes=~/software/HiC-Pro_2.10.0/annotation/chrom_mm10.sizes
binsize=40000
validfile=***/Cleandata/hic-pro_results/hic_results/data/sample/sample_allValidPairs
coolfile=***/Cleandata/cooler/sample_40000.cool
# convert .cooler file
cooler cload pairs -c1 2 -p1 3 -c2 5 -p2 6 $chromsizes:$binsize $validfile $coolfile
# genome bin file
cooltools genome binnify $chromsizes $binsize >mm10_${binsize}_bin.bed
# gc ratio 
cooltools genome gc ./mm10_${binsize}_bin.bed $fastafile >mm10_${binsize}_bin.GC
# compartments calling
cooltools call-compartments $coolfile -o sample_${binsize} --reference-track mm10_${binsize}_bin.GC
# expected matrix
cooltools compute-expected $coolfile -o sample_${binsize}_cis.expected.tsv
# saddle plot
cooltools compute-saddle $coolfile sample_${binsize}.cis.vecs.tsv sample_${binsize}_cis.expected.tsv --strength -o sample_${binsize} --fig pdf --quantiles  --qrange 0.02 0.98



