
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-317478-17', 'auto');
  ga('send', 'pageview');

</script>

<script src='https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js'></script>
<script>
$(window).bind('load', function() {
  Reveal.addEventListener('slidechanged', function(event) {
    console.log('Slide Index: ' + event.indexh);
    ga('send', 'event', 'Slide Index', 'click', event.indexh);
  });
});
</script>


Introduction to paxtoolsr
===
author: Augustin Luna
date: 27 June, 2016
width: 960
height: 700
transition: linear
css: rpres.css

<!-- NOTE: Styling and external images may be missing --> 
<p>Research Fellow
  <br/>
  Department of Biostatistics and Computational Biology
  <br/>
  Dana-Farber Cancer Institute
</p>
<div class="footer" style="display:none;"><img src="img/dfci_logo.gif" height="60px" width="330px" /></div>

What is Pathway Commons? 
===
* Website: http://www.pathwaycommons.org/
* An aggregation of public pathway database information
* Provides data in multiple formats
 * Biological Pathway Exchange (BioPAX) Format
 * Simple Interaction Format (SIF)
 * Gene sets as Gene Matrix Transposed (GMT) Format
* Provides infrastructure for searching the aggregated pathway data

Biological Pathway Exchange (BioPAX) Format
===
class: smaller-75

* BioPAX: http://biopax.org/
* Community-wide effort to represent biological pathways
 * Pathways are collections of interactions that biologists have found useful to group together for organizational, historic, biophysical or other reasons
* Types
 * Metabolic pathways
 * Signaling pathways
 * Protein-protein interactions
 * Gene regulatory pathways
* Advanced tutorial on BioPAX
 * https://github.com/cannin/biopaxTutorial
 
Pathway Commons Homepage
===
class: center-img

<img src="img/pathwayCommons_homepage.png" height="600px" />

Pathway Commons Visualizer
===
class: center-img

<img src="img/pcviz_homepage.png" height="600px" /> 
 
Pathway Commons Data sets
===
class: smaller

|Database|Interaction Count|
|---|---|
|Reactome|11924|
|NCI PID|16017|
|PhosphoSitePlus|13642|
|HumanCyc|7024|
|HPRD|40618|
|PantherDB|5282|
|DIP|7102|
|BioGRID|244843|

***

|Database|Interaction Count|
|---|---|
|InAct|98347|
|BIND|35566|
|TRANSFAC|261624|
|mirTarBase|51214|
|DrugBank|19159|
|Recon X|10910|
|CTD|313174|
|KEGG|4472|

Simple Interaction Format (SIF) 
===
* An edgelist with interaction type: 3 columns
 * PARTICIPANT_A, INTERACTION_TYPE, PARTICPANT_B
* Expected representation for many network analyses 
* Extracted using graph queries that detect biologically interesting interaction patterns in Pathway Commons data 
 * Complexes, metabolic, modification, control interactions
 * Generates binary interactions and integrates them across databases

SIF Interaction Types
===
class: center-img

