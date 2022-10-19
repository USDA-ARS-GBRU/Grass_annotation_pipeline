# Filtering Braker Results


##Step 1: Filter Braker Predictions 
Following https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/braker


## Step 2: Separate the gff into haloptypes

Due to the heterozygosity in grasses, RNA-seq data was aligned to a combined file of both haplotypes.  The file of the Star aligned data was small enough to run the entire dataset in 1 run.

Separate the total gff into the separate files for both haplotypes.

```
grep "_v1_" augustus.hints.clean.TE_FILTERED.gff3 > augustus.hints.clean.TE_FILTERED.v1.gff3
grep "_v1a_" augustus.hints.clean.TE_FILTERED.gff3 > augustus.hints.clean.TE_FILTERED.v1a.gff3
```

## Step 3: Filter Using Eggnog

Eggnog requires protein information to run.

Using AGAT, run the agat_sp_extract_sequences.pl command on the gff3 files.

```
agat_sp_extract_sequences.pl --gff myfFile.gff -f fastaFile.fa -p -o protein.fa

agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1FromBothHap.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1FromBothHap.aa
agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1aFromBothHap.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1aFromBothHap.aa
```



