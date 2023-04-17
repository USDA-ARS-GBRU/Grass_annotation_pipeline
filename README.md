# Annotation Steps for Grasses


## Step 1: Process RNA-Seq Files

Following the steps given here: https://github.com/PeanutBase/BIND_annotation

Run FastQC
```
module load fastqc/0.11.9

cd /project/gbru_grasses/bermuda/Raw_Data/RNA-Seq/

#run fastqc on all samples
for f in *.gz; do fastqc $f; done
```
Check for PE adapters using trimmomatic

Trim reads using trim-galore
```
conda create --prefix /project/gbru_grasses/annotation
conda activate /project/gbru_grasses/annotation
conda install -c bioconda trim-galore

#do for all paired samples
trim_galore --paired Leaf-1_R1_001.fastq.gz Leaf-1_R2_001.fastq.gz
```

Check and trim SE adapters

cat reads together



## Step 2: Masking the genome

Note:  RepeatMasker and RepeatModeler had to be run on Ceres  -  both seem to run much slower on Atlas

Cat both haplotypes of the genome together.

Run RepeatModeler on the full genome file.
```

#BuildDatabase -name Bermuda_bothHap /project/gbru_grasses/bermuda/Cyntrans_genome_bothHaplotypes.fasta -engine ncbi

#RepeatModeler -database Bermuda_bothHap -engine ncbi -pa 48
```

Run RepeatMasker
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

Setting up Braker2
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

Setting up Braker3
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

Run Braker2
```
singularity exec /project/gbru_grasses/braker3.sif braker.pl --genome /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.AllfixedChr4.reordered.fasta.masked --bam /90daydata/gbru_grasses/RaleighChr4flipped_RNAseqStarAligned_merged.sorted.bam --softmasking --cores 40
```

Run Braker3
```

```
## Step 5: Filter Braker Predictions 




