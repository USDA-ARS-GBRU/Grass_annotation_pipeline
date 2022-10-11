#!/bin/bash

module load singularity
module load cufflinks
module load genometools
module load seqtk

#run genometools to get cleaned version of gtf file
gt gtf_to_gff3 -tidy -o augustus.hints-clean.gff3 augustus.hints.gtf

#run cufflinks with clean gff
gffread augustus.hints-clean.gff3 -g /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -x augustus.hints.CDS.fasta

#run tesorter
TEsorter -p 20 -db rexdb-plant augustus.hints.CDS.fasta

awk 'NR!=1 {print $1}' augustus.hints.CDS.fasta.rexdb-plant.cls.tsv > augustus.hints.CDS.fasta.rexdb-plant.cls.list
    ##get list of genes that are TEs

grep '^>' augustus.hints.CDS.fasta | awk '{print $1}' | sed 's/^>//' > augustus.hints.CDS.list
    ##get complete list of genes from BRAKER

cat *.list | sort | uniq -c > counts
    ##combine the two list - now if there is a 2 in front of a gene name that means it is a TE gene

awk '{if ($1 == 1) print $2}' counts > augustus.hints.CDS.TE_FILTERED.list
    ##extract the gene names that just have a 1 in front of it



seqtk subseq augustus.hints.CDS.fasta augustus.hints.CDS.TE_FILTERED.list > augustus.hints.CDS.TE_FILTERED.fasta


grep '^>' augustus.hints.CDS.TE_FILTERED.fasta | awk -v OFS="\t" '{print $1,$2 }' | sed 's/gene=//; s/^>//' > list
singularity exec mikado.sif mikado util grep list augustus.hints-clean.gff3 > augustus.hints.clean.TE_FILTERED.gff3
