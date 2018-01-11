#11-Jan-2018
#JM
# I am trying to munge my data into format for GG's stripchart script contained in CoDaSeq (which was based on my SEED stripchart script based on AF's code)

library(CoDaSeq)

#This is ALDEx2 output
# In this case, the first column (rownames) look like: SV_14:Bacteria:Firmicutes:Clostridia:Clostridiales:Lachnospiraceae:Fusicatenibacter
aldex.out<-read.table("aldex_ttest.txt", header=T, row.names=1, sep="\t")

#need to make a separate table of taxon information
#Which means I need to split the taxonomic levels into separate columns

t1<- strsplit(rownames(aldex.out), ":")
#the next 2 steps are to get a list into a data.frame/column format
t2<-matrix(unlist(t1), ncol=7, byrow=TRUE)
#put the SV ID at the end
t3<-t2[,c(2:ncol(t2),1)]
#add a header for reference
colnames(t3)<-c("domain", "phylum", "class", "order", "family", "genus", "sv")

#now the rownames have to match for the two tables
rownames(aldex.out)<-t3[,7]
rownames(t3)<-t3[,7]

codaSeq.stripchart(aldex.out, group.table=t3, group.label="genus", sig.method="effect", sig.cutoff=2)

pdf("strip.pdf", height=20)
dev.off()

# Suggestion for next time
# Remove any groups (e.g. genera) that have no groups >effect 1 for plotting purposes
# adjust some plotting parameters to change colors, sizing, etc.
