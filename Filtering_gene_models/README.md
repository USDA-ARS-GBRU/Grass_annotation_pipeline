# Filtering Gene Models

This portion of the pipeline includes running filtering steps to remove low-quality predictions. 

## Remove potential TE genes

[Run TEsorter](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Filtering_gene_models/filter_potential_TE_genes)

## Remove genes with no orthology mapping (optional)

[Run eggnog-mapper](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Filtering_gene_models/eggnog_mapper_orthology)

## Remove duplicate CDSs and genes with poor structure

[Run gFACs](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/Filtering_gene_models/gFACs_filtering)
