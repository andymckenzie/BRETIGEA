context("running adjustCells")

test_that("findCells accurately estimates cell type proportions on the ABA data with combined data", {

  brain_cells_adjusted = adjustBrainCells(aba_marker_expression, nMarker = 50, species = "combined")
  expression_data_adj = brain_cells_adjusted$expression

  cor_mic_unadj = cor.test(as.numeric(aba_marker_expression["AIF1", ]), as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
  cor_mic_adj = cor.test(expression_data_adj["AIF1", ], as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")

  expect_equal(as.numeric(round(cor_mic_unadj$estimate, 2)), 0.3, info = "AIF1/IBA1 correlate on unadjusted data")
  expect_equal(as.numeric(round(cor_mic_adj$estimate, 2)), 0, info = "AIF1/IBA1 do not correlate on adjusted data")

  cor_ast_unadj = cor.test(as.numeric(aba_marker_expression["GFAP", ]), as.numeric(aba_pheno_data$ihc_gfap_ffpe), method = "spearman")
  cor_ast_adj = cor.test(expression_data_adj["GFAP", ], as.numeric(aba_pheno_data$ihc_gfap_ffpe), method = "spearman")

  expect_equal(as.numeric(round(cor_ast_unadj$estimate, 2)), 0.48, info = "GFAP/GFAP correlate on unadjusted data")
  expect_equal(as.numeric(round(cor_ast_adj$estimate, 2)), 0.06, info = "GFAP/GFAP do not correlate on adjusted data")

})
