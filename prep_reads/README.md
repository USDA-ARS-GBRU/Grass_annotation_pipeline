# Prepare reads for alignment to reference sequence

## Quality check with both FastQC and fastp
[Check quality with FastQC](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/913d67d75f009958cdd2f7dbd7a51a49018aaf37/prep_reads/runFastQC.sh)

[Generate fastp report](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/841902ffea91a96a4fc22a9a2aab1d6bbd60d882/prep_reads/run_fastp_report_only)

FastQC can overestimate the % duplication and overrepresented sequences. Fastp generates a more accurate report for those metrics.

## Trim reads using standard criteria
[Run read trimming with Trim Galore](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/af27ac5a662d6fc677e8abcffaacaf9482511203/prep_reads/trim_reads_with_TrimGalore)

[Run read trimming again with fastp (optional)](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/af27ac5a662d6fc677e8abcffaacaf9482511203/prep_reads/trim_reads_with_fastp)

Read trimming with fastp only necessary if reads contain high % of duplicates/overrepresented sequences after using Trim Galore. Fastp can also be used instead of Trim Galore.

## Align the reads to a reference (in this case, the genome assembly)
[Perform alignment](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/27ab016d819c567563a2dc4ca6b6721d9e10ef42/prep_reads/HISAT2_align_to_genome)
