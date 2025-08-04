# Gene Prediction
This portion of the pipeline includes running StringTie and GeMoMa, representing _de novo_ assembled and homology-based predictions. 

[Align trimmed RNA-seq reads to the genome](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/91a8d47e0e77f7476319dfab1869985a78ad0f42/Gene_prediction/align_reads_to_genome_with_HISAT2)

[Assemble transcripts with RNA-seq data](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/b70b94e091fd6a6cb3374a090544f438f0567809/Gene_prediction/de_novo_transcriptome_assembly)

[Perform Homology-based gene prediction](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/892c8245b7a63049efcc5d9b63d27f60ff2bf90e/Gene_prediction/gemoma_homology_prediction)

Combine assembled and predicted transcripts

[Pick the best transcript for each gene locus](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/892c8245b7a63049efcc5d9b63d27f60ff2bf90e/Gene_prediction/mikado_pick_pipeline)

Continue to filtering 
