## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  comment = "", 
  echo = TRUE
)

# Load the packages
library(dplyr)
library(ggplot2)
library(volker)

# Set the basic plot theme
theme_set(theme_bw())

## ----include=FALSE------------------------------------------------------------

# Load example data from the package
data <- volker::chatgpt


## -----------------------------------------------------------------------------
# A single variable
tab_counts(data, use_private)

## -----------------------------------------------------------------------------
# A list of variables
tab_counts(data, c(use_private, use_work))

## -----------------------------------------------------------------------------
# Variables matched by a pattern
tab_counts(data, starts_with("use_"))

## -----------------------------------------------------------------------------
# One metric variable
tab_metrics(data, sd_age)

## ----fig.width=6, fig.height=8------------------------------------------------

# Multiple metric items
tab_metrics(data, starts_with("cg_adoption_"))
plot_metrics(data, starts_with("cg_adoption_"))


## -----------------------------------------------------------------------------
tab_counts(data, adopter, sd_gender)

## -----------------------------------------------------------------------------
data |> 
  filter(sd_gender != "diverse") |> 
  plot_counts(adopter, sd_gender, prop="rows", numbers="p")

## -----------------------------------------------------------------------------
# Compare the means of one variable
tab_metrics(data, sd_age, sd_gender)

## -----------------------------------------------------------------------------
# Compare the means of multiple items
tab_metrics(data, starts_with("cg_adoption_"), sd_gender)

## -----------------------------------------------------------------------------

data %>% 
  filter(sd_gender != "diverse") %>% 
  report_metrics(starts_with("cg_adoption_"), sd_gender)


## -----------------------------------------------------------------------------
data %>% 
  filter(sd_gender != "diverse") %>% 
  report_counts(adopter, sd_gender, prop="rows", title= FALSE, close= FALSE)

## -----------------------------------------------------------------------------
codebook(data)

## -----------------------------------------------------------------------------
newlabels <- tribble(
  ~item_name, ~item_label,
  "cg_adoption_advantage_01", "Allgemeine Vorteile",
  "cg_adoption_advantage_02", "Finanzielle Vorteile",
  "cg_adoption_advantage_03", "Vorteile bei der Arbeit",
  "cg_adoption_advantage_04", "Macht mehr Spaß"
)

data %>%
  labs_apply(newlabels) %>%
  tab_metrics_items(starts_with("cg_adoption_advantage_"))



## -----------------------------------------------------------------------------
data %>%
  labs_clear(everything()) %>%
  tab_counts(starts_with("cg_adoption_advantage_"))

## -----------------------------------------------------------------------------
data %>%
  tab_counts(starts_with("cg_adoption_advantage_"), labels= FALSE)

## -----------------------------------------------------------------------------
data %>%
  idx_add(starts_with("cg_adoption_")) %>%
  tab_metrics(idx_cg_adoption)

## -----------------------------------------------------------------------------
data %>%
  idx_add(starts_with("cg_adoption_")) %>%
  tab_metrics(idx_cg_adoption, adopter)

## -----------------------------------------------------------------------------
data %>%
  idx_add(starts_with("cg_adoption_")) %>%
  idx_add(starts_with("cg_adoption_advantage")) %>%
  idx_add(starts_with("cg_adoption_fearofuse")) %>%
  idx_add(starts_with("cg_adoption_social")) %>%
  tab_metrics(starts_with("idx_cg_adoption"))

