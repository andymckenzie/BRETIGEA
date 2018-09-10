#' @title Adjust for estimated cell type proportions in bulk gene expression data.
#' @description This function uses a linear model to adjust each row of gene expression for cell types, taking the residuals from the linear model for downstream analysis. Other covariates can be included as well, if they are defined in the current environment, through the use of the formula argument.
#' @param inputMat Input gene expression data, with rows as features (e.g. genes) and samples as columns.
#' @param cellSPV Estimated matrix of surrogate proportion variables for each cell type, with samples as rows and columns as cell types.
#' @param celltypes Character vector of which cell types to use. Must correspond to column names in the cellSPV data frame. If NULL, all of the columns of SPV will be used for adjustment.
#' @param addMeans Whether the mean should be added to the residuals in the resulting adjusted gene expression table.
#' @param formula If you want to add additional covariates to be adjusted for, then you can supply them by adding an (optional) formula function here. The format should be "expression_data ~ $cov1 + factor($cov2) +", where $cov1 is a numeric covariate present in the current environment, and $cov2 is a factor variable also defined in the current environment.
#' @param verbose Whether to print out the formula used for adjustment of each row.
#' @return A matrix of adjusted gene expression values.
#' @examples
#'\dontrun{
#' svp_res = brainCells(inputMat = aba_marker_expression, nMarker = 10,
#'   species = "human", celltypes = c("ast", "neu", "oli"))
#' str(svp_res)
#' adjust_res = adjustCells(inputMat = aba_marker_expression,
#'   cellSPV = svp_res, addMeans = FALSE)
#' str(adjust_res)
#'}
#' @export
adjustCells <- function(inputMat, cellSPV, celltypes = NULL, addMeans = FALSE, formula = NULL, verbose = FALSE) {

	if(is.null(formula)) formula = "expression_data ~ "

	for(i in 1:ncol(cellSPV)){
		if(!is.null(celltypes) & !colnames(cellSPV)[i] %in% celltypes) next
		if(i == 1){
			formula = paste0(formula, colnames(cellSPV)[i])
		} else {
			formula = paste(formula, colnames(cellSPV)[i], sep = "+")
		}
		assign(colnames(cellSPV)[i], cellSPV[, i])
	}

	if(verbose) print(paste0("Adjustment formula for each row being used is... ", formula))

	get_residuals <- function(expression_data){

		lm.obj = do.call("lm", list(as.formula(formula),
			na.action = "na.exclude", singular.ok = TRUE))
		if(addMeans) resid.data = pmax(mean(expression_data) + expression_data - predict(lm.obj), 0)
		if(!addMeans) resid.data = residuals(lm.obj)
		return(resid.data)

	}

	resid_mean = apply(inputMat, 1, get_residuals)

	resid = t(resid_mean)

	return(resid)

}
