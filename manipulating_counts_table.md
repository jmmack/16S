
# Get frequency (percent abundance) of each taxon per sample
d.freq <- apply(taxon, 2, function(x){x/sum(x)}) 

# Your taxa are rows. These could be OTUs, genes, features

# keep taxa with frequency of > 0.01 in any sample
#   Get the frequency (percent abundance) of each taxon per sample
#   Keep the taxon as long as the maximum frequency in any one sample is greater than the cutoff
d.bf.0 <- d.col[apply(d.freq, 1, max)>0.01,] 

# keep taxa with frequency of > 0.01 in *every* sample
#   
d.bf.0 <- d.col[apply(d.freq, 1, min)>0.01,] 
