# 16S Microbiome Analysis
This repository is a collection of notes and scripts for 16S microbiome analysis

### Getting started
You should use the miseq workflow to prepare your OTU table. My (Jean's) branch is located here:
https://github.com/ggloor/miseq_bin/tree/Jean

This workflow will take your V4 (or other variable region) sequencing output and generate an OTU table with taxonomic annotations

Take note of the log file for information on program versions and parameters used

### What to do with your OTU table

You will want to explore your data. This will be some combination of **QIIME (UniFrac)** analysis and **CoDa** (Compositional Data) Analysis.
- UniFrac is an analysis of *abundance*
- CoDa is an anlaysis of *variance*

Other things you'll probably want to do:
- Plotting - use R. Including barplots, boxplots
- Data massaging - you'll likely want to add/drop samples, filter OTUs, and change you data in some way for final analysis. This repository has some example R scripts to do some of these common tasks
- Differential analysis: you'll want to use ALDEx2

It's highly recommended you spend time in the Gloor lab to examine your data. Every dataset is different and will have its own unique problems. We're here to help before you dig yourself into a pit you can't climb back out of....
