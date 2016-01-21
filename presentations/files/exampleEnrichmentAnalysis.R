library(paxtoolsr)
library(rcellminer)

geneSets <- downloadPc2("Pathway Commons.7.Reactome.GSEA.hgnc.gmt.gz")
mutData <- getAllFeatureData(rcellminerData::molData)[["mut"]]
hiMutGenes <- head(sort(rowSums(mutData), decreasing=TRUE), 25)

# Show first 6 entries 
head(hiMutGenes)

pvals <- NULL

for(set in geneSets) {
  #set <- hiMutGenes
    
  sampleSize <- length(hiMutGenes) # size drawn
  hitInSample <- length(which(hiMutGenes %in% set)) # black drawn
  hitInPop <- length(which(rownames(mutData) %in% set)) # all black 
  failInPop <- nrow(mutData)-hitInPop # number of red
  
  pval <- phyper(hitInSample-1, hitInPop, failInPop, sampleSize, lower.tail= FALSE)
  pvals <- c(pvals, pval)
}

pvals <- p.adjust(pvals, method="fdr")
