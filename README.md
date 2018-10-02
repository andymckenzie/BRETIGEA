[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/ggplot2)](https://cran.r-project.org/package=BRETIGEA)
[![Rdoc](http://www.rdocumentation.org/badges/version/BRETIGEA)](http://www.rdocumentation.org/packages/BRETIGEA)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/BRETIGEA)](http://cranlogs.r-pkg.org/badges/grand-total/BRETIGEA)

# BRETIGEA

The goal of BRETIGEA (BRain cEll Type specIfic Gene Expression Analysis) is to estimate and/or deconvolute relative cell type proportions from bulk gene expression data.

BRETIGEA simplifies the process of defining your own set of brain cell type marker genes by using a well-validated set of cell type-specific marker genes derived from multiple types of experiments, as described in our manuscript, [McKenzie and Wang et al 2018](https://www.ncbi.nlm.nih.gov/pubmed/29892006). For brain tissue data sets, there are marker genes available for astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and oligodendrocyte precursor cells, derived from each of human, mice, and combination human/mouse data sets. However, if you have access to your own marker genes, the functions can be applied to bulk gene expression data from any tissue.

BRETIGEA also implements multiple options for relative cell type proportion estimation using these marker genes, adapting and expanding on approaches from the 'CellCODE' R package described in [Chikina et al 2015](https://www.ncbi.nlm.nih.gov/pubmed/25583121). The number of cell type marker genes used in a given analysis can be increased or decreased based on your preferences and the data set. Finally, BRETIGEA provides functions to use the estimates to adjust for variability in the relative proportion of cell types across samples (i.e., deconvolute) prior to downstream analyses.

## Installation

You can install BRETIGEA from CRAN with:

```R
install.packages("BRETIGEA")
```

You can install the development version of BRETIGEA from Github with:

```R
# install.packages("devtools")
devtools::install_github("andymckenzie/BRETIGEA")
```

## Example

Using example data from the Allen Brain Atlas, a subset of which is available in the package.

```R
library(BRETIGEA)
library(knitr) #only for visualization
str(aba_marker_expression, list.len = 10) #input data format
str(aba_pheno_data) #input data format

ct_res = brainCells(aba_marker_expression, nMarker = 50)
kable(head(ct_res)) #output data format

cor_mic = cor.test(ct_res[, "mic"], as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
print(cor_mic)
cor_ast = cor.test(ct_res[, "ast"], as.numeric(aba_pheno_data$ihc_gfap_ffpe), method = "spearman")
print(cor_ast)
```

## Vignette

See the vignette in the inst/doc subdirectory for a more thorough example.

## Applications

You can view the manuscript describing BRETIGEA in detail as well as several applications here:

https://www.nature.com/articles/s41598-018-27293-5

## References

1. The data included in the testing portion of the package is from the Allen Brain Atlas Aging, Memory, and TBI study. Here is the reference:

© 2016 Allen Institute for Cell Science. Aging, Dementia and TBI. Available from: http://aging.brain-map.org/

2. Chikina M, Zaslavsky E, Sealfon SC. CellCODE: a robust latent variable approach to differential expression analysis for heterogeneous cell populations. Bioinformatics. 2015;31(10):1584-91.

3. McKenzie AT, Wang M, Hauberg ME, et al. Brain Cell Type Specific Gene Expression and Co-expression Network Architectures. Sci Rep. 2018;8(1):8868.
