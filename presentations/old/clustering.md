Introduction to Clustering
====
author: Augustin Luna (lunaa@jimmy.harvard.edu)
date: University of Sao Paulo, 09 January, 2016
autosize: true
width: 960
height: 700
css: rpres.css

<div class="footer"><img src="img/dfci_logo.gif" height="60px" width="330px" /></div>

Outline
====
* Clustering 
 * K-Means Clustering
 * Hierarchical Clustering

Scree Test
====
eu

Hierarchical Clustering: Basic Algorithm
====
* Hierarchical Clustering can be agglomerative (bottom up) or divise (top down)
* Agglomerative: 
 1. The two nearest nodes are merged into a single node 
 2. thuet 
 3. euo
* Divise: Similiar to agglomerative but in reverse

Hierarchical Clustering and Linkage
====
* eetouh
* Options of Cluster Linkage Distances
 * Single: Distance between clusters is defined by the distance between the two closest points. 
 * Average: Distance 
 * Complete: 
* hclust() in R uses the "complete" method by default

Slide With Plot
====

<img src="clustering-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="600px" height="600px" style="display: block; margin: auto;" />

Code Only Slide
====

```r
summary(cars)
predict(model, newdata=data.frame(Units=4))
predict(model, newdata=data.frame(Units=4), interval = "pred")
predict(model, newdata=data.frame(Units=4), interval = "confidence")
```

Output Only Slide
====
| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
| 12 | 12 | 12 | 12 |
| 123 | 123 | 123 | 123 |
| 1 | 1 | 1 | 1 |


```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Slide With Image Left
====
![logo](img/dfci_logo.gif)
***
The equation is $\frac{1}{n} \sum_{i=i}^{n} x_{i}$


Two-Column Slide
====
left: 70%

First Column 

For more details on autoring R presentations please visit authoring R presentations please visit

<img src="clustering-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="800px" style="display: block; margin: auto;" />
***
Second column

For more details on authoring R presentations please visit authoring R presentations please visit
