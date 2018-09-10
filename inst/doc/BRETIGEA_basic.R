## ---- results="hide", warning=FALSE, message=FALSE-----------------------
library(BRETIGEA, quietly = TRUE)
library(knitr) #only used for vignette creation

## ---- message = FALSE----------------------------------------------------
str(aba_marker_expression, list.len = 5)
str(aba_pheno_data, list.len = 5)

## ---- message = FALSE----------------------------------------------------
ct_res = brainCells(aba_marker_expression, nMarker = 50)
kable(head(ct_res))

## ---- fig.width = 7, fig.height = 7, message = FALSE, warning = FALSE----
cor_mic = cor.test(ct_res[, "mic"], as.numeric(aba_pheno_data$ihc_iba1_ffpe),
  method = "spearman")
print(cor_mic)
cor_ast = cor.test(ct_res[, "ast"], as.numeric(aba_pheno_data$ihc_gfap_ffpe),
  method = "spearman")
print(cor_ast)

## ---- message = FALSE----------------------------------------------------
ct_res = brainCells(aba_marker_expression, nMarker = 50, species = "combined",
  method = "PCA")
kable(head(ct_res))

## ---- message = FALSE----------------------------------------------------
ct_res = brainCells(aba_marker_expression, nMarker = 50, species = "combined",
  celltypes = c("ast", "neu", "oli"))
kable(head(ct_res))

## ---- fig.width = 6, fig.height = 5, message = FALSE, warning = FALSE----
str(markers_df_brain)
ct_res = findCells(aba_marker_expression, markers = markers_df_brain, nMarker = 50)
kable(head(ct_res))

## ---- fig.width = 6, fig.height = 5, message = FALSE, warning = FALSE----
brain_cells_adjusted = adjustBrainCells(aba_marker_expression,
    nMarker = 50, species = "combined")
expression_data_adj = brain_cells_adjusted$expression

## ---- fig.width = 6, fig.height = 5, message = FALSE, warning = FALSE----
cor.test(as.numeric(aba_marker_expression["AIF1", ]),
  as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
cor.test(expression_data_adj["AIF1", ], as.numeric(aba_pheno_data$ihc_iba1_ffpe),
  method = "spearman")

cor.test(as.numeric(aba_marker_expression["GFAP", ]), as.numeric(aba_pheno_data$ihc_gfap_ffpe),
  method = "spearman")
cor.test(expression_data_adj["GFAP", ], as.numeric(aba_pheno_data$ihc_gfap_ffpe),
  method = "spearman")

