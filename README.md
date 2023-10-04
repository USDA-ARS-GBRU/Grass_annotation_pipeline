# Annotation Steps for Grasses


## Step 1: Process RNA-Seq Files

Following the steps given here: https://github.com/PeanutBase/BIND_annotation

# Run FastQC
```
module load fastqc/0.11.9

cd /project/gbru_grasses/bermuda/Raw_Data/RNA-Seq/

#run fastqc on all samples
for f in *.gz; do fastqc $f; done
```
# Trim Adapters

Check for PE adapters using trimmomatic

Trim reads using trim-galore
```
conda create --prefix /project/gbru_grasses/annotation
conda activate /project/gbru_grasses/annotation
conda install -c bioconda trim-galore

#do for all paired samples
trim_galore --paired Leaf-1_R1_001.fastq.gz Leaf-1_R2_001.fastq.gz
```

cat reads together



## Step 2: Masking the genome

Note:  RepeatMasker and RepeatModeler had to be run on Ceres  -  both seem to run much slower on Atlas

Cat both haplotypes of the genome together.

# Run RepeatModeler on the full genome file.
```

#BuildDatabase -name Bermuda_bothHap /project/gbru_grasses/bermuda/Cyntrans_genome_bothHaplotypes.fasta -engine ncbi

#RepeatModeler -database Bermuda_bothHap -engine ncbi -pa 48
```

# Run RepeatMasker
```

```


## Step 3: Align Reads to the Reference Genome

align reads to genome using Star

Gmap was also used but the file it produced was extremely large and did not seem to change the alignments nor the results much

## Step 3.2: Trinity

use trinity to 
Note: with the number of RNA-seq samples I had, Trinity did not run well on Atlas.  Atlas appeared to run into memory errors.  Even subsetting the data into tissue and control types exceeded the memory available even in the high mem nodes.  Moving over to ceres fixed the issue.

```
module load trinityrnaseq
module list

Trinity --seqType fq \
--left StAug_Raleigh_Leaf_filtered_read1.fq.gz \
--right StAug_Raleigh_Leaf_filtered_read2.fq.gz \
--max_memory 750G
```

Trinity has tends to insert copies of some smaller transcripts.  We ran Cd-Hits to remove any extra copies with 100% idenity.

```
cd-hit -i trinity_out_dir.Trinity.fasta -o trinity_out_dir.Trinity.cdhit100.fasta -c 1.00 -n 5 -M 200000 -d 0 -T 24
```

## Step 4: Run Braker2 and 3

include notes to set up braker?

# Setting up Braker2
```
module load singularity
module load miniconda
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

conda create --prefix /project/gbru_grasses/braker2
source activate /project/gbru_grasses/braker2

#test that braker is installed
braker.pl
#download GeneMark-ES/ET/EP ver 4.68_lic ***program*** (program link is higher up) and liscenese from http://topaz.gatech.edu/GeneMark/license_download.cgi
gunzip gmes_linux_64.tar.gz
tar -xvf gmes_linux_64.tar
gunzip gm_key_64.gz
```

# Setting up Braker3
```
module load singularity

singularity build braker3.sif docker://teambraker/braker3:latest

singularity exec braker3.sif print_braker3_setup.py
#download genemark liscenese
http://topaz.gatech.edu/GeneMark/license_download.cgi
gunzip gm_key_64.gz
mv gm_key_64 ~/.gm_key

singularity exec braker3.sif braker.pl

```

# Run Braker2
```
singularity exec /project/gbru_grasses/braker3.sif braker.pl --genome /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.fasta.masked --bam /90daydata/gbru_grasses/RaleighChr4flipped_RNAseqStarAligned_merged.sorted.bam --softmasking --cores 40
```

# Run Braker3

