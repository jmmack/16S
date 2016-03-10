
This is a general list of short R example code compiled by Jean to manipulate an counts table.

The counts table will generally have your samples as columns, and your features as rows. "Features" refer to any of: OTUs, genes, taxonomic levels, sequence variant, etc. **I will generally use OTU or taxon to refer to the features in these examples**

Your table should be imported into R using the read.table command

````r
d<-read.table("/path/to/table.txt", sep="\t", quote="", check.names=F, header=T, row.names=1)
````
### Filtering OTUs by abundance per sample

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

### Filtering OTUs by abundance across all samples
