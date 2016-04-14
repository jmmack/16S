## Manipulating counts tables in R

This is a general list of short R example code compiled by Jean to manipulate a counts table.

The counts table will generally have your samples as columns, and your features as rows. "Features" refer to any of: OTUs, genes, taxonomic levels, sequence variant, etc. **To keep things simple, I will generally use "OTU" to refer to the features in these examples**

Your table should be imported into R using the read.table command

````r
d<-read.table("/path/to/table.txt", sep="\t", quote="", check.names=F, header=T, row.names=1)
# use skip=1 if you have a metadata line before your headers (QIIME-style OTU table)
# use comment.char="" if your header line starts with #
````
---
#### Some tips
Check your table dimensions (number of rows and number of columns)

````r
dim(d)
````
---

### Filtering OTUs (rows) by abundance per sample

Get frequency (percent abundance) of each OTU per sample
````r
d.freq <- apply(d, 2, function(x){x/sum(x)})

# apply can be by row (1) or column (2)
````

Keep OTUs with frequency of > 0.01 in *any* sample:

````r
d.0 <- d[apply(d.freq, 1, max)>0.01,]

# Keep the OTU as long as the maximum frequency of the OTU in any one sample is greater than the cutoff
````

Keep OTUs with frequency of > 0.01 in *every* sample:
````r
d.0 <- d[apply(d.freq, 1, min)>0.01,]

# Keep the OTU as long as the minimum frequency of the OTU in all samples is greater than the cutoff
````
Discard OTUs with a mean count <=1 across all samples
````r
count <- 1
d.1 <- data.frame(d[which(apply(d, 1, function(x){mean(x)}) > count),], check.names=F)
````
---
### Filtering OTUs (rows) by abundance across all samples

Discard OTU if it is a zero in half or more of the samples
````r
cutoff = .5
d.0 <- data.frame(d[which(apply(d, 1, function(x){length(which(x != 0))/length(x)}) > cutoff),])
````
Remove OTUs with < 500 total counts (row sum < 500)
````r
count = 500
d.0 <- data.frame(d[which(apply(d, 1, function(x){sum(x)}) > count),])
````
---
### Select or remove samples (columns) by name

Using an inclusion list (list of sample to keep)
````r
# Vector of column names to keep for analysis
BV1<-c("006A", "009A", "010A", "012A")
BV2<-c("008A", "013A", "016B", "012B", "014B", "017B", "018B", "27S")

# Concatenate two vectors together to pull the data
df<-d[,c(BV1, BV2)]
````

Using an exclusion list (list of samples *not* to include)
````r
# Give a list (vector) of column names you want to EXCLUDE (get rid of)
rem<-c("100bvvc", "109bvvc", "110bvvc", "127bvvc", "128bvvc", "133bvvc", "134bvvc", "147bvvc", "148bvvc", "151bvvc", "152bvvc", "161bvvc", "162bvvc", "177bvvc", "178bvvc", "179bvvc", "180bvvc", "83bvvc", "84bvvc", "87bvvc", "88bvvc", "91bvvc", "92bvvc", "97bvvc", "98bvvc", "99bvvc")

df <- d[, !names(d) %in% rem] 
````

### Grep for sample names (partial match)

````r
# Will pull all columns with a header containing "TM"
df<-as.matrix(d[,grep("TM", colnames(d))])
````


**WARNING**: As soon as you remove samples (or select a subset of samples), you are removing counts from OTUs. THEREFORE you **must** re-filter your OTUs to an appropriate levels

* *Example*: You filter your OTUs to a 1% abundance in any sample. Then you remove samples from your dataset. You must then run your 1% filter again because you have changed your count data by removing columns!
