#
# Test effect calculations
#

library(testthat)
library(volker)

# Load and recode data
data <- volker::chatgpt


# Categorical
test_that("effect_counts_one_grouped", {

  expect_snapshot(
    data |>
      filter(sd_gender != "diverse") |>
      mutate(sd_age = ifelse(sd_age >40,"+40","-40")) |>
      volker::effect_counts(sd_gender, sd_age),
    cran= TRUE
  )

})

data |>
  filter(sd_gender != "diverse") |>
  volker::effect_metrics(sd_age, sd_gender)

# Metric
test_that("effect_metrics_one_grouped", {
  expect_snapshot(volker::effect_metrics(data, sd_age, adopter), cran= TRUE)
})

test_that("effect_metrics_one_cor", {
  expect_snapshot(volker::effect_metrics(data, sd_age, use_private, metric=TRUE), cran= TRUE)
})

test_that("effect_metrics_one_cor with spearman", {
  expect_snapshot(volker::effect_metrics(data, sd_age, use_private, metric=TRUE, method="spearman"), cran= TRUE)
})


test_that("effect_metrics_one_cor with spearman", {
  expect_snapshot(volker::effect_metrics(data, sd_age, use_private, metric=TRUE, method="spearman"), cran= TRUE)
})

test_that("effect_metrics_items", {
  expect_snapshot(volker::effect_metrics(data, tidyselect::starts_with("use_")), cran= TRUE)
})


test_that("effect_metrics_items_cor with one variable", {
  expect_snapshot(volker::effect_metrics(data, tidyselect::starts_with("cg_adoption_"), sd_age, metric=TRUE), cran= TRUE)
})

test_that("effect_metrics_items", {
  expect_snapshot(volker::effect_metrics(data, tidyselect::starts_with("use_")), cran= TRUE)
})

test_that("effect_metrics_items with spearman", {
  expect_snapshot(volker::effect_metrics(data, tidyselect::starts_with("use_"), method="spearman"), cran= TRUE)
})

test_that("effect_metrics_items_cor with items", {
  expect_snapshot(
    volker::effect_metrics(
      data,
      tidyselect::starts_with("cg_adoption_"),
      tidyselect::starts_with("cg_adoption_"),
      metric=TRUE
    ), cran= TRUE
  )
})

test_that("effect_metrics_items_cor with two batteries", {
  expect_snapshot(
    volker::effect_metrics(
      data,
      tidyselect::starts_with("cg_adoption_"),
      tidyselect::starts_with("use_"),
      metric=TRUE
    ), cran= TRUE
  )
})
