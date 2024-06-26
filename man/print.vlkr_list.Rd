% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/report.R
\name{print.vlkr_list}
\alias{print.vlkr_list}
\title{Printing method for volker lists}
\usage{
\method{print}{vlkr_list}(x, ...)
}
\arguments{
\item{x}{The volker list.}

\item{...}{Further parameters passed to print.}
}
\value{
No return value.
}
\description{
Printing method for volker lists
}
\examples{
library(volker)
data <- volker::chatgpt

rp <- report_metrics(data, sd_age, sd_gender, effect = TRUE)
print(rp)

}
\keyword{internal}
