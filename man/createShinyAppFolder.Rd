% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createShinyAppFolder.R
\name{createShinyAppFolder}
\alias{createShinyAppFolder}
\title{Ready-for-deployment shiny app folder creation}
\usage{
createShinyAppFolder(linkspotterShinyAppObject, folderName)
}
\arguments{
\item{linkspotterShinyAppObject}{a shiny.appobj object, resulting from linkspotterUI(), linkspotterComplete()$run_it or linkspotterOnFile()$run_it functions.}

\item{folderName}{a character string corresponding to the name of the shiny app folder to create.}
}
\description{
This function creates a shiny app folder containing a shiny app object directly readable by a shiny-server.
}
