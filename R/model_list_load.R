#' A function to load all rds files in a specified folder from disk.
#'
#' This function is used to load all models saved to disk in ml_list function but could be used to load all rds files in a folder.
#'
#' Each rds file will be added to a list that is returned by this function.
#'
#'
#'
#'
#'
#' @param path The path of the folder
#'

#'
#'
#' @return A list of models saved to disk. Same output as ml_list function.
#'
#'
#'
#' @examples
#'
#' \dontrun{
#'    models=model_list_load(path="~/Dropbox/churn/down_sampling")
#' }
#'@export


model_list_load=function(path){
  current_path=getwd()
  setwd(path)
  file_names=list.files(path=".")
  message(paste("Loading "),length(file_names)," models.")

  model_list=foreach::foreach(i=seq_along(file_names))%do%{
    model=base::readRDS(file=file_names[i])
    message(paste("Finished loading model:",file_names[i],"\n",i,"/",length(file_names)))
    return(model)
  }

  setwd(current_path)
  return(model_list)

}
