#' @title Estimate and adjust for brain cell type proportions in bulk expression data.
#' @description This function uses a linear model to adjust each row of gene expression for cell types. Other covariates can be included as well.
#' @param inputMat Input gene expression data, with rows as features (e.g. genes) and samples as columns.
#' @param celltypes Character vector of which cell types to estimate and adjust for.
#' @param species By default, this function uses markers from combined human and mouse measurements, which are the most robust and reliable, as the gene expression patterns are very conserved between these two species. Other options are "human" and "mouse" for data specific to those species. Note that OPCs only have 500 gene symbols in this case, and are taken from only the Darmanis et al or Tasic et al data sets, respectively.
#' @param addMeans Whether the mean should be added to the residuals in the resulting adjusted gene expression table.
#' @param nMarker The number of marker genes (that are present in your expression data set) to use in estimating the surrogate cell type proportion variable for each cell type.
#' @param formula If you want to add additional covariates to be adjusted for, then you can supply them by adding an (optional) formula function here. The format should be "expression_data ~ $cov1 + factor($cov2) +", where $cov1 is a numeric covariate present in the current environment, and $cov2 is a factor variable also defined in the current environment.
#' @param verbose Whether to report the formula used for adjustment of each row.
#' @return A list containing both a matrix of estimate surrogate proportion variables (SPVs), as well as a matrix of adjusted gene expression values.
#' @examples
#'\dontrun{
#' brain_cells_adjusted = adjustBrainCells(aba_marker_expression,
#'   nMarker = 50, species = "combined")
#' expression_data_adj = brain_cells_adjusted$expression
#' cor_mic_unadj = cor.test(as.numeric(aba_marker_expression["AIF1", ]),
#'   as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
#' cor_mic_adj = cor.test(expression_data_adj["AIF1", ],
#'   as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
#'}
#' @export
adjustBrainCells <- function(inputMat, nMarker = 50, species = "combined",
  celltypes = c("ast", "end", "mic", "neu", "oli", "opc"), addMeans = FALSE, formula = NULL, verbose = FALSE){

  svp_res = brainCells(inputMat = inputMat, nMarker = nMarker,
      species = species, celltypes = celltypes)

  adjust_res = adjustCells(inputMat = inputMat, cellSPV = svp_res,
    addMeans = addMeans, formula = formula)

  return(list(
    SVPs = svp_res,
    expression = adjust_res))

}
