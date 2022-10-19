# Filtering Braker Results


## Step 1: Filter Braker Predictions 
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

agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1.aa
agat_sp_extract_sequences.pl --gff augustus.hints.clean.TE_FILTERED.v1a.gff3 -f /project/gbru_grasses/StAug_Raleigh/genome/Stenotaphrum_secundatum_RaleighCultivar_genome_bothHaplotypes.fasta.masked -p -o augustus.hints.clean.TE_FILTERED.v1a.aa
```

Run Eggnog

```
export PATH=/home/user/eggnog-mapper:/home/user/eggnog-mapper/eggnogmapper/bin:"$PATH"
export EGGNOG_DATA_DIR=/project/gbru_grasses/Eggnog/eggnog-mapper-data/

#emapper.py -m diamond --itype proteins -i augustus.hints.aa -o emapper --cpu 20

emapper.py -m diamond --itype proteins -i augustus.hints.clean.TE_FILTERED.v1.aa -o emapper_v1FromBothHap --cpu 20
emapper.py -m diamond --itype proteins -i augustus.hints.clean.TE_FILTERED.v1a.aa -o emapper_v1aFromBothHap --cpu 20
```


Eggnog does not output a gff file so to create one, first get the list of filtered tags.  Then use AGAT's command agat_sp_filter_feature_from_keep_list.pl to filter the original gff3 file.

```
awk '{print $1}' emapper_v1a.emapper.annotations > emapper_v1a.emapper.annotations.tags.txt
awk '{print $1}' emapper_v1.emapper.annotations > emapper_v1.emapper.annotations.tags.txt

agat_sp_filter_feature_from_keep_list.pl --gff augustus.hints.clean.TE_FILTERED.v1a.gff3 --keep_list emapper_v1a.emapper.annotations.tags.txt --output augustus.hints.clean.TE_FILTERED.v1a.eggnogFiltered.agatseparated.gff3
agat_sp_filter_feature_from_keep_list.pl --gff augustus.hints.clean.TE_FILTERED.v1.gff3 --keep_list emapper_v1.emapper.annotations.tags.txt --output augustus.hints.clean.TE_FILTERED.v1.eggnogFiltered.agatseparated.gff3

```


