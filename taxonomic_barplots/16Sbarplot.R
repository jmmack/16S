#Update: 5-Dec-2017 JM
# Make a proportional barplot
# You can find example data here: https://github.com/mmacklai/example-scripts/tree/master/qiime_pipeline/test_data



#-----------------------------------------------------------------------------------
# Notes:
#	This script will sum reads to genus level
#	Taxa below 1% abundance (total across ALL samples) will be groups as "remainder"
#	WITHIN EACH SAMPLE taxa below 1% will be grouped into "remainder"
#		(this is to reduce the visual clutter)

#-----------------------------------------------------------------------------------
# Read in the table, and then collect the taxonomy column
#-----------------------------------------------------------------------------------

# Your table should have OTUs/SVs as rownames, and samples as columns, with the last column being the taxonomy (lineage separated by semi-colon)
#e.g. Bacteria;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus
d<-read.table("otu_table.txt", sep="\t", quote="", check.names=F, header=T, row.names=1, comment.char="")

head(d)

tax<-d$taxonomy

#get only the count columns
dm<-d[,1:ncol(d)-1]

#------------------
#this aggregates by the total taxonomy string
#dm.agg <- aggregate(dm, by=list(tax), FUN=sum)

#split by each taxonomic level: splitting on ";"
#split<-strsplit(as.vector(tax), ";")

#accessing the data, e.g.
#split[[1]] is the first row (refseq)
#split[[1]][1] is the first taxonomy level of the first row

#Sum all the reads by the 6th taxonomic level (separated by ;)
# in sapply, <"[", 6> will pull the 6th element
split6 <- sapply(strsplit(as.character(tax), ";"), "[", 6)

#6 is genus in this data set
agg6 <- aggregate(dm, by=list(split6), FUN=sum)
#move labels to rownames so the data are numeric
rownames(agg6) <- agg6$Group.1
agg6$Group.1 <- NULL

#----------------------------------------
# combine taxa that are below x percent abundance
# This simplifies the barplot (visually)

# convert to percent abundances
agg6p <- apply(agg6, 2, function(x){x/sum(x)})

#1% abundance
abund <- 0.01

# a is >= abundance, while b is < abundance
# keeping the counts instead of proportions to build barplot later
agg6.a <- agg6[apply(agg6p, 1, max) >= abund,]	#everything above cutoff
agg6.b <- agg6[apply(agg6p, 1, max) < abund,]	#everything below cutoff

#sum the remainder (below the cutoff) into one group
x <- colSums(agg6.b, dims=1)

#merge the above cutoff and the "remainder"
p<-rbind(agg6.a,x)
rownames(p)[nrow(p)]<-"remainder"

#get percent abundances
pp <- apply(p, 2, function(x){x/sum(x)})

#order the taxa from most to least abundant. This is so the largest fraction are plotted first
y <- pp[order(rowSums(pp), decreasing = TRUE),]

#check sample columns sums to 1 (100%)
colSums(y)
dim(y)

#-----------------------------------------------------------------------------------
# WITHIN each sample, sum any <0.01% taxa into the remainder. This is for visual simplification
# Compare the plot before and after this step
#-----------------------------------------------------------------------------------
y <- apply( y , 2, function(x) {
	small <- ( x < abund ) #& ( bugnames != "rem" )
	rare <- sum( x[small] )
	x[small] <- 0 # *** NA
	x["remainder"] <- x["remainder"] + rare
	return(x)
#	return(rare) #to this to get ONLY the rare organisms
} )


#-----------------------------------------------------------------------------------
# Barplot
#-----------------------------------------------------------------------------------

barplot(y, col=rainbow(10))

#-----------------------------------------------------------------------------------
# Other options
#-----------------------------------------------------------------------------------
# This is the order I want the taxonomy to plot.
# I put lactos first, then G. vag, then ordered by relative abundance (across all samples)
r.order<-c("Lactobacillus_iners", "Lactobacillus_crispatus", "Lactobacillus_jensenii", "Lactobacillus_gasseri/johnsonii", "Gardnerella", "Prevotella", "unclassified_BVAB1", "Atopobium", "Megasphaera", "Dialister", "Sneathia", "Parvimonas", "Staphylococcus", "TM7_genera_incertae_sedis", "unclassified_BVAB2", "Comamonas", "Acinetobacter", "Bifidobacterium", "Moryella", "Cloacibacterium", "Brevundimonas", "Leuconostoc", "Porphyromonas-like", "Prevotella-like", "Porphyromonas", "Fusobacterium", "Anaerococcus", "Veillonella", "Escherichia/Shigella", "Peptostreptococcus", "Actinomyces", "Streptococcus", "unclassified", "unknown", "remainder")

y<-y[r.order,]

#colors to match the taxa order
colours<-c("steelblue3", "skyblue1", "#1C4466", "cyan", "indianred1", "mediumpurple1", "#FFED6F", "ivory2", "olivedrab3", "aquamarine3", "pink", "mediumorchid3", "#C0C0C0", "#3399FF", "#FFCC66", "#999933", "#666699", "mediumvioletred", "#666666", "#993300", "#006666", "#FFCC66", "#9999CC", "#663366", "#999966", "#9999FF", "#CCCC99", "#CC6600", "#669999", "#CCCCCC", "#CCCC66", "#CC9933", "black", "black", "white")


pdf("16s_barplot.pdf", height=6, width=8)
par(mar=c(4,4,0.5,0.5))
barplot(y[,s.order], space=0, col=colours, las=2, ylim=c(0,1))
mtext("16S rRNA(V6) fraction", side=2, line=2.5)
dev.off()

#I am plotting the legend separately
pdf('legendtest.pdf', height=10, width=8)
barplot(y[,s.order], space=0, col=colours, ylim=c(-20,0), legend=T)
dev.off()

#------------------------------------------------------------
# alternate method for the legend

par(mar=c(5, 4, 4, 10), xpd = T)
barplot(y, space=0, col=colours, las=2, legend.text = TRUE, args.legend = list(x = "topright", bty = "n", inset=c(-0.3, 0), cex=0.55))