Running Braker3 with both aligned and raw reads generated errors at the GeneMark step. Looking at responses to issues in the GitHub page, we determined there might be an issue with the naming convension with the genome and GeneMark-ETP despite not running into the problem in preivous runs with braker2.
Error in the top level stderr
```
AUGUSTUS_CONFIG_PATH/species (in this case /usr/share/augustus/config//species) is not writeable. BRAKER will try to copy the AUGUSTUS config directory to a writeable location.
ERROR in file /opt/BRAKER/scripts/braker.pl at line 5474
Failed to execute: /usr/bin/perl /opt/ETP/bin/gmetp.pl --cfg /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP/etp_config.yaml --workdir /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP --bam /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP/etp_data/ --cores 1 --softmask  1>/project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/errors/GeneMark-ETP.stdout 2>/project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/errors/GeneMark-ETP.stderr
Failed to execute: /usr/bin/perl /opt/ETP/bin/gmetp.pl --cfg /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP/etp_config.yaml --workdir /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP --bam /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP/etp_data/ --cores 1 --softmask  1>/project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/errors/GeneMark-ETP.stdout 2>/project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/errors/GeneMark-ETP.stderr
The most common problem is an expired or not present file ~/.gm_key!
```
Error in the GeneMark-ETP.stderr
```
FASTA index file /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3/braker/GeneMark-ETP/data/genome.softmasked.fasta.fai created.
error, file/folder not found: transcripts_merged.fasta.gff
```
Error in the GeneMark-ETP.stdout
```
GeneMarkS: error on last system call, error code 11
Abort program!!!
```

So we re-ran RepeatMasker with shortened entry names
Making sure the sames don't exceede 12 characters and did not contain any whitespaces
```
#naming convention = Stsec_v[1/1a]_[chr/scaff]xxxx
#changing convention to v[1/1a][chr/scaff]xxxx

sed 's/Stsec_v1_/v1/g' Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.fasta.masked | sed 's/Stsec_v1a_/v1a/g' > Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.fasta.renamed.masked
mv Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.fasta.renamed.masked Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.fasta.masked
```
Download Braker3 and supporting programs
```

#download genemark liscenese
http://topaz.gatech.edu/GeneMark/license_download.cgi
gunzip gm_key_64.gz
mv gm_key_64 ~/.gm_key

```

# Run Braker3
```
source activate /project/gbru_grasses/braker2

#set paths to the necessary programs
export GENEMARK_PATH=/project/gbru_grasses/StAug_Raleigh/GeneMark-ETP/bin
export PATH=$PATH:/project/gbru_grasses/StAug_Raleigh/ProtHint/bin
export AUGUSTUS_CONFIG_PATH=/project/gbru_grasses/StAug_Raleigh/AUGUSTUS_CONFIG/config

#using the trimmed raw RNA reads and the masked genome
perl /project/gbru_grasses/BRAKER/scripts/braker.pl \
        --genome /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.renamed.fasta.masked \
        --rnaseq_sets_ids=R0-1_R1_001_val,R1-3_R1_001_val,R2-5_R1_001_val,RDL2_1.filtered_val,RWL3_1.filtered_val,R0-2_R1_001_val,R1-4_R1_001_val,R6-1_R1_001_val,RDL3_1.filtered_val,RWR1_1.filtered_val,R0-3_R1_001_val,R1-5_R1_001_val,R6-2_R1_001_val,RDR1_1.filtered_val,RWR2_1.filtered_val,R0-4_R1_001_val,R2-1_R1_001_val,R6-3_R1_001_val,RDR2_1.filtered_val,RWR3_1.filtered_val,R0-5_R1_001_val,R2-2_R1_001_val,R6-4_R1_001_val,RDR3_1.filtered_val,R1-1_R1_001_val,R2-3_R1_001_val,R6-5_R1_001_val,RWL1_1.filtered_val,R1-2_R1_001_val,R2-4_R1_001_val,RDL1_1.filtered_val,RWL2_1.filtered_val \
        --threads=48 \
        --rnaseq_sets_dir=/project/gbru_grasses/StAug_Raleigh/RNA_Seq/ALL2 \
        --prot_seq /project/gbru_grasses/protein_evidence/braker/protsDB.fa \
        --softmasking


```
## Step 5: Filter Braker Predictions 

```
module load miniconda
source activate /project/gbru_grasses/braker_filtering
#module load singularity  ###if on atlas, load this module first, then the others will be available, unnecessary with ceres
module load cufflinks
module load genometools
module load seqtk

cd TE-filtering
#run genometools to get cleaned version of gtf file
#gt gtf_to_gff3 -tidy -o augustus.hints-clean.gff3 augustus.hints.gtf



conda install -c bioconda tesorter



```

