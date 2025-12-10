# Perform Functional Annotation on Gene Models

## Full functional annotation with EnTAP using multiple databases
[Run EnTAP](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Functional_Annotation/run_EnTAP)

As part of its base pipeline, EnTAP runs annotation using an internal database configured specifically for EnTAP and runs eggnog-mapper with the EggNOG database. For our purposes, we also used RefSeq plant, UniProt Swiss-Prot, UniProt TrEMBL, and NCBI NR protein databases as optional input. 

## Run NLR-Annotator and NLRtracker to identify NLR loci
[Run NLR-Annotator](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Functional_Annotation/run_NLR-Annotator)

[Run NLRtracker](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Functional_Annotation/run_NLRtracker_workflow)

## Determine best NLRs

Use bedtools intersect to get overlap between NLR predictions from different software. NLR loci with 1-to-1 matches between both sources are the most reliable.
