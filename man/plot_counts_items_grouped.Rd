% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{plot_counts_items_grouped}
\alias{plot_counts_items_grouped}
\title{Plot frequencies of multiple items compared by groups}
\usage{
plot_counts_items_grouped(data, cols, cross, title = TRUE, clean = TRUE, ...)
}
\arguments{
\item{data}{A tibble containing item measures.}

\item{cols}{The item columns that hold the values to summarize.}

\item{cross}{The column holding groups to compare.}

\item{title}{If TRUE (default) shows a plot title derived from the column labels.
Disable the title with FALSE or provide a custom title as character value.}

\item{clean}{Prepare data by \link{data_clean}.}

\item{...}{Placeholder to allow calling the method with unused parameters from \link{plot_counts}.}
}
\value{
A ggplot object.
}
\description{
\strong{Not yet implemented. The future will come.}
}
\keyword{internal}
