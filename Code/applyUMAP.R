#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidymodels))
suppressPackageStartupMessages(library(embed))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(stringr))

##### Helpers #####
checkNames <- function(data, model){
  
  sum(data %>% names %in% (model %>% pluck("template") %>% select(-UMAP1, -UMAP2) %>% names())) < 8
  
}
makeNumeric <- function(data, model){
  
  data %>% mutate(across(any_of(names(model[["template"]])), ~as.numeric(str_replace_all(.x, "<|>", ""))))
  
}
addGap <- function(data){
  
  data %>% mutate(anion_gap = ifelse("anion_gap" %in% names(data), anion_gap, sodium - chloride - co2_totl))
  
}

##### Apply Model #####
model <- bundle::unbundle(readRDS("/home/Model/UMAP_bmp_results_20230208")) |> prep()

data <- read_delim("/bmp_umap/Data/input_file.tsv", show_col_types = FALSE)
if (checkNames(data, model)){
  stop("Incorrect File Header. Must contain columns for named 'sodium', 'chloride', 'potassium_plas', 'co2_totl', 'bun', 'creatinine', 'calcium', 'glucose'")
}

data <- makeNumeric(data, model) |> addGap() |> na.omit()

embed <- model |> bake(data)

filename <- paste0("/bmp_umap/umap_output_", round(as.numeric(Sys.time())), ".tsv")
write_tsv(embed, filename)
