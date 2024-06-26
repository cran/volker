% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{plot_metrics}
\alias{plot_metrics}
\title{Output a plot with distribution parameters such as the mean values}
\usage{
plot_metrics(data, cols, cross = NULL, metric = FALSE, clean = TRUE, ...)
}
\arguments{
\item{data}{A data frame.}

\item{cols}{A tidy column selection,
e.g. a single column (without quotes)
or multiple columns selected by methods such as starts_with().}

\item{cross}{Optional, a grouping column (without quotes).}

\item{metric}{When crossing variables, the cross column parameter can contain categorical or metric values.
By default, the cross column selection is treated as categorical data.
Set metric to TRUE, to treat it as metric and calculate correlations.}

\item{clean}{Prepare data by \link{data_clean}.}

\item{...}{Other parameters passed to the appropriate plot function.}
}
\value{
A ggplot object.
}
\description{
The plot type depends on the number of selected columns:
\itemize{
\item One column: see \link{plot_metrics_one}
\item Multiple columns: see \link{plot_metrics_items}
\item One column and one grouping column: see \link{plot_metrics_one_grouped}
\item Multiple columns and one grouping column: see \link{plot_metrics_items_grouped}
}

By default, if you provide two column selections, the second column is treated as categorical.
Setting the metric-parameter to TRUE will call the appropriate functions for correlation analysis:
\itemize{
\item Two metric columns: see \link{plot_metrics_one_cor}
\item Multiple columns: see \link{plot_metrics_items_cor} (not yet implemented)
}

\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}
}
\examples{
library(volker)
data <- volker::chatgpt

plot_metrics(data, sd_age)

}
