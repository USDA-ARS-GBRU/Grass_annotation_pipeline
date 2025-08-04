# Gene Prediction
This portion of the pipeline includes running StringTie and GeMoMa, allowing us to identify transcripts from _de novo_ assembly and homology-based sources. 

## First, align the trimmed RNA-seq data to the genome assembly
[Align with HISAT2](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/91a8d47e0e77f7476319dfab1869985a78ad0f42/Gene_prediction/align_reads_to_genome_with_HISAT2)

## Run transcript assembly and homology-based gene prediction (can be done simultaneously)
[Assemble transcripts with StringTie](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/b70b94e091fd6a6cb3374a090544f438f0567809/Gene_prediction/de_novo_transcriptome_assembly)

[Run GeMoMa pipeline](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/892c8245b7a63049efcc5d9b63d27f60ff2bf90e/Gene_prediction/gemoma_homology_prediction)

#### Note: GeMoMa will use protein evidence from input species to make gene predictions. Make sure the quality of the input evidence is good. Use multiple species for more complete predictions.

[Combine transcripts from all sources and align to the genome with GMAP](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/08b2e4e4989c55c40f11b78c5b3fc92b33379de4/Gene_prediction/GMAP_align_combined_CDS)

## Pick the best transcript for each gene locus

[Mikado pick](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/892c8245b7a63049efcc5d9b63d27f60ff2bf90e/Gene_prediction/mikado_pick_pipeline)

Continue to filtering 
