## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  echo = F,
  knitr.table.format = "html"
)

library(tidyverse)
library(volker)

## -----------------------------------------------------------------------------

# Load data 
ds <- volker::chatgpt

## -----------------------------------------------------------------------------

effect_counts(ds, adopter, sd_gender)
effect_metrics(ds, sd_age, adopter)
effect_metrics(ds, sd_age, use_private, metric=T)
effect_metrics(ds, sd_age, use_private, metric=T)

