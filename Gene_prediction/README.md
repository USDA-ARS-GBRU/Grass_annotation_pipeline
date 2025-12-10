# Gene Prediction
This portion of the pipeline includes running StringTie and GeMoMa, allowing us to identify transcripts from _de novo_ assembly and homology-based sources. 

## First, align the trimmed RNA-seq data to the genome assembly
[Align with HISAT2](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Gene_prediction/align_reads_to_genome_with_HISAT2)

## Run transcript assembly and homology-based gene prediction (can be done simultaneously)
[Assemble transcripts with StringTie](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Gene_prediction/de_novo_transcriptome_assembly)

[Run GeMoMa pipeline](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Gene_prediction/gemoma_homology_prediction)

#### Note: GeMoMa will use protein evidence from input species to make gene predictions. Make sure the quality of the input evidence is good. Use multiple species for more complete predictions.

[Combine transcripts from all sources and align to the genome with GMAP](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Gene_prediction/GMAP_align_combined_CDS)

## Pick the best transcript for each gene locus

[Mikado pick](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Gene_prediction/mikado_pick_pipeline)

Continue to filtering 
