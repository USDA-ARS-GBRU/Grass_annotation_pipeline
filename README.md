# Annotation Steps for Grasses

Some of the steps were performed following the steps given here: https://github.com/PeanutBase/BIND_annotation


## Step 1: Process RNA-Seq Files

Run FastQC

Trim reads using trim-galore and fastp


## Step 2: Masking the genome

Cat both haplotypes of the genome together

Run EDTA and soft-masking


## Step 3: Align Reads to the genome

Align (cleaned and trimmed) reads to genome using HISAT2


## Step 4.A: _De novo_ transcriptome assembly

StringTie


## Step 4.B: Identify homologous genes

Use GeMoMa with protein evidence from related species and RNA-seq alignments generated with HISAT2

## Step 4.C: Filter splice junctions

Portcullis -- used as input for Mikado


## Step 5: Pick best transcript for each gene locus

Combine output from StringTie and GeMoMa

Run Mikado pick pipeline


## Step 6: Filtering gene models

Use TEsorter to remove likely TE genes

Use eggnog-mapper to filter for genes with orthology assignment

Use gFACs to filter out genes with poor structure


## Step 7: Rename gene models

Rename all of the genes according to their order along the genome


## Step 8: Functional annotation

### Run Entap

Download Databases

Run configuration

Run entap

