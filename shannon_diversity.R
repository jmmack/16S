# 20-Nov-2017
# JMM
# Exploring Shannon's diversity

# Imagining a microbiome of 4 taxa. What happens to the Alpha Diversity (calc by Shannon's index) when the evenness changes
# Remembering diversity is the number of things and the evenness (distribution of abundance) of those things

#Shannon's diversity calculation. Use sapply for dataframes
ds <- apply(d, 2, function(x) { -1 * sum( (x / sum(x) ) * log2(x / sum(x) )) })
#ds <- sapply(d.1, function(x) { -1 * sum( (x / sum(x) ) * log2(x / sum(x) )) })

# Notes
#   Samples are columns, taxa are rows. Therefore we apply across columns (2)
#   This is using log2 because GG prefers it. You can use the natural log if you want
#   Taking the inverse (-1) so the resulting values are positive

# I made 3 columns of data representing different evenness (the values are proportions)
d1<-c(0.25, 0.25, 0.25, 0.25)
d2<-c(0.04, 0.04, 0.04, 0.88)
d3<-c(0.04, 0.04, 0.46, 0.46)

d<-cbind(d1, d2, d3)
> d
      d1   d2   d3
[1,] 0.25 0.04 0.04
[2,] 0.25 0.04 0.04
[3,] 0.25 0.04 0.46
[4,] 0.25 0.88 0.46

> ds <- apply(d, 2, function(x) { -1 * sum( (x / sum(x) ) * log2(x / sum(x) )) })
> ds
       d1        d2        d3
2.0000000 0.7195564 1.4021792

# So the sample with more evenness has a higher diversity index...
# What happens now when we include more taxa ?

# duplicate the columns, add new rows
dd<-cbind(d, d)
f<-c(0.01, 0.01, 0.01, 1, 1, 1)

dd<-rbind(dd, f)

> dd
    d1   d2   d3   d1   d2   d3
  0.25 0.04 0.04 0.25 0.04 0.04
  0.25 0.04 0.04 0.25 0.04 0.04
  0.25 0.04 0.46 0.25 0.04 0.46
  0.25 0.88 0.46 0.25 0.88 0.46
f 0.01 0.01 0.01 1.00 1.00 1.00

> ds <- apply(dd, 2, function(x) { -1 * sum( (x / sum(x) ) * log2(x / sum(x) )) })
> ds
       d1        d2        d3        d1        d2        d3
2.0603341 0.7925681 1.4684323 2.0000000 1.3597782 1.7010896
