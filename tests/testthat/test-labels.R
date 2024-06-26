#
# Test labeling functions
#

library(testthat)
library(volker)

# Load and recode data
data <- volker::chatgpt
data <- volker::data_clean(data)

# Get labels
test_that("Labels", {
  expect_snapshot(volker::codebook(data),cran= TRUE)
})

# What happens when labels are empty?
test_that("missing labels", {
  data %>%
    dplyr::select(starts_with("cg_adoption")) %>%
    volker::labs_clear() %>%
    volker::codebook() %>%
    expect_snapshot(cran= TRUE)
})

# Detect the scale
test_that("Factors are unordered", {
  data %>%
    get_direction(adopter) |>
    expect_equal(0)
})

test_that("Items are ordered", {
  data %>%
    get_direction(use_private) |>
    expect_equal(1)
})

# Test store and clear labels
test_that("Store and clear the codebook", {
  data %>%
    volker::labs_store() %>%
    volker::labs_clear() %>%
    codebook() %>%
    expect_snapshot(cran= TRUE)
})

# Test store and restore labels
test_that("Store, clear and restore the codebook", {
  data %>%
    volker::labs_store() %>%
    volker::labs_clear() %>%
    volker::labs_restore() %>%
    codebook() %>%
    expect_snapshot(cran= TRUE)
})

# Replace item labels
test_that("Item labels are replaced and keep their order", {

  data |>
    dplyr::select(adopter) |>
    # TODO: Even if the column was converted to character beforehand
    #  dplyr::mutate(adopter = as.character(adopter)) |>
    volker:::labs_replace(adopter, volker::codebook(data)) |>
    dplyr::pull(adopter) |>
    levels() |>
    expect_snapshot(cran= TRUE)
})

# Get prefix from labels
test_that("A common prefix is removed from labels", {

  data |>
    dplyr::select(starts_with("use")) |>
    codebook() |>
    dplyr::pull(item_label) |>
    get_prefix() |>
    expect_snapshot(cran= TRUE)
})

# Remove prefix from labels
test_that("A common prefix is removed from labels", {

  data |>
    dplyr::select(starts_with("use")) |>
    codebook() |>
    dplyr::pull(item_label) |>
    trim_prefix() |>
    expect_snapshot(cran= TRUE)
})
