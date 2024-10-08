% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean.R
\name{data_prepare}
\alias{data_prepare}
\title{Prepare data for calculation}
\usage{
data_prepare(data, cols, cross, clean = TRUE)
}
\arguments{
\item{data}{Data frame to be prepared.}

\item{cols}{The first column selection.}

\item{cross}{The second column selection.}

\item{clean}{Whether to clean data using \link{data_clean}.}
}
\value{
Prepared data frame.
}
\description{
Clean data, check column selection, remove cases with missing values
}
\examples{
data <- volker::chatgpt
data_prepare(data, sd_age, sd_gender)

}
\keyword{internal}
