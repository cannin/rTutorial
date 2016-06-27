library(paxtoolsr)
library(data.table)
library(webchem)

# Get interacting genes for metabolites of interest from Pathway Commons

metab <- read.table("example_chebi.txt", sep="\t", header=TRUE, quote="", comment.char="", stringsAsFactors=FALSE)

# Getting ChEBI IDs given chemical names
tmp <- cts_convert('16-hydroxypalmitate', 'Chemical Name', 'ChEBI')
ids <- unname(unlist(tmp))

# KEGG 
sifKegg <- downloadPc2("PathwayCommons.8.kegg.EXTENDED_BINARY_SIF.hgnc.txt.gz", version=8)
sif <- sifKegg

paths <- unique(unlist(sif$edges$PATHWAY_NAMES))
i1 <- grepl("purine", paths, ignore.case=TRUE)
purinePaths <- paths[i1]

y <- filterSif(sif$edges, ids=metab$chebi)
z <- searchListOfVectors(purinePaths, y$PATHWAY_NAMES)

i2 <- unique(unlist(z))

w <- y[i2]
setDF(w)
w[1:10, 1:6]

r <- c(w[, 1], w[, 3])
idx <- which(!grepl("^CHEBI:", r))

resKegg <- sort(table(r[idx]))
length(resKegg)

# All Pathway Commons
if(file.exists("pc8.rds")) {
  sifAll <- readRDS("pc8.rds")
} else {
  sifAll <- downloadPc2("PathwayCommons.8.All.EXTENDED_BINARY_SIF.hgnc.txt.gz", version="8")
  saveRDS(sifAll, "pc8.rds")
}

sif <- sifAll

paths <- unique(unlist(sif$edges$PATHWAY_NAMES))
i1 <- grepl("purine", paths, ignore.case=TRUE)
purinePaths <- paths[i1]

y <- filterSif(sif$edges, ids=metab$chebi)
z <- searchListOfVectors(purinePaths, y$PATHWAY_NAMES)

i2 <- unique(unlist(z))

w <- y[i2]
setDF(w)
w[1:10, 1:6]

r <- c(w[, 1], w[, 3])
idx <- which(!grepl("^CHEBI:", r))

resAll <- sort(table(r[idx]))
length(resAll)

# HumanCyc
sifHc <- downloadPc2("PathwayCommons.8.humancyc.EXTENDED_BINARY_SIF.hgnc.txt.gz", version="8")
sif <- sifHc

paths <- unique(unlist(sif$edges$PATHWAY_NAMES))
i1 <- grepl("purine", paths, ignore.case=TRUE)
purinePaths <- paths[i1]

y <- filterSif(sif$edges, ids=metab$chebi)
z <- searchListOfVectors(purinePaths, y$PATHWAY_NAMES)

i2 <- unique(unlist(z))

w <- y[i2]
setDF(w)
w[1:10, 1:6]

r <- c(w[, 1], w[, 3])
idx <- which(!grepl("^CHEBI:", r))

resHc <- sort(table(r[idx]))
length(resHc)
