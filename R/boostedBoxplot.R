# --------------------------------------------------------------------------------
# title: Linkspotter/boostedBoxplot
# description: Boosted Boxplot : add useful features to R boxplot function
# author: Alassane Samba (alassane.samba@orange.com)
# Copyright (c) 2017 Orange
# ---------------------------------------------------------------------------------
## Boosted Boxplot : add useful features to R boxplot function
#' @importFrom stats sd median
#' @importFrom graphics boxplot points arrows text grid
#' @importFrom rAmCharts amBoxplot
boostedBoxplot<-function(y,x, main="", labx=NULL,laby=NULL, plot.mean=T, text.freq=T, las=1, ylim=c(0,0), limitVisibleModalities=30, decreasing=NULL, dynamic=F){

  xlab=""
  if(is.null(labx))labx=deparse(substitute(x))
  if(is.null(laby))laby=deparse(substitute(y))
  if(main==""){
    main=labx
  }else{
    xlab=labx
  }
  x=droplevels(as.factor(x))
  p=length(levels(as.factor(x)))
  if(!is.null(decreasing)){
    x=factor(x,levels = names(sort(tapply(y,x,stats::median), decreasing = decreasing)), ordered = F)
  }else{
    decreasing=T
  }
  #limitVisibleModalities
  if(limitVisibleModalities<p-1){
    x=factor(x,levels = names(sort(tapply(y,x,median), decreasing = decreasing)), ordered = F)
    lx=levels(as.factor(x))
    leftl=lx[1:floor(limitVisibleModalities/2)]
    rightl=lx[(p-floor(limitVisibleModalities/2)+1):p]
    n_other=length(lx[!lx%in%c(leftl,rightl)])
    x=as.character(x)
    x[!x%in%c(leftl,rightl)]<-paste(c("other(",n_other,")"),collapse="")
    x=as.factor(x)
    x=factor(x,levels = names(sort(tapply(y,x,median), decreasing = decreasing)), ordered = F)
  }
  #
  #dynamicity
  if(dynamic){
    dataf=data.frame(Y=y,X=x)
    rAmCharts::amBoxplot(Y~X,data=dataf,labelRotation = (las==2)*90, ylab = laby, main = main)
  }else{
    if(sum(ylim)==0){
      rb<-graphics::boxplot(y~x, main=main, xlab=xlab, ylab=laby, las=las)
      graphics::grid()
      #rb<-graphics::boxplot(y~x, main=main, xlab=xlab, ylab=laby, las=las, add=T)
    }else{
      rb<-graphics::boxplot(y~x, main=main, xlab=xlab, ylab=laby, las=las, ylim=ylim)
      graphics::grid()
      #rb<-graphics::boxplot(y~x, main=main, xlab=xlab, ylab=laby, las=las, add=T)
    }
    if(plot.mean){
      mn.t <- tapply(y, x, mean, na.rm=T)
      sd.t <- tapply(y, x, stats::sd, na.rm=T)
      xi <- 0.3 + seq(rb$n)
      graphics::points(xi, mn.t, col = "red", pch = 18, cex=1)
      graphics::arrows(xi, mn.t - sd.t, xi, mn.t + sd.t,code = 3, col = "red", angle = 75, length = .1, lwd = 1)
    }
    if(text.freq) graphics::text(x=1:length(rb$names), y=(rb$stats[3,]+rb$stats[4,])/2,label=rb$n)
  }
}
############
