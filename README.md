# Annotation Steps for Grasses


## Step 1: Process RNA-Seq Files

Following the steps given here: https://github.com/PeanutBase/BIND_annotation

Run FastQC

Check for PE adapters using trimmomatic

Trim reads trimmomatic

Check and trim SE adapters

cat reads together



## Step 2: Masking the genome

Note:  RepeatMasker and RepeatModeler had to be run on Ceres  -  both seem to run much slower on Atlas



## Step 3: Align Reads to the Reference Genome

align reads to genome using Star

Gmap was also used but the file it produced was extremely large and did not seem to change the alignments nor the results much

## Step 3.2: Trinity

use trinity to 
Note: with the number of RNA-seq samples I had, Trinity did not run well on Atlas.  Atlas appeared to run into memory errors.  Even subsetting the data into tissue and control types exceeded the memory available even in the high mem nodes.  Moving over to ceres fixed the issue.



## Step 4: Run Braker




