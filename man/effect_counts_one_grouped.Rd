% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/effects.R
\name{effect_counts_one_grouped}
\alias{effect_counts_one_grouped}
\title{Output test statistics and effect size for contingency tables}
\usage{
effect_counts_one_grouped(data, col, cross, clean = TRUE, ...)
}
\arguments{
\item{data}{A tibble.}

\item{col}{The column holding factor values.}

\item{cross}{The column holding groups to compare.}

\item{clean}{Prepare data by \link{data_clean}.}

\item{...}{Placeholder to allow calling the method with unused parameters from \link{effect_counts}.}
}
\value{
A volker tibble with the following statistical measures:
\itemize{
\item \strong{Cramer's V}: Effect size measuring the association between two variables.
\item \strong{n}: Number of cases the calculation is based on.
\item \strong{Chi-squared}: Chi-Squared test statistic.
\item \strong{df}: Degrees of freedom.
\item \strong{p}: p-value for the statistical test.
\item \strong{stars}: Significance stars based on p-value (*, **, ***).
}
}
\description{
Chi squared is calculated using \code{stats::\link[stats:chisq.test]{chisq.test}}.
If any cell contains less than 5 observations, the exact-parameter is set.
}
\details{
Phi is derived from the Chi squared value by \code{sqrt(fit$statistic / n)}.
Cramer's V is derived by \code{sqrt(phi / (min(dim(contingency)[1], dim(contingency)[2]) - 1))}.
}
\examples{
library(volker)
data <- volker::chatgpt

effect_counts_one_grouped(data, adopter, sd_gender)

}
\keyword{internal}
