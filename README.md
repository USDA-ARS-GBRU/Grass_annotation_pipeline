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

## Step 4: Run Braker

include notes to set up braker?

## Step 5: Filter Braker Predictions 




