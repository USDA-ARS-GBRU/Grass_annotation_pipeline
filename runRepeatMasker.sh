#!/bin/bash

########
#Run on Ceres
########

date
#run repeatmodeler then repeatmasker
module load repeatmodeler/1.0.8
module load repeatmasker/4.1.0

BuildDatabase -name StAug_Raleigh_noUnderscore_v1a ../Stenotaphrum_secundatum_RaleighCultivar_genome_v1a.noUnderscore.fasta -engine ncbi
RepeatModeler -database StAug_Raleigh_noUnderscore_v1a -engine ncbi -pa 48

RepeatMasker -pa 38 -gff -lib RM_215617.TueFeb81940112022/consensi.fa.classified ../Stenotaphrum_secundatum_RaleighCultivar_genome_v1a.noUnderscore.fasta

date
