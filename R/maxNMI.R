# --------------------------------------------------------------------------------
# title: Linkspotter/maxNMI
# description: Computes the MaxNMI between the two variables whatever their types, by discretizing using Best Equal-Frequency-based discretization (BeEF) if necessary.
# author: Alassane Samba (alassane.samba@orange.com)
# Copyright (c) 2017 Orange
# ---------------------------------------------------------------------------------
#' @title Maximal Normalized Mutual Information (MaxNMI)
#' @description Computes the MaxNMI between the two variables whatever their types, by discretizing using Best Equal-Frequency-based discretization (BeEF) if necessary.
#'
#' @param x a vector of numeric or factor.
#' @param y a vector of numeric or factor.
#' @param maxNbBins an integer corresponding to the number of bin limitation (for computation time limitation), maxNbBins=100 by default.
#' @param showProgress a boolean to decide whether to show the progress bar.
#' @return a double between 0 and 1 corresponding to the MaxNMI.
#'
#' @examples
#' \dontrun{
#'
#' # calculate a correlation dataframe
#' data(iris)
#' maxNMI(iris$Sepal.Length,iris$Sepal.Width)
#' maxNMI(iris$Sepal.Length,iris$Species)
#'
#' }
#'
#' @export
maxNMI<-function(x,y,maxNbBins=100, showProgress = F){
  typeOfCouple=2*is.numeric(x)+is.numeric(y)# 3->(num,num), 2->(num,fact), 1->(fact,num), 0->(fact,fact)
  typeOfCouple=factor(as.factor(typeOfCouple),levels = c("0","1","2","3"),labels =c("fact.fact","fact.num","num.fact","num.num"))
  switch(as.character(typeOfCouple),
         fact.fact={
           NormalizedMI(x,y,includeNA = F)
         },
         fact.num={
           yfact=BeEFdiscretization.numfact(y,x,includeFactorNA = F, showProgress = showProgress)
           NormalizedMI(x,yfact,includeNA = F)
         },
         num.fact={
           xfact=BeEFdiscretization.numfact(x,y,includeFactorNA = F, showProgress = showProgress)
           NormalizedMI(xfact,y,includeNA = F)
         },
         num.num={
           disc=BeEFdiscretization.numnum(x,y,maxNbBins=maxNbBins, showProgress = showProgress)
           NormalizedMI(disc$x,disc$y,includeNA = F)
         }
  )
}
