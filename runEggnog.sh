#!/bin/bash
#SBATCH --job-name="Eggnog" #name of the job submitted
#SBATCH -t 7-00:00:00
#SBATCH -p bigmem #name of the queue to submit job to
#SBATCH -N 1     #number of nodes in this job
#SBATCH -n 40    #number of cores in this job
#SBATCH --mem=800G
#SBATCH -A gbru_grasses
#SBATCH -o "Eggnog_stdout.%j.%N"
#SBATCH -e "Eggnog_stderr.%j.%N"
#SBATCH --mail-user=anschoon@ncsu.edu
#SBATCH --mail-type=BEGIN,END,FAIL


date
export PATH=/home/user/eggnog-mapper:/home/user/eggnog-mapper/eggnogmapper/bin:"$PATH"
export EGGNOG_DATA_DIR=/project/gbru_grasses/Eggnog/eggnog-mapper-data/
#emapper.py -m diamond --itype proteins -i augustus.hints.aa -o emapper --cpu 20

#source activate /project/gbru_grasses/braker2
#export PATH=/home/user/eggnog-mapper:/home/user/eggnog-mapper/eggnogmapper/bin:"$PATH"
#export EGGNOG_DATA_DIR=/project/gbru_grasses/Eggnog/eggnog-mapper-data/
#agat_sp_extract_sequences.pl --gff myfFile.gff -f fastaFile.fa -p -o protein.fa
#agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1FromBothHap.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1FromBothHap.aa
#agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1aFromBothHap.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1aFromBothHap.aa
#agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1aFromBothHap.eggnog.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnog.aa

#emapper.py -m diamond --itype proteins -i augustus.hints.clean.TE_FILTERED.v1FromBothHap.aa -o emapper_v1FromBothHap --cpu 20
#emapper.py -m diamond --itype proteins -i augustus.hints.clean.TE_FILTERED.v1aFromBothHap.aa -o emapper_v1aFromBothHap --cpu 20
#emapper.py -m diamond --itype proteins -i augustus.hints.clean.TE_FILTERED.v1FromBothHap.aa -o emapper_v1FromBothHap_decorategff --cpu 20 --decorate_gff yes
#emapper.py -m diamond --itype proteins -i augustus.hints.clean.TE_FILTERED.v1aFromBothHap.eggnog.aa -o emapper_v1FromBothHap_filteredEggnog --cpu 20



#awk '{print $1}' emapper_v1aFromBothHap.emapper.annotations > emapper_v1aFromBothHap.emapper.annotations.tags.txt
#awk '{print $1}' emapper_v1FromBothHap.emapper.annotations > emapper_v1FromBothHap.emapper.annotations.tags.txt


### DO THIS INSTEAD
#agat_sp_filter_feature_from_keep_list.pl --gff augustus.hints.clean.TE_FILTERED.v1aFromBothHap.gff3 --keep_list emapper_v1aFromBothHap.emapper.annotations.tags.txt --output augustus.hints.clean.TE_FILTERED.v1aFromBothHap.eggnogFiltered.agatseparated.gff3
#agat_sp_filter_feature_from_keep_list.pl --gff augustus.hints.clean.TE_FILTERED.v1FromBothHap.gff3 --keep_list emapper_v1FromBothHap.emapper.annotations.tags.txt --output augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnogFiltered.agatseparated.gff3


#agat filter by size
#agat_sp_filter_gene_by_length.pl --gff augustus.hints.clean.TE_FILTERED.v1FromBothHap.gff3 --test ">=" --size 60 --output augustus.hints.clean.TE_FILTERED.v1FromBothHap.AgatLengthFilter.gff3

#agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnogFiltered.agatseparated.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnogFiltered.agatseparated.aa
agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnogFiltered.agatseparated.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -o augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnogFiltered.agatseparated.faa


date
