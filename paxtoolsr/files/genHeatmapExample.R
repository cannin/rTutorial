library(rcellminer)

set.seed(1)

molData <- getMolDataMatrices()

selectedOncogenes <- c("ABL1", "ALK", "BRAF", "CCND1", "CCND3", "CCNE1", "CCNE2", 
                       "CDC25A", "EGFR", "ERBB2", "EZH2", "FOS", "FOXL2", "HRAS", 
                       "IDH1", "IDH2", "JAK2", "KIT", "KRAS", "MET", "MOS", "MYC", 
                       "NRAS", "PDGFB", "PDGFRA", "PIK3CA", "PIK3CB", "PIK3CD", 
                       "PIK3CG", "PIM1", "PML", "RAF1", "REL", "RET", "SRC", "STK11", 
                       "TP63", "WNT10B", "WNT4", "WNT2B", "WNT9A", "WNT3", "WNT5A", 
                       "WNT5B", "WNT10A", "WNT11", "WNT2", "WNT1", "WNT7B", "WISP1", 
                       "WNT8B", "WNT7A", "WNT16", "WISP2", "WISP3", "FZD5", "FZD1")

selectedOncogenes <- sample(selectedOncogenes, 20)

# Generate the appropriate rownames 
expGeneLabels <- paste0("exp", selectedOncogenes)
copGeneLabels <- paste0("cop", selectedOncogenes)

a <- molData[["exp"]][expGeneLabels,]

d <- sapply(rownames(a), function(x) {
  substr(x, 4, nchar(x))
})

e <- unname(d)

rownames(a) <- e

b <- a[, 1:20]
heatmap(b, cexCol=0.75)

write.table(b, file="heatmapExample.txt", sep="\t", quote=FALSE)



