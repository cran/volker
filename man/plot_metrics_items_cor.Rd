% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{plot_metrics_items_cor}
\alias{plot_metrics_items_cor}
\title{Multiple items correlated with one metric variable}
\usage{
plot_metrics_items_cor(
  data,
  cols,
  cross,
  ci = FALSE,
  method = "pearson",
  title = TRUE,
  labels = TRUE,
  clean = TRUE,
  ...
)
}
\arguments{
\item{data}{A tibble containing item measures.}

\item{cols}{Tidyselect item variables (e.g. starts_with...).}

\item{cross}{The column to correlate.}

\item{ci}{Whether to plot confidence intervals of the correlation coefficient.}

\item{method}{The method of correlation calculation, pearson = Pearson's R, spearman = Spearman's rho.}

\item{title}{If TRUE (default) shows a plot title derived from the column labels.
Disable the title with FALSE or provide a custom title as character value.}

\item{labels}{If TRUE (default) extracts labels from the attributes, see \link{codebook}.}

\item{clean}{Prepare data by \link{data_clean}.}

\item{...}{Placeholder to allow calling the method with unused parameters from \link{plot_metrics}.}
}
\value{
A ggplot object.
}
\description{
Multiple items correlated with one metric variable
}
\examples{
library(volker)
data <- volker::chatgpt

plot_metrics_items_cor(data, starts_with("use_"), sd_age)

}
\keyword{internal}
