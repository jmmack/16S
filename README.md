# 16S Microbiome Analysis
This repository is a collection of notes and scripts for 16S microbiome analysis

### Getting started
You should use the miseq workflow to prepare your OTU table
https://github.com/ggloor/miseq_bin/tree/Jean

This workflow will take your V4 (or other variable region) sequencing output and generate an OTU table with taxonomic annotations

Take note of the log file for information on program versions and parameters used

### What to do with your OTU table (end of the miseq workflow)

You will want to explore your data. This will be some combination of multivariate toolsets like **QIIME (UniFrac)** analysis and **CoDa** (Compositional Data) Analysis.
- UniFrac is an analysis of *abundance*
- CoDa is an anlaysis of *variance*

Other things you'll probably want to do:
- Plotting - use R. Including barplots, boxplots
- Data manipulation - you'll likely want to add/drop samples, filter OTUs, and change you data in some way for final analysis. **This repository has some example R scripts to do some of these common tasks** (e.g. manipulating_counts_table.md)
- Differential analysis: you'll want to use ALDEx2

It's highly recommended you spend time in the Gloor lab to examine your data. Every dataset is different and will have its own unique problems. We're here to help before you dig yourself into a pit you can't climb back out of....

### Some of Jean's notes and examples to get started

###### My branch of the miseq workflow
_may be different from (i.e. more up to date) Greg's master branch_  
https://github.com/ggloor/miseq_bin/tree/Jean

###### Example scripts in R, Perl, Bash, QIIME, etc.
https://github.com/mmacklai/example-scripts

###### Compositional Data Analysis (CoDa):
https://github.com/mmacklai/example-scripts/tree/master/CoDa

###### ALDEx2:
https://bioconductor.org/packages/release/bioc/html/ALDEx2.html  
https://github.com/mmacklai/example-scripts/tree/master/aldex2

### Some of Greg's resources
https://github.com/ggloor/compositions

