#' Unload additional packages from search path.
#'
#' Some packages would load with itself some other package depedency into the search path. In order to eliminate the possibility of conflict
#' and avoid side effect in writing functions, it is recommended to remove additional packages from the search path after the calculation.
#'
#'
#' This is also a dirty trick to remove extra packages from search path when you are writing a package and
#' some functions from other packages you use have implicit or ill-documented depedencies so that you have to use require or library somewhere in your code.
#'
#'
#' @param init_state A list of character vectors containing the information of previous state of search path.
#'
#'
#' @examples
#' init_state=search()
#' testing_packs=function(data){
#'   library(caret)
#'   library(doParallel)
#'   library(foreach)
#'   library(magrittr)
#'   library(smotefamily)
#'   library(FNN)
#'   library(dbscan)
#'   library(ROSE)
#'   library(DMwR)
#'   library(h2o)
#'   library(dplyr)
#'   library(glue)
#'   library(MLmetrics)
#'   library(testthat)
#'   return(1)
#' }
#' testing_packs(data=iris)
#' unload_additional_packs(init_state=init_state)
#' @export



unload_additional_packs=function(init_state=init_state){

  # record the current search path.
  after_func_packs=search()

  # find all the change of package in search path.
  grep("package:*",x=setdiff(after_func_packs,init_state),value = TRUE)

  # split the string and return all the names of packages that are changed
  package_strings=setdiff(after_func_packs,init_state)%>%strsplit(split=":")%>%unlist
  package_index=grep("package",package_strings)
  package_names=package_strings[-package_index]

  # unload all the additional packages one by one since unloadNamespace function could only take one variable.
  foreach::foreach(i=seq_along(package_names),.errorhandling = "pass" )%do%{
    unloadNamespace(package_names[i])
  }


  # verify that all additional packages are removed.
  after_func_packs2=search()
  if(length(setdiff(after_func_packs2,init_state))==0){
    message("All loaded packages are removed.")
  }else{
    unloaded_packs_names=setdiff(after_func_packs2,init_state)
    unloaded_packs_names=paste(unloaded_packs_names,collapse = ", ")
      message(paste("Not all extra packages are unloaded. The unloaded packges are: ",unloaded_packs_names))
    }
}