* [Complete list of interaction types in Google Docs](https://docs.google.com/document/d/1coFo66uuPQQ4ZMSHr8IzCV7I2DwXCoDBfZw7Vg4MgUE/edit?usp=sharing)
* Examples of conversions from BioPAX to SIF

<img src="img/pc_sif.png" height="400px" />

Gene Set (GMT) Format
===
class: smaller-75

|Gene Set|Description|Gene 1|Gene 2|Gene 3| ... |
|---|---|---|---|---|---|
|KEGG_GLYCOLYSIS_GLUCONEOGENESIS|KEGG|GCK|PGK2|PGK1|...|
|REACTOME_SIGNALING_BY_EGFR_IN_CANCER|Reactome|AKT3|ADAM10|SPRY1|...|

What is paxtoolsr?
===
class: smaller-75

* Website and Tutorial (Vignette):    
 * https://bioconductor.org/packages/release/bioc/html/paxtoolsr.html
* Publication: 
 * http://www.ncbi.nlm.nih.gov/pubmed/26685306
* Read and write
 * Biological Pathway Exchange (BioPAX)
 * Binary Simple Interaction Format (SIF) 
 * Extended SIF: Includes additional information about SIF network
 * Gene Set (GMT)
 * Systems Biology Graphical Notation Markup Language (SBGN-ML) 
* Search and summarize local BioPAX files
* Search Pathway Commons 

Downloading and Reading Pathway Commons Data 
===
class: smaller-50

* Load library


```r
library(paxtoolsr)
```

* List possible downloads


```r
downloadPc2()
```

* Download databases

```r
# Single databases
geneSets <- downloadPc2("PathwayCommons.8.Reactome.GSEA.hgnc.gmt.gz", version="8")
sif <- downloadPc2("PathwayCommons.8.kegg.EXTENDED_BINARY_SIF.hgnc.txt.gz", version="8")

# All databases 
geneSets <- downloadPc2("PathwayCommons.8.All.GSEA.hgnc.gmt.gz", version="8")
```

Filtering Pathway Commons Data 
===
class: smaller-75


```r
sif <- filterSif(sif$edges, ids=c("GPI"))

nrow(sif)
```

```
[1] 26
```

```r
colnames(sif)
```

```
[1] "PARTICIPANT_A"           "INTERACTION_TYPE"       
[3] "PARTICIPANT_B"           "INTERACTION_DATA_SOURCE"
[5] "INTERACTION_PUBMED_ID"   "PATHWAY_NAMES"          
[7] "MEDIATOR_IDS"           
```

```r
head(sif[, 1:3, with=FALSE], 2)
```

```
   PARTICIPANT_A       INTERACTION_TYPE PARTICIPANT_B
1:           GPI     catalysis-precedes         ADPGK
2:           GPI controls-production-of   CHEBI:17665
```

Visualize Pathway Commons Data
===
class: smaller-50


```r
library(igraph); library(data.table) # SIF files read as data.table for speed

setDF(sif) # Convert data.table to data.frame 

# graph.edgelist requires a matrix
g <- graph.edgelist(as.matrix(sif[, c(1, 3)]), directed = FALSE)
plot(g, layout = layout.fruchterman.reingold)
```

![plot of chunk unnamed-chunk-5](paxtoolsr-figure/unnamed-chunk-5-1.png)

ID Conversion Using the Chemical Translation Service
===
class: smaller-75


```r
library(webchem)

cts_convert('16-hydroxypalmitate', 'Chemical Name', 'ChEBI')
```

```
$`16-hydroxypalmitate`
[1] "CHEBI:55328" "CHEBI:55329"
```

Get Metabolite Interactions (1)
===
class: smaller

* Load Example Metabolite ChEBI IDs

```r
metab <- read.table("example_chebi.txt", sep="\t", header=TRUE, quote="", comment.char="", stringsAsFactors=FALSE)
```

Get Metabolite Interactions (2)
===
class: smaller-50 


```r
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
```

```
  PARTICIPANT_A          INTERACTION_TYPE PARTICIPANT_B
1   CHEBI:15422 consumption-controlled-by         ADCY3
2   CHEBI:15422           used-to-produce   CHEBI:15996
  INTERACTION_DATA_SOURCE INTERACTION_PUBMED_ID
1                    KEGG                    NA
2                    KEGG                    NA
                          PATHWAY_NAMES
1                     Purine metabolism
2 Metabolic pathways, Purine metabolism
```

```r
tmp <- c(purineOnlySif[, 1], purineOnlySif[, 3])
idx <- which(!grepl("^CHEBI:", tmp))

resKegg <- sort(table(tmp[idx]))
length(resKegg)
```

```
[1] 93
```

Enrichment Analysis with Pathway Commons and CellMiner
===
class: smaller-50

* Example on conducting an enrichment analysis on CellMiner cell line data using gene sets from Pathway Commons


```r
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
```

```
[1] 0
```

Interactive Pathway Commons Applications using rcytoscapejs 
===
class: center-img

* CytoscapeJS for embedding in [Shiny](http://shiny.rstudio.com/) applications
* Code Repository: https://github.com/cytoscape/r-cytoscape.js
* Demo in `inst/examples/shinyPCViz`

<img src="img/shiny_pcviz.png" height="400px" />

Getting Help
===
class: smaller 

* paxtoolsr: Bioconductor
 * http://bioconductor.org/packages/release/bioc/html/paxtoolsr.html
* paxtoolsr Installation Videos
 * https://youtu.be/lUwP6KncMOo?list=PLpNSl8ajNxXy0fg2YIG5wa5zAV_vh1ULV
* BioPAX Google Group
 * http://groups.google.com/group/biopax
* Pathway Commons Google Group
 * http://groups.google.com/group/pathway-commons-help
* rcytoscapejs
 * https://github.com/cytoscape/r-cytoscape.js

Acknowledgements
===
class: smaller-75

* Dana-Farber Cancer Institute
 * Augustin Luna
 * Chris Sander
* Bilkent University
 * Ugur Dogrusoz 

*** 

* University of Toronto
 * Jeffrey Wong
 * Igor Rodchenkov
 * Gary Bader 
* Oregon Health Sciences University
 * Ozgun Babur
 * Emek Demir
