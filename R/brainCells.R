#' @title Estimate brain cell type proportions in bulk expression data with marker genes.
#' @description This function uses marker genes estimated in a meta-analysis of brain cell type-associated RNA expression data sets, and uses them as input for the findCells cell type proportion estimation procedure pipeline.
#' @param inputMat Gene expression data frame or matrix, with rownames corresponding to gene names, some of which are marker genes, and columns corresponding to samples.
#' @param nMarker The number of marker genes (that are present in your expression data set) to use in estimating the surrogate cell type proportion variable for each cell type.
#' @param species By default, this function uses markers from combined human and mouse measurements, which are the most robust and reliable, as the gene expression patterns are very conserved between these two species. Other options are "human" and "mouse" for data specific to those species. Note that OPCs only have 500 gene symbols in this case, and are taken from only the Darmanis et al or Tasic et al data sets, respectively.
#' @param method To estimate the cell type proportions, can either use PCA or SVD.
#' @param scale Whether or not to scale the gene expression data from each marker gene prior to using it as an input for dimension reduction.
#' @param celltypes Character vector of which cell types to estimate.
#' @return A sample-by-cell type matrix of estimate cell type proportion variables.
#' @examples
#'\dontrun{
#' ct_res = brainCells(aba_marker_expression, nMarker = 50, species = "combined")
#' cor.test(ct_res[, "mic"], as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
#'}
#' @export
brainCells <- function(inputMat, nMarker = 50, species = "combined",
  celltypes = c("ast", "end", "mic", "neu", "oli", "opc"), method = "SVD", scale = TRUE){

  if(species == "combined"){
    markers_brain = BRETIGEA::markers_df_brain
  }
  if(species == "human"){
    markers_brain = BRETIGEA::markers_df_human_brain
  }
  if(species == "mouse"){
    markers_brain = BRETIGEA::markers_df_mouse_brain
  }

  if(!any(markers_brain$markers %in% rownames(inputMat))) stop("At least one marker gene symbol must be present in the rownames of the input matrix.")

  if(!method %in% c("SVD", "PCA")) stop("The method argument must be either SVD or PCA.")

  if(!all(celltypes %in% c("ast", "end", "mic", "neu", "oli", "opc"))) stop("All celltypes must be one of ast, end, mic, neu, oli, and/or opc.")

  markers_brain = markers_brain[markers_brain$cell %in% celltypes, ]

  prop_res = findCells(inputMat = inputMat, markers = markers_brain, nMarker = nMarker,
    method = method, scale = scale)

  return(prop_res)

}
