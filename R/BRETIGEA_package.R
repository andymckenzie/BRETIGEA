#' BRETIGEA: BRain cEll Type specIfic Gene Expression Analysis
#'
#' This package provides two major functions:
#' 1) A function to estimate cell type surrogate proportion variables based on marker genes.
#' 2) A function to adjust bulk gene expression data for estimated cell type proportions, as covariates.
#' It also provides data containing estimated marker genes for six major brain cell types, i.e. astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and oligodendrocyte precursor cells (OPCs), as well as wrapper functions to use this data on the two major package functions.
#'
#' @docType package
#' @name BRETIGEA
#' @importFrom stats as.formula cor prcomp predict residuals
#' @importFrom utils head str
"_PACKAGE"
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
#' @references Mckenzie AT, Wang M, Hauberg ME, et al. Brain Cell Type Specific Gene Expression and Co-expression Network Architectures. Sci Rep. 2018;8(1):8868.
"markers_df_brain"

#' @title Marker genes estimated from a meta-analysis of brain cell gene expression data from humans only.
#' @description Top 1000 marker genes from each of the six major brain cell types (ie astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and OPCs) estimated from a meta-analysis of brain cell gene expression data from humans only.
#' @references Mckenzie AT, Wang M, Hauberg ME, et al. Brain Cell Type Specific Gene Expression and Co-expression Network Architectures. Sci Rep. 2018;8(1):8868.
"markers_df_human_brain"

#' @title Marker genes estimated from
#' @description Top 1000 marker genes from each of four major brain cell types (ie astrocytes, microglia, neurons, and oligodendrocytes) estimated via correlation-based analysis of bulk brain tissue. Contains marker data averaged across all brain regions as well as markers derived from individual brain regions.
#' @references Kelley KW, Nakao-inoue H, Molofsky AV, Oldham MC. Variation among intact tissue samples reveals the core transcriptional features of human CNS cell classes. Nat Neurosci. 2018;21(9):1171-1184.
"kelley_df_brain"

#' @title Marker genes estimated from a meta-analysis of brain cell gene expression data from mice only.
#' @description Top 1000 marker genes from each of the six major brain cell types (ie astrocytes, endothelial cells, microglia, neurons, oligodendrocytes, and OPCs) estimated from a meta-analysis of brain cell gene expression data from mice only.
#' @references Mckenzie AT, Wang M, Hauberg ME, et al. Brain Cell Type Specific Gene Expression and Co-expression Network Architectures. Sci Rep. 2018;8(1):8868.
"markers_df_mouse_brain"
