## ------------------------------------------------------------------------
library(paxtoolsr)

## ---- eval=FALSE---------------------------------------------------------
## downloadPc2()

## ------------------------------------------------------------------------
# Single databases
geneSets <- downloadPc2("PathwayCommons.8.Reactome.GSEA.hgnc.gmt.gz", version="8")
sif <- downloadPc2("PathwayCommons.8.kegg.EXTENDED_BINARY_SIF.hgnc.txt.gz", version="8")

# All databases 
geneSets <- downloadPc2("PathwayCommons.8.All.GSEA.hgnc.gmt.gz", version="8")

## ------------------------------------------------------------------------
sif <- filterSif(sif$edges, ids=c("GPI"))

nrow(sif)
colnames(sif)
head(sif[, 1:3, with=FALSE], 2)

## ------------------------------------------------------------------------
library(igraph); library(data.table) # SIF files read as data.table for speed

setDF(sif) # Convert data.table to data.frame 

# graph.edgelist requires a matrix
g <- graph.edgelist(as.matrix(sif[, c(1, 3)]), directed = FALSE)
plot(g, layout = layout.fruchterman.reingold)

## ------------------------------------------------------------------------
library(webchem)

cts_convert('16-hydroxypalmitate', 'Chemical Name', 'ChEBI')

## ------------------------------------------------------------------------
metab <- read.table("example_chebi.txt", sep="\t", header=TRUE, quote="", comment.char="", stringsAsFactors=FALSE)

## ------------------------------------------------------------------------
# KEGG 
sifKegg <- downloadPc2("PathwayCommons.8.kegg.EXTENDED_BINARY_SIF.hgnc.txt.gz", version="8")
sif <- sifKegg

paths <- unique(unlist(sif$edges$PATHWAY_NAMES))
purineIdx <- grepl("purine", paths, ignore.case=TRUE)
purinePaths <- paths[purineIdx]

metabFilteredSif <- filterSif(sif$edges, ids=metab$chebi)
tmp <- searchListOfVectors(purinePaths, metabFilteredSif$PATHWAY_NAMES)
purineIdx <- unique(unlist(tmp))

purineOnlySif <- metabFilteredSif[purineIdx]
setDF(purineOnlySif)
purineOnlySif[1:2, 1:6]

tmp <- c(purineOnlySif[, 1], purineOnlySif[, 3])
idx <- which(!grepl("^CHEBI:", tmp))

resKegg <- sort(table(tmp[idx]))
length(resKegg)

## ------------------------------------------------------------------------
# Load libraries
library(paxtoolsr); library(rcellminer)

# Load data
geneSets <- downloadPc2("PathwayCommons.8.Reactome.GSEA.hgnc.gmt.gz", version="8")
mutData <- getAllFeatureData(rcellminerData::molData)[["mut"]]

hiMutGenes <- head(sort(rowSums(mutData), decreasing=TRUE), 25)

# Initialize variable
pvals <- NULL

for(set in geneSets) {
  #set <- hiMutGenes
  sampleSize <- length(hiMutGenes) # size drawn
  hitInSample <- length(which(hiMutGenes %in% set)) # black drawn
  hitInPop <- length(which(rownames(mutData) %in% set)) # all black 
  failInPop <- nrow(mutData)-hitInPop # number of red
  # Calculate over-enrichment for current gene set
  pval <- phyper(hitInSample-1, hitInPop, failInPop, sampleSize, lower.tail= FALSE)
  # Add current result
  pvals <- c(pvals, pval)
}

# Adjust p-values
pvals <- p.adjust(pvals, method="fdr")
length(pvals[pvals < 0.05])

