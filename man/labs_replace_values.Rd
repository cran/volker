% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/labels.R
\name{labs_replace_values}
\alias{labs_replace_values}
\title{Replace item value names in a column by their labels}
\usage{
labs_replace_values(data, col, codes)
}
\arguments{
\item{data}{A tibble}

\item{col}{The column holding item values}

\item{codes}{The codebook to use: A tibble with the columns value_name and value_label.
Can be created by the \link{codebook} function, e.g. by calling
\code{codes <- codebook(data, myitemcolumn)}.}
}
\value{
Tibble with new labels
}
\description{
TODO: Make dry with labs_replace_names
}
\keyword{internal}
