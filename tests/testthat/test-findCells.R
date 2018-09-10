context("running findCells")

test_that("findCells accurately estimates cell type proportions on the ABA data with combined data", {

	expect_identical(colnames(aba_marker_expression), aba_pheno_data$id, "Test data sample IDs match")

	ct_res = brainCells(aba_marker_expression, nMarker = 50, species = "combined")
	cor_mic = cor.test(ct_res[, "mic"], as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
	cor_ast = cor.test(ct_res[, "ast"], as.numeric(aba_pheno_data$ihc_gfap_ffpe), method = "spearman")

	expect_equal(as.numeric(round(cor_mic$estimate, 2)), 0.33, info = "Microglia proportion estimation works")
	expect_equal(as.numeric(round(cor_ast$estimate, 2)), 0.48, info = "Astrocyte proportion estimation works")

	ct_res_marker_df = findCells(aba_marker_expression, markers = markers_df_brain, nMarker = 50)

	expect_identical(ct_res, ct_res_marker_df, "alternative interface to findCells works the same")

})

test_that("findCells accurately estimates cell type proportions on the ABA data with human data and without scaling", {

	ct_res = brainCells(aba_marker_expression, nMarker = 50, species = "human", scale = FALSE)
	cor_mic = cor.test(ct_res[, "mic"], as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
	cor_ast = cor.test(ct_res[, "ast"], as.numeric(aba_pheno_data$ihc_gfap_ffpe), method = "spearman")

	expect_equal(as.numeric(round(cor_mic$estimate, 2)), 0.33, info = "Microglia proportion estimation works")
	expect_equal(as.numeric(round(cor_ast$estimate, 2)), 0.46, info = "Astrocyte proportion estimation works")

})

test_that("findCells accurately estimates cell type proportions on the ABA data with fewer markers and using PCA", {

	ct_res = brainCells(aba_marker_expression, nMarker = 10, species = "combined", method = "PCA")
	cor_mic = cor.test(ct_res[, "mic"], as.numeric(aba_pheno_data$ihc_iba1_ffpe), method = "spearman")
	cor_ast = cor.test(ct_res[, "ast"], as.numeric(aba_pheno_data$ihc_gfap_ffpe), method = "spearman")

	expect_equal(as.numeric(round(cor_mic$estimate, 2)), 0.27, info = "Microglia proportion estimation works")
	expect_equal(as.numeric(round(cor_ast$estimate, 2)), 0.48, info = "Astrocyte proportion estimation works")

})
