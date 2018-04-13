#' check and install missing package dependencies from a vector of model names.
#'
#' It is a function to check the missing packages needed to do model training, since caret package does not install all the depedencies for some algorithms.
#'
#' This function checks and installs package dependencies when you supply it with a vector of names of machine learning algorithms.
#'
#'
#'
#' @param model_names A vector of model names
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   # install by supplying the model names as defined in caret packages.
#'   install_pkg_model_names(c("xgbTree","deepboost"))
#'
#'   # install by supplying the param_grid, which is used in ml_list
#'   install_pkg_model_names(params_grid$method)
#' }
#'
#' @seealso To see how the param_grid should be constructed \code{\link{ml_list}}
#'
#'


install_pkg_model_names=function(model_names){

  model_names=unique(model_names)
  pkg_names=foreach::foreach(i=seq_along(model_names),.combine=c)%do%{
    return(caret::getModelInfo()[[model_names[i]]]$library)
  }

  # check for the difference between required package and installed packages.
  missing_pkgs=setdiff(unique(pkg_names),rownames(installed.packages()))
  if( length( missing_pkgs )>0    ){
    message(paste("Trying to install packages:",missing_pkgs,"\n"))
    if("bnclassify" %in% missing_pkgs){
      # need to install some bioconductor dependencies.
      source("http://bioconductor.org/biocLite.R")
      biocLite(c("graph", "RBGL", "Rgraphviz"))
    }
    install.packages(missing_pkgs)
  }else{
    message("No missing package dependency.")
  }
}

# example use
#
#
