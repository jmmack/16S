## Manipulating counts tables in R

This is a general list of short R example code compiled by Jean to manipulate an counts table.

The counts table will generally have your samples as columns, and your features as rows. "Features" refer to any of: OTUs, genes, taxonomic levels, sequence variant, etc. **To keep things simple, I will generally use "OTU" to refer to the features in these examples**

Your table should be imported into R using the read.table command

````r
d<-read.table("/path/to/table.txt", sep="\t", quote="", check.names=F, header=T, row.names=1)
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
d.bf.0 <- d.col[apply(d.freq, 1, max)>0.01,]

# Keep the OTU as long as the maximum frequency of the OTU in any one sample is greater than the cutoff
````

Keep taxa with frequency of > 0.01 in *every* sample:
````r
d.bf.0 <- d.col[apply(d.freq, 1, min)>0.01,]

# Keep the OTU as long as the minimum frequency of the OTU in all samples is greater than the cutoff
````
---
### Filtering OTUs (rows) by abundance across all samples

Discard OTU if it is a zero in half or more of the samples
````r
cutoff = .5
d.1 <- data.frame(d[which(apply(d, 1, function(x){length(which(x != 0))/length(x)}) > cutoff),])
````
Remove OTUs with < 500 total counts (row sum < 500)
````r
count = 500
d.0 <- data.frame(d.1[which(apply(d.1, 1, function(x){sum(x)}) > count),])
````
---
### Remove samples (columns) by name

````r
# Give a list (vector) of column names you want to get rid of
rem<-c("100bvvc", "109bvvc", "110bvvc", "127bvvc", "128bvvc", "133bvvc", "134bvvc", "147bvvc", "148bvvc", "151bvvc", "152bvvc", "161bvvc", "162bvvc", "177bvvc", "178bvvc", "179bvvc", "180bvvc", "83bvvc", "84bvvc", "87bvvc", "88bvvc", "91bvvc", "92bvvc", "97bvvc", "98bvvc", "99bvvc")


for(i in 1:length(rem)){
	d[,i]<-NULL
}

````

**WARNING**: As soon as you remove samples, you are removing counts from OTUs. THEREFORE you **must** re-filter your OTUs to an appropriate levels

* *Example*: You filter your OTUs to a 1% abundance in any sample. Then you remove samples from your dataset. You must then run your 1% filter again because you have changed your count data by removing columns!*
