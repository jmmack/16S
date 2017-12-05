#Update: 5-Dec-2017 JM
# Sum a counts table by taxonomic level (equivalent to QIIME's summarize_taxa.py function)
# You can find example data here: https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data

# Your table should have OTUs/SVs as rownames, and samples as columns, with the last column being the taxonomy (lineage separated by semi-colon)
#e.g. Bacteria;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus
d<-read.table("otu_table.txt", sep="\t", quote="", check.names=F, header=T, row.names=1, comment.char="")

head(d)

#get the taxonomy column by name
tax<-d$taxonomy

#just get the counts columns (exclude the last taxonomy column)
dm<-d[,1:ncol(d)-1]

#this aggregates (sums) the taxonomy rows by the total taxonomy string
dm.agg <- aggregate(dm, by=list(tax), FUN=sum)

dim(dm.agg)

#split by each taxonomic level: splitting on ";"
split<-strsplit(as.vector(tax), ";")

#A note on accessing the data, e.g.
#split[[1]] is the first row (refseq)
#split[[1]][1] is the first taxonomy level of the first row

#Sum all the reads by the 6th taxonomic level (separated by ;)
# in sapply, <"[", 6> will pull the 6th element
# It's equivalent to split6[[N]][6] where "N" is each lineage, and the 6th element is being pulled
split6 <- sapply(strsplit(as.character(tax), ";"), "[", 6)

#6 is genus in this data set. Sum by genus
dm.agg6 <- aggregate(dm, by=list(split6), FUN=sum)

dim(dm.agg6)

#move labels to rownames so the data are numeric
rownames(dm.agg6) <- dm.agg6$Group.1
dm.agg6$Group.1 <- NULL

#--------------------------------------------------------------------------------------------------
# Another example - NOTE this
# Get the otu number, genus, species in one string
# This is based on a standard OTU counts table with taxonomy as the last column
split <- strsplit(as.character(d$taxonomy), ";")

ta<-list()

for (i in 1:length(split)){
ta[i]<-paste(rownames(d)[i], split[[i]][6], split[[i]][7], sep="_")
#rownames(d) is the OTU number, split[[i]][6] is genus, split[[i]][7] is species
#ta[i]<-paste(rownames(d)[i], split[[i]][6], sep="_")
}
