# Annotation Steps for Grasses

Some of the steps were performed following the steps given here: https://github.com/PeanutBase/BIND_annotation

### Citation 
This repository contains scripts used in the following publication:

Add a citation here when it's available.



## Step 1: Process RNA-Seq Files

Run FastQC

Trim reads using Trim Galore and fastp


## Step 2: Masking the genome

Cat both haplotypes of the genome together

Run EDTA and soft-masking


## Step 3: Align Reads to the genome

Align (cleaned and trimmed) reads to genome using HISAT2


## Step 4.A: _De novo_ transcriptome assembly

Run StringTie to assemble transcripts

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

### Run NLR gene predictors

NLR-Annotator (genomic loci)

NLRtracker (NLR genes)

Get overlap between different software results

============================================================================================

## **Software Used**
| Software  | Location |
| ------------- | ------------- |
| FastQC | https://github.com/s-andrews/FastQC |
| fastp | https://github.com/OpenGene/fastp |
| Trim Galore | https://github.com/FelixKrueger/TrimGalore |
| HISAT2 | https://github.com/DaehwanKimLab/hisat2 |
| EDTA | https://github.com/oushujun/EDTA |
| StringTie | https://github.com/gpertea/stringtie |
| GeMoMa | https://www.jstacs.de/index.php/GeMoMa |
| GMAP | http://research-pub.gene.com/gmap/ |
| Portcullis | https://github.com/EI-CoreBioinformatics/portcullis |
| Transdecoder | https://github.com/TransDecoder/TransDecoder |
| Mikado | https://github.com/EI-CoreBioinformatics/mikado |
| TEsorter | https://github.com/zhangrengang/TEsorter |
| eggnog-mapper | https://github.com/eggnogdb/eggnog-mapper |
| gFACs | https://gitlab.com/PlantGenomicsLab/gFACs |
| EnTAP | https://gitlab.com/PlantGenomicsLab/EnTAP |
| DIAMOND | https://github.com/bbuchfink/diamond/ |
| NLR-Annotator | https://github.com/steuernb/NLR-Annotator |
| NLRtracker | https://github.com/slt666666/NLRtracker |
| AGAT | https://github.com/NBISweden/AGAT |
| gffread | https://github.com/gpertea/gffread |
| bedtools | https://github.com/arq5x/bedtools2 |

