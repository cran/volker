#' Prepare data for calculation
#'
#' Clean data, check column selection, remove cases with missing values
#'
#' @keywords internal
#'
#' @param data Data frame to be prepared.
#' @param cols The first column selection.
#' @param cross The second column selection.
#' @param clean Whether to clean data using \link{data_clean}.
#'
#' @return Prepared data frame.
#' @examples
#' data <- volker::chatgpt
#' data_prepare(data, sd_age, sd_gender)
#'
#' @export
#'
data_prepare <- function(data, cols, cross, clean = TRUE) {
  # 1. Checks
  check_is_dataframe(data)
  check_has_column(data, {{ cols }})

  if (!missing(cross)) {
      check_has_column(data, {{ cross }})
  }

  # 2. Apply cleaning plan
  if (clean) {
    data <- data_clean(data, clean)
  }

  # 3. Remove missings
  if (!missing(cross)) {
    data <- data_rm_missings(data, c({{ cols }}, {{ cross }}))
  } else {
    data <- data_rm_missings(data, {{ cols }})
  }


  # # 4. Remove negatives
  # if (isTRUE(rm.negatives) & !missing(cross)) {
  #   data <- data_rm_negatives(data, c({{ cols }}, {{ cross }}))
  # }
  # else if (isTRUE(rm.negatives) & missing(cross)) {
  #   data <- data_rm_negatives(data, {{ cols }})
  # }
  # else if (rm.negatives == "cols") {
  #   data <- data_rm_negatives(data, {{ cols }})
  # }

  if (nrow(data) == 0) {
     message("The dataset is empty, check your values.")
  }

  data
}

#' Prepare dataframe for the analysis
#'
#' Depending on the selected cleaning plan, for example,
#' recodes residual values to NA.
#'
#' The tibble remembers whether it was already cleaned and
#' the cleaning plan is only applyed once in the first call.
#'
#' @keywords internal
#'
#' @param data Data frame.
#' @param plan The cleaning plan. By now, only "sosci" is supported. See \link{data_clean_sosci}.
#' @param ... Other parameters passed to the appropriate cleaning function.
#' @return Cleaned data frame with vlkr_df class.
#' @examples
#' ds <- volker::chatgpt
#' ds <- data_clean(ds)
#' @export
data_clean <- function(data, plan = "sosci", ...) {

  # Prepare only once
  if ("vlkr_df" %in% class(data)) {
    return (data)
  }

  if (isTRUE(plan)) {
    plan <- "sosci"
  }

  if (plan == "sosci") {
    data <- data_clean_sosci(data,...)
  }

  .to_vlkr_df(data)
}

#' Prepare data originating from SoSci Survey
#'
#' Prepares SoSci Survey data:
#' - Remove the avector class from all columns
#'   (comes from SoSci and prevents combining vectors)
#' - Recode residual factor values to NA (e.g. "[NA] nicht beantwortet")
#' - Recode residual numeric values to NA (e.g. -9)
#'
#' The tibble remembers whether it was already prepared and
#' the operations are only performed once in the first call.
#'
#' @keywords internal
#'
#' @param data Data frame
#' @param remove.na.levels Remove residual values from factor columns.
#'                      Either a character vector with residual values or TRUE to use defaults in \link{VLKR_NA_LEVELS}.
#'                      You can also define or disable residual levels by setting the global option vlkr.na.levels
#'                      (e.g. `options(vlkr.na.levels=c("Not answered"))` or to disable `options(vlkr.na.levels=FALSE)`).
#' @param remove.na.numbers Remove residual values from numeric columns.
#'                      Either a numeric vector with residual values or TRUE to use defaults in \link{VLKR_NA_NUMBERS}.
#'                      You can also define or disable residual values by setting the global option vlkr.na.numbers
#'                      (e.g. `options(vlkr.na.numbers=c(-2,-9))` or to disable `options(vlkr.na.numbers=FALSE)`).
#' @return Data frame with vlkr_df class (the class is used to prevent double preparation).
#' @examples
#' ds <- volker::chatgpt
#' ds <- data_clean_sosci(ds)
#' @export
data_clean_sosci <- function(data, remove.na.levels = TRUE, remove.na.numbers = TRUE) {

  # Prepare only once
  if ("vlkr_df" %in% class(data)) {
    return (data)
  }

  # Remove avector class
  for (i in c(1:ncol(data))) {
    class(data[[i]]) <- setdiff(class(data[[i]]), "avector")
  }

  # Add missing residual labels to numeric columns that have at least one label
  data <- labs_impute(data)

  # Store codebook before mutate operations
  data <- labs_store(data)

  # Remove residual levels such as "[NA] nicht beantwortet"
  if (remove.na.levels != FALSE) {
    data <- data_rm_na_levels(data, remove.na.levels)
  }

  # Remove residual numbers such as -9
  # (but only if they are listed in the attributes of a column)
  if (remove.na.numbers != FALSE) {
    data <- data_rm_na_numbers(data, remove.na.numbers)
  }

  # Restore codebook
  data <- labs_restore(data)

  .to_vlkr_df(data)
}

#' Remove missings and output a message
#'
#' @keywords internal
#'
#' @param data Data frame.
#' @param cols A tidy column selection.
#' @return Data frame.
data_rm_missings <- function(data, cols) {

  cleaned <- tidyr::drop_na(data, {{ cols }})
  cases <-  nrow(data) - nrow(cleaned)

  if (cases > 0) {
    data <- cleaned
    colnames <- rlang::as_label(rlang::enquo(cols))
    data <- .attr_insert(data, "missings", "na", list("cols" = colnames, "n"=cases))
  }

  data
}