# Run Statistics on the various gff3 files
```
#install agat
conda install -c bioconda agat
#install eggnog
conda install -c bioconda eggnog-mapper

```

# Run GFACs
```
gFACs.pl \
 -f braker_2.05_gff3 \
 --statistics \
 --min-CDS-size 100 \
 --min-exon-size 9 \
 --min-intron-size 9 \
 --fasta Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.renamed.fasta.masked \
 --allowed-inframe-stop-codons 0 \
 --unique-genes-only \
 --rem-genes-without-start-and-stop-codon \
 --rem-all-incompletes \
 --get-fasta-without-introns \
 --get-protein-fasta \
 --create-gff3 \
 -p orthDB_filtered \
 -O /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/v1_GFACS/ \
 /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/Eggnog/augustus.hints.clean.TE_FILTERED.v1FromBothHap.eggnogFiltered.agatseparated.gff3

export PATH=/home/user/eggnog-mapper:/home/user/eggnog-mapper/eggnogmapper/bin:"$PATH"
export EGGNOG_DATA_DIR=/project/gbru_grasses/Eggnog/eggnog-mapper-data/

#GFACs removes a lot of other results connecting to the parent entry, so collect the list of gene names and filter the original file
#grep ">" orthDB_filtered_genes.fasta.faa | rev | cut -d= -f1 | rev > genelist.txt
#agat_sp_filter_feature_from_keep_list.pl --gff ../TE-filtering/augustus.hints.clean.TE_FILTERED.v1FromBothHap.gff3 --keep_list genelist.txt --output orthDB_filtered_out.geneNameFiltered.gff3

#run statistics on the gff3 file
agat_sp_statistics.pl --gff orthDB_filtered_out.geneNameFiltered.gff3 -o orthDB_filtered_out.geneNameFiltered.AGATstats.out
```

Remane all of the genes according to the selected base name
```
 cut -f1 orthDB_filtered_out.gff3 | sort | uniq > scaffolds.txt
 #***nano*** go in and remove the first line in scaffolds.txt

cat scaffolds.txt | while read i
do
grep $i orthDB_filtered_out.geneNameFiltered.gff3 | sed "s/=/=SsecRaleigh.H1.Stsec_v1_$i#/g" > orthDB_filtered_out.geneNameFiltered.${i}.gff3
done


```



## Run Entap
# Download Databases
```
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz

#Download the most recent database from ncbi
https://ftp.ncbi.nlm.nih.gov/refseq/release/complete/
wget <most recent database>

#these will download during the configuration step
#NCBI Taxonomic Database (indexed for EnTAP)
#Gene Ontology Database (indexed for EnTAP)
#EggNOG DIAMOND Database
#EggNOG SQL Database
```
# Run configeration
```
source activate /project/gbru_grasses/entap
#conda deactivate

#had to install diamond, rsem, transdecoder, interproscan
conda install -c bioconda diamond
conda install -c bioconda rsem
conda install -c bioconda transdecoder
conda install -c bioconda interproscan

export PATH=/home/user/eggnog-mapper:/home/user/eggnog-mapper/eggnogmapper/bin:"$PATH"
export EGGNOG_DATA_DIR=/project/gbru_grasses/Eggnog/eggnog-mapper-data/

#/project/gbru_grasses/EnTAP-v0.10.8-beta/EnTAP --config \
#-d uniprot_sprot.fasta \
#-d uniprot_trembl.fasta \
#-d plant.57.protein.faa \
#--out-dir /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap/entap
```



# Run entap
```
/project/gbru_grasses/EnTAP-v0.10.8-beta/EnTAP \
        --runN \
        -i /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/v1_GFACS/orthDB_filtered_genes.fasta \
        -d /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/entap/bin/uniprot_sprot.dmnd \
        -d /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/entap/bin/uniprot_trembl.dmnd \
        -d /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/entap/bin/eggnog_proteins.dmnd \
        -d /project/gbru_grasses/StAug_Raleigh/annotation/braker_Star_bothHap_flippedChr4_braker3_rawRNA/braker/entap/bin/plant.dmnd \
        -t 8

```
