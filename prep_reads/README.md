# Prepare reads for alignment to reference sequence

## Quality check with both FastQC and fastp
[Check quality with FastQC](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/prep_reads/runFastQC.sh)

[Generate fastp report](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/prep_reads/run_fastp_report_only)

#### Note: FastQC can overestimate the % duplication and overrepresented sequences. Fastp generates a more accurate report for those metrics.

## Trim reads using standard criteria
[Run read trimming with Trim Galore](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/prep_reads/trim_reads_with_TrimGalore)

[Run read trimming again with fastp (optional)](https://github.com/USDA-ARS-GBRU/Grass_annotation_pipeline/blob/main/prep_reads/trim_reads_with_fastp)

#### Note: Read trimming with fastp only necessary if reads contain high % of duplicates/overrepresented sequences after using Trim Galore. Fastp can also be used instead of Trim Galore.