#' Remove zero values, drop missings and output a message
#'
#' @keywords internal
#'
#' @param data Data frame.
#' @param cols A tidy column selection.
#' @return Data frame.
data_rm_zeros <- function(data, cols) {

  cleaned <- data |>
    labs_store() |>
    dplyr::mutate(dplyr::across({{ cols }}, ~ dplyr::if_else(. == 0, NA, .))) |>
    labs_restore() |>
    tidyr::drop_na({{ cols }})


  cases <-  nrow(data) - nrow(cleaned)

  if (cases > 0) {
    data <- cleaned
    colnames <- rlang::as_label(rlang::enquo(cols))
    data <- .attr_insert(data, "missings", "zero", list("cols" = colnames, "n"=cases))
  }

  data
}

#' Remove negatives and output a warning
#'
#' @keywords internal
#'
#' @param data Data frame
#' @param cols A tidy column selection
#' @return Data frame
data_rm_negatives <- function(data, cols) {

  data_clean <- data |>
    labs_store() |>
    dplyr::mutate(dplyr::across({{ cols }}, ~ ifelse(. < 0, NA, .))) |>
    labs_restore() |>
    #TODO: only drop rows that had negatives, not all missings
    tidyr::drop_na({{ cols }})

    cases <-  nrow(data) - nrow(data_clean)

    if (cases > 0) {
      data <- data_clean
      colnames <- rlang::as_label(rlang::enquo(cols))
      data <- .attr_insert(data, "missings", "negative", list("cols" = colnames, "n"=cases))
    }

    data
}


#' Remove NA levels
#'
#' @keywords internal
#'
#' @param data Data frame
#' @param na.levels Residual values to remove from factor columns.
#'                  Either a character vector with residual values or TRUE to use defaults in \link{VLKR_NA_LEVELS}.
#'                  You can define default residual levels by setting the global option vlkr.na.levels
#'                  (e.g. `options(vlkr.na.levels=c("Not answered"))`).
#' @return Data frame
data_rm_na_levels <- function(data, na.levels = TRUE) {
  if (is.logical(na.levels)) {
    na.levels <- getOption("vlkr.na.levels")
    if (is.null(na.levels)) {
      na.levels <- VLKR_NA_LEVELS
    } else if (all(na.levels == FALSE)) {
      na.levels <- c()
    }
  }

  dplyr::mutate(
    data,
    dplyr::across(
      tidyselect::where(~ is.factor(.)),
      ~ .factor_with_attr(replace(., . %in% na.levels, NA),setdiff(levels(.), na.levels))
    )
  )

}

#' Remove NA numbers
#'
#' @keywords internal
#'
#' @param data Data frame
#' @param na.numbers Either a numeric vector with residual values or TRUE to use defaults in \link{VLKR_NA_NUMBERS}.
#'                   You can also define residual values by setting the global option vlkr.na.numbers
#'                   (e.g. `options(vlkr.na.numbers=c(-9))`).
#' @param check.labels Whether to only remove NA numbers that are listed in the attributes of a column.
#' @return Data frame
data_rm_na_numbers <- function(data, na.numbers = TRUE, check.labels = TRUE) {
  if (is.logical(na.numbers)) {
    na.numbers <- cfg_get_na_numbers()
  }

  data %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.numeric),
        ~ dplyr::if_else(
            . %in% na.numbers &
            (!check.labels | (as.character(.) %in% names(attributes(.)))),
          NA,
          .
        )
      )
    )
}

#' Get a formatted baseline for removed zero, negative, and missing cases
#' and include focus category information if present
#'
#' @keywords internal
#'
#' @param obj An object with the missings and focus attributes.
#' @return A formatted message or NULL if missings and focus attributes are not present.
get_baseline <- function(obj) {
  baseline <- c()

  # Focus categories
  focus <- attr(obj, "focus", exact=TRUE)
  if (!is.null(focus)) {
    baseline <- c(baseline, paste0("Frequencies based on values: ", paste(focus, collapse=", "), "."))
  }

  # Reversed items
  reversed <- attr(obj, "reversed", exact=TRUE)
  if (!is.null(reversed)) {
    baseline <- c(baseline, paste0("Reversed items: ", paste(reversed, collapse=", "), "."))
  }

  # Split
  split <- attr(obj, "split", exact=TRUE)
  if (!is.null(split)) {
    baseline <- c(baseline, paste0(split, "."))
  }

  # Missings
  missings <- attr(obj, "missings", exact=TRUE)
  if (!is.null(missings)) {
    cols <- c()
    baseline_missing <- c()
    if (!is.null(missings$na)) {
      baseline_missing <- c(baseline_missing, paste0(missings$na$n," missing"))
    }

    if (!is.null(missings$zero)) {
      baseline_missing <- c(baseline_missing, paste0(missings$zero$n," zero"))
    }

    if (!is.null(missings$negative)) {
      baseline_missing <- c(baseline_missing, paste0(missings$negative$n," negative"))
    }

    baseline <- c(baseline, paste0(paste0(baseline_missing, collapse=", "), " case(s) omitted."))
  }

  # Assemble baseline
  if (length(baseline) > 0) {
    baseline = paste0(baseline, collapse=" ")
  } else {
    baseline <- NULL
  }

  baseline
}

#' Add vlkr_df class - that means, the data frame has been prepared
#'
#' @keywords internal
#'
#' @param data A tibble.
#' @return A tibble of class vlkr_df.
.to_vlkr_df <- function(data, digits = NULL) {
  data <- dplyr::as_tibble(data)
  class(data) <- c("vlkr_df", setdiff(class(data), "vlkr_df"))
  data
}
