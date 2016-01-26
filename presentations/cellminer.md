
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


Introduction to CellMiner
===
author: Augustin Luna
date: 26 January, 2016
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

Topics to be Covered
===
* Introduction to CellMiner
* Introduction to rcellminer

What is CellMiner?
===
class: smaller-75 

* Website: 
 * http://discover.nci.nih.gov/cellminer
* Retrieval and integration for NCI-60 datasets: molecular and pharmacological
* NCI-60
 * 60 human cancer cell lines from 9 tissues of origin: breast, central nervous system, colon, leukemia, melanoma, non-small cell lung, ovarian, prostate, and renal
 * Used by the Developmental Therapeutics Program of the National Cancer Institute to screen over 100,000 chemical compounds and natural products
* A subset of ~21,000 drugs is provided by CellMiner 
* Drug activity levels expressed as 50% growth-inhibitory levels (GI50) were determined at 48 hours using the sulforhodamine B (SRB) assay
 * Determines cell density based on the measurement of total cellular protein content
 
What is rcellminer?
===
class: smaller 

* Website and Tutorial (Vignette):
 * https://www.bioconductor.org/packages/release/bioc/html/rcellminer.html
* Publication: 
 * http://www.ncbi.nlm.nih.gov/pubmed/26635141
* Provides programmatic access to CellMiner NCI-60 data
* Data Types
 * Gene and protein expression, copy number, whole exome mutations, etc
 * Activity data for ~21K compounds and information on their structure, mechanism of action, and repeat screens
* Easy visualization of compound structures, activity patterns, and molecular feature profiles
* Embedded R Shiny applications allow interactive data exploration

Pattern Comparison using rcellminer
===
class: smaller-50


```r
library(rcellminer)

# Get drug and expression data
drugAct <- exprs(getAct(rcellminerData::drugData))
expData <- getAllFeatureData(rcellminerData::molData)[["exp"]]

# Create pattern of interest
patternOfInterest <- expData["SLFN11", ]

# Run pattern comparison to get correlated drugs and other gene expressions
r1 <- patternComparison(patternOfInterest, drugAct)
r2 <- patternComparison(patternOfInterest, expData)

head(r1, 3)
```

```
             COR         PVAL
639174 0.8343842 1.227589e-16
681636 0.7967239 1.243962e-13
34462  0.7950691 3.302182e-14
```

```r
head(r2, 3)
```

```
              COR         PVAL
SLFN11  1.0000000 0.000000e+00
BCAT1   0.5847423 9.298535e-07
CCDC181 0.5766713 1.419268e-06
```

Embedded Shiny Applications
===
* Simplified web applications to do common data exploration tasks
 * Compare any two molecular and drug profiles 
 * Find related structures 
 * View information on repeat screening for drug compounds

Getting Help
===
* CellMiner
 * webadmin@discover.nci.nih.gov
* rcellminer 
 * Augustin Luna: aluna [AT] jimmy [DOT] harvard [DOT] edu 
 * Vinodh Rajapakse: vinodh [DOT] rajapakse [AT] nih [DOT] gov 
 
