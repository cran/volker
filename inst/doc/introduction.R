## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  comment = "", 
  echo = TRUE,
  message = FALSE,
  knitr.table.format = "html"
)


## ----warning=FALSE------------------------------------------------------------

# Load the package
library(volker)

# Set the basic plot theme
theme_set(theme_vlkr())

# Load an example dataset ds from the package
ds <- volker::chatgpt


## -----------------------------------------------------------------------------
# A single variable
tab_counts(ds, use_private)

## -----------------------------------------------------------------------------
# A list of variables
tab_counts(ds, c(use_private, use_work))

## -----------------------------------------------------------------------------
# Variables matched by a pattern
tab_counts(ds, starts_with("use_"))

## -----------------------------------------------------------------------------
# One metric variable
tab_metrics(ds, sd_age)

## ----fig.width=6, fig.height=8------------------------------------------------

# Multiple metric items
tab_metrics(ds, starts_with("cg_adoption_"))


## -----------------------------------------------------------------------------
tab_counts(ds, adopter, sd_gender)

## -----------------------------------------------------------------------------
# Compare the means of one grouping variable  (including the confidence interval)
tab_metrics(ds, sd_age, sd_gender, ci = TRUE)

## -----------------------------------------------------------------------------
# Correlate two metric variables
tab_metrics(ds, sd_age, use_work, metric = TRUE, ci = TRUE)

## -----------------------------------------------------------------------------
ds |> 
  filter(sd_gender != "diverse") |> 
  plot_counts(adopter, sd_gender, prop="rows", numbers="p")

## -----------------------------------------------------------------------------
ds |> 
  filter(sd_gender != "diverse") |> 
  effect_counts(adopter, sd_gender)

## -----------------------------------------------------------------------------

ds %>% 
  filter(sd_gender != "diverse") %>% 
  report_metrics(starts_with("cg_adoption_"), sd_gender, index=TRUE, box=TRUE, ci=TRUE)


## -----------------------------------------------------------------------------

#> ### Adoption types
#> 
#> ```{r echo=FALSE}
#> ds %>% 
#>   filter(sd_gender != "diverse") %>% 
#>   report_counts(adopter, sd_gender, prop="rows", title=FALSE, close=FALSE, box=TRUE, ci=TRUE)
#> ```
#>
#> ##### Method
#> Basis: Only male and female respondents.
#> 
#> #### {-}


## ----echo=FALSE---------------------------------------------------------------
ds %>% 
  filter(sd_gender != "diverse") %>% 
  report_counts(adopter, sd_gender, prop="rows", title=FALSE, close=FALSE, box=TRUE, ci=TRUE)

## -----------------------------------------------------------------------------
theme_set(theme_vlkr(
  base_fill = c("#F0983A","#3ABEF0","#95EF39","#E35FF5","#7A9B59"),
  base_gradient = c("#FAE2C4","#F0983A")
))


## -----------------------------------------------------------------------------
codebook(ds)

## -----------------------------------------------------------------------------
newlabels <- tribble(
  ~item_name, ~item_label,
  "cg_adoption_advantage_01", "Allgemeine Vorteile",
  "cg_adoption_advantage_02", "Finanzielle Vorteile",
  "cg_adoption_advantage_03", "Vorteile bei der Arbeit",
  "cg_adoption_advantage_04", "Macht mehr Spaß"
)

ds %>%
  labs_apply(newlabels) %>%
  tab_metrics_items(starts_with("cg_adoption_advantage_"))



## -----------------------------------------------------------------------------
ds %>%
  idx_add(starts_with("cg_adoption_")) %>%
  tab_metrics(idx_cg_adoption)

## -----------------------------------------------------------------------------
ds %>%
  idx_add(starts_with("cg_adoption_")) %>%
  tab_metrics(idx_cg_adoption, adopter)

## -----------------------------------------------------------------------------
ds %>%
  idx_add(starts_with("cg_adoption_")) %>%
  idx_add(starts_with("cg_adoption_advantage")) %>%
  idx_add(starts_with("cg_adoption_fearofuse")) %>%
  idx_add(starts_with("cg_adoption_social")) %>%
  tab_metrics(starts_with("idx_cg_adoption"))

