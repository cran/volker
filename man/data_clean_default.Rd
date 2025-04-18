% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean.R
\name{data_clean_default}
\alias{data_clean_default}
\title{Prepare data originating from SoSci Survey or SPSS}
\usage{
data_clean_default(data, remove.na.levels = TRUE, remove.na.numbers = TRUE)
}
\arguments{
\item{data}{Data frame}

\item{remove.na.levels}{Remove residual values from factor columns.
Either a character vector with residual values or TRUE to use defaults in \link{VLKR_NA_LEVELS}.
You can also define or disable residual levels by setting the global option vlkr.na.levels
(e.g. \code{options(vlkr.na.levels=c("Not answered"))} or to disable \code{options(vlkr.na.levels=FALSE)}).}

\item{remove.na.numbers}{Remove residual values from numeric columns.
Either a numeric vector with residual values or TRUE to use defaults in \link{VLKR_NA_NUMBERS}.
You can also define or disable residual values by setting the global option vlkr.na.numbers
(e.g. \code{options(vlkr.na.numbers=c(-2,-9))} or to disable \code{options(vlkr.na.numbers=FALSE)}).}
}
\value{
Data frame with vlkr_df class (the class is used to prevent double preparation).
}
\description{
Preparation steps:
\itemize{
\item Remove the avector class from all columns
(comes from SoSci and prevents combining vectors)
\item Recode residual factor values to NA (e.g. "\link{NA} nicht beantwortet")
\item Recode residual numeric values to NA (e.g. -9)
}
}
\details{
The tibble remembers whether it was already prepared and
the operations are only performed once in the first call.
}
\examples{
ds <- volker::chatgpt
ds <- data_clean_default(ds)
}
\keyword{internal}
