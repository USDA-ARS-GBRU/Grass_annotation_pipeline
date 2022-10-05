#!/bin/bash

date

module load fastqc/0.11.9

cd /project/gbru_grasses/StAug_Raleigh/RNA_Seq/GLS_PI410353

for f in *.gz; do fastqc $f; done

date
