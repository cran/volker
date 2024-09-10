## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  comment = "", 
  echo = TRUE,
  message = FALSE,
  knitr.table.format = "html"
)

options(
  vlkr.fig.settings=list(
    html = list(
      dpi = 96, scale = 1, width = 910, pxperline = 12
    )
  )
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

## -----------------------------------------------------------------------------
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
  plot_counts(adopter, sd_gender, prop="rows", numbers=c("p","n"))

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
ds %>%
  labs_apply(
    items = list(
      "cg_adoption_advantage_01" = "Allgemeine Vorteile",
      "cg_adoption_advantage_02" = "Finanzielle Vorteile",
      "cg_adoption_advantage_03" = "Vorteile bei der Arbeit",
      "cg_adoption_advantage_04" = "Macht mehr Spaß"
    )
  ) %>% 
  tab_metrics(starts_with("cg_adoption_advantage_"))


## -----------------------------------------------------------------------------

ds %>%
  labs_apply(
    cols=starts_with("cg_adoption"),  
    values = list(
      "1" = "Stimme überhaupt nicht zu",
      "2" = "Stimme nicht zu",
      "3" = "Unentschieden",
      "4" = "Stimme zu",
      "5" =  "Stimme voll und ganz zu"
    ) 
  ) %>% 
  plot_metrics(starts_with("cg_adoption"))


## ----eval = FALSE-------------------------------------------------------------
#  
#  library(readxl)
#  library(writexl)
#  
#  # Save codebook to a file
#  codes <- codebook(ds)
#  write_xlsx(codes,"codebook.xlsx")
#  
#  # Load and apply a codebook from a file
#  codes <- read_xlsx("codebook_revised.xlsx")
#  ds <- labs_apply(ds, codebook)
#  

## -----------------------------------------------------------------------------
ds %>%
  labs_store() %>%
  mutate(sd_age = 2024 - sd_age) %>% 
  labs_restore() %>% 
  
  tab_metrics(sd_age)

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

