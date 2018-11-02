
library(devtools)
library(HGNChelper)
#Downloaded from http://oldhamlab.ctec.ucsf.edu/ on 11/2/2018
marker_data = read.csv("data-raw/ALL_Fidelity.csv")

switch_to_HGCN_where_possible <- function(gene_list){
	gene_listHGNC = suppressWarnings(checkGeneSymbols(gene_list))
	to_change = which((gene_listHGNC$Approved == FALSE) &
		!is.na(gene_listHGNC$Suggested.Symbol))
	gene_list[to_change] = gene_listHGNC[to_change, ]$Suggested.Symbol
	gene_list = toupper(gene_list)
	gene_list[which(gene_list == "MT-CO1 /// PTGS1")] = "PTGS1"
	gene_list[which(gene_list == "LBHD1 /// C11orf98")] = "LBHD1"
	return(gene_list)
}

marker_data$Gene_name = switch_to_HGCN_where_possible(marker_data$Gene)

#str(markers_df_brain)
# 'data.frame':	6000 obs. of  2 variables:
#  $ markers: chr  "AQP4" "ALDH1L1" "BMPR1B" "SLC14A1" ...
#  $ cell   : chr  "ast" "ast" "ast" "ast" ...

marker_types = c("ALL_Astrocyte", "ALL_Oligodendrocyte",
"ALL_Microglia", "ALL_Neuron", "CTX_Astrocyte", "CTX_Oligodendrocyte",
"CTX_Microglia", "CTX_Neuron", "AMY_Astrocyte", "AMY_Oligodendrocyte",
"AMY_Microglia", "AMY_Neuron", "BF_Astrocyte", "BF_Oligodendrocyte",
"BF_Microglia", "BF_Neuron", "CB_Astrocyte", "CB_Oligodendrocyte",
"CB_Microglia", "CB_Neuron", "CLA_Astrocyte", "CLA_Oligodendrocyte",
"CLA_Microglia", "CLA_Neuron", "DI_Astrocyte", "DI_Oligodendrocyte",
"DI_Microglia", "DI_Neuron", "FCX_Astrocyte", "FCX_Oligodendrocyte",
"FCX_Microglia", "FCX_Neuron", "GP_Astrocyte", "GP_Oligodendrocyte",
"GP_Microglia", "GP_Neuron", "HIP_Astrocyte", "HIP_Oligodendrocyte",
"HIP_Microglia", "HIP_Neuron", "IN_Astrocyte", "IN_Oligodendrocyte",
"IN_Microglia", "IN_Neuron", "LIM_Astrocyte", "LIM_Oligodendrocyte",
"LIM_Microglia", "LIM_Neuron", "MED_Astrocyte", "MED_Oligodendrocyte",
"MED_Microglia", "MED_Neuron", "MID_Astrocyte", "MID_Oligodendrocyte",
"MID_Microglia", "MID_Neuron", "OCX_Astrocyte", "OCX_Oligodendrocyte",
"OCX_Microglia", "OCX_Neuron", "PCX_Astrocyte", "PCX_Oligodendrocyte",
"PCX_Microglia", "PCX_Neuron", "PON_Astrocyte", "PON_Oligodendrocyte",
"PON_Microglia", "PON_Neuron", "SC_Astrocyte", "SC_Oligodendrocyte",
"SC_Microglia", "SC_Neuron", "STR_Astrocyte", "STR_Oligodendrocyte",
"STR_Microglia", "STR_Neuron", "TCX_Astrocyte", "TCX_Oligodendrocyte",
"TCX_Microglia", "TCX_Neuron", "WM_Astrocyte", "WM_Oligodendrocyte",
"WM_Microglia", "WM_Neuron")

marker_type_names = gsub("Astrocyte", "ast", marker_types)
marker_type_names = gsub("Oligodendrocyte", "oli", marker_type_names)
marker_type_names = gsub("Microglia", "mic", marker_type_names)
marker_type_names = gsub("Neuron", "neu", marker_type_names)
marker_type_names = gsub("ALL_", "", marker_type_names)

n_markers = 1000

for(i in 1:length(marker_types)){
  top_markers = marker_data[order(marker_data[ , marker_types[i]], decreasing = TRUE), "Gene_name"]
  tmp_markers_top = head(top_markers, n_markers)
  tmp_df = data.frame(markers = tmp_markers_top, cell = rep(marker_type_names[i], length.out = n_markers))
  if(i == 1){
    kelley_df_brain = tmp_df
  } else {
    kelley_df_brain = rbind(kelley_df_brain, tmp_df)
  }
}

setwd("/Users/amckenz/Documents/packages/BRETIGEA")
devtools::use_data(kelley_df_brain, overwrite = TRUE)
