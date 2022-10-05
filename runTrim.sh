#!/bin/bash

#script to run trimming on RNA-seq files

date

cd Raleigh_Leaf
trim_galore --paired RDL3_1.filtered.fq.gz RDL3_2.filtered.fq.gz
trim_galore --paired RWL1_1.filtered.fq.gz RWL1_2.filtered.fq.gz
trim_galore --paired RWL2_1.filtered.fq.gz RWL2_2.filtered.fq.gz
trim_galore --paired RWL3_1.filtered.fq.gz RWL3_2.filtered.fq.gz

cd ..
cd Raleigh_Root
trim_galore --paired RDR1_1.filtered.fq.gz RDR1_2.filtered.fq.gz
trim_galore --paired RDR2_1.filtered.fq.gz RDR2_2.filtered.fq.gz
trim_galore --paired RDR3_1.filtered.fq.gz RDR3_2.filtered.fq.gz
trim_galore --paired RWR1_1.filtered.fq.gz RWR1_2.filtered.fq.gz
trim_galore --paired RWR2_1.filtered.fq.gz RWR2_2.filtered.fq.gz
trim_galore --paired RWR3_1.filtered.fq.gz RWR3_2.filtered.fq.gz


date
