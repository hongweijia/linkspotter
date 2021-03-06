% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multiBivariateCorrelation.R
\name{multiBivariateCorrelation}
\alias{multiBivariateCorrelation}
\title{Calculation of all the bivariate correlations in a dataframe}
\usage{
multiBivariateCorrelation(dataset, corMethods = c("pearson", "spearman",
  "kendall", "mic", "MaxNMI"), showProgress = T)
}
\arguments{
\item{dataset}{the dataframe which variables bivariate correlations are to be analyzed.}

\item{corMethods}{a vector of correlation coefficients to compute. The available coefficients are the following : \code{c("pearson","spearman","kendall","mic","distCor","MaxNMI")}. It is not case sensitive and still work if only the beginning of the word is put (e.g. \code{pears}).}

\item{showProgress}{a boolean to decide whether to show the progress bar.}
}
\value{
a specific dataframe containing correlations values or each specified correlation coefficient.
}
\description{
Computation of a correlation dataframe.
}
\examples{
\dontrun{

# run linkspotter on iris example data
data(iris)
corDF<-multiBivariateCorrelation(iris)
print(corDF)

}

}
