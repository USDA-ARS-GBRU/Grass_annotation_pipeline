#!/bin/bash

date

export AUGUSTUS_CONFIG_PATH=/project/gbru_grasses/StAug_Raleigh/AUGUSTUS_CONFIG/config

#
#Removed existing memory for shmid 26 at end of file
braker.pl --genome /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked --bam /90daydata/gbru_grasses/01_Raleigh_bothHap_rna.star.2_10_22/Raleigh_bothHap_RNAseqStarAligned_merged.sorted.bam --softmasking --cores 40

date
