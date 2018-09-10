#' BRETIGEA: BRain cEll Type specIfic Gene Expression Analysis
#'
#' This package provides two major functions:
#' 1) A function to estimate cell type surrogate proportion variables based on marker genes.
#' 2) A function to adjust bulk gene expression data for estimated cell type proportions, as covariates.
#' It also provides data containing estimated marker genes for six major brain cell types, i.e. astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and oligodendrocyte precursor cells (OPCs), as well as wrapper functions to use this data on the two major package functions.
#' The first two functions comprise the discovery of differential correlation (ddcor) portion of the package, which is why the names of the functions and object names often begin with ddcor.
#' Note that DGCA makes use of the 	SAF = getOption("stringsAsFactors"); on.exit(options(stringsAsFactors = SAF)); options(stringsAsFactors = FALSE) design pattern many times in order to avoid errors related to stringsAsFactors in porting code to new environments. This should not affect the stringsAsFactors options in your environment; however, you may want to be aware of this.
#'
#' @docType package
#' @name BRETIGEA
#' @importFrom stats as.formula cor prcomp predict residuals
#' @importFrom utils head str
NULL
#> NULL

#' @title Normalized FPKM expression data from a subset of the Allen Brain Atlas Aging, Dementia, and TBI study.
#' @description Filtered data set to only contain brain marker genes as well as ~100 other genes. The total data set can be downloaded by following the links in the original paper.
#' @references © 2016 Allen Institute for Cell Science. Aging, Dementia and TBI. Available from: http://aging.brain-map.org/
"aba_marker_expression"

#' @title Phenotype data from brain samples in the Allen Brain Atlas Aging, Dementia, and TBI study.
#' @description A subset of phenotype data to be used for correlations with the expression data in the tests and vignette, to validate that the estimated cell type proportions correspond to useful quantities.
#' @references © 2016 Allen Institute for Cell Science. Aging, Dementia and TBI. Available from: http://aging.brain-map.org/
"aba_pheno_data"

#' @title Marker genes estimated from a meta-analysis of brain cell gene expression data from both humans and mice.
#' @description Top 1000 marker genes from each of the six major brain cell types (ie astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and OPCs) estimated from a meta-analysis of brain cell gene expression data from both humans and mice.
#' @references McKenzie, Wang, et al. In preparation.
"markers_df_brain"

#' @title Marker genes estimated from a meta-analysis of brain cell gene expression data from humans only.
#' @description Top 1000 marker genes from each of the six major brain cell types (ie astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and OPCs) estimated from a meta-analysis of brain cell gene expression data from humans only.
#' @references McKenzie, Wang, et al. In preparation.
"markers_df_human_brain"

#' @title Marker genes estimated from a meta-analysis of brain cell gene expression data from mice only.
#' @description Top 1000 marker genes from each of the six major brain cell types (ie astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and OPCs) estimated from a meta-analysis of brain cell gene expression data from mice only.
#' @references McKenzie, Wang, et al. In preparation.
"markers_df_mouse_brain"
