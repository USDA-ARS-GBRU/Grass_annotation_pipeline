# Filtering Braker Results

## Step 1: Separate the gff into haloptypes

Due to the heterozygosity in grasses, RNA-seq data was aligned to a combined file of both haplotypes.  The file of the Star aligned data was small enough to run the entire dataset in 1 run.

Separate the total gff into the separate files for both haplotypes.

```
grep "_v1_" augustus.hints.clean.TE_FILTERED.gff3 > augustus.hints.clean.TE_FILTERED.v1.gff3
grep "_v1a_" augustus.hints.clean.TE_FILTERED.gff3 > augustus.hints.clean.TE_FILTERED.v1a.gff3
```



