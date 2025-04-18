% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/effects.R
\name{effect_counts_items}
\alias{effect_counts_items}
\title{Test homogeneity of category shares for multiple items}
\usage{
effect_counts_items(data, cols, labels = TRUE, clean = TRUE, ...)
}
\arguments{
\item{data}{A tibble containing item measures.}

\item{cols}{Tidyselect item variables (e.g. starts_with...).}

\item{labels}{If TRUE (default) extracts labels from the attributes, see \link{codebook}.}

\item{clean}{Prepare data by \link{data_clean}.}

\item{...}{Placeholder to allow calling the method with unused parameters from \link{effect_counts}.}
}
\value{
A volker tibble with the following statistical measures:
\itemize{
\item \strong{Gini coefficient}: Gini coefficient, measuring inequality.
\item \strong{n}: Number of cases the calculation is based on.
\item \strong{Chi-squared}: Chi-Squared test statistic.
\item \strong{p}: p-value for the statistical test.
\item \strong{stars}: Significance stars based on p-value (*, **, ***).
}
}
\description{
Performs a goodness-of-fit test and calculates the Gini coefficient for each item.
The goodness-of-fit-test is calculated using  \code{stats::\link[stats:chisq.test]{chisq.test}}.
}
\examples{
library(volker)
data <- volker::chatgpt

effect_counts_items(data, starts_with("cg_adoption_adv"))

}
\keyword{internal}
