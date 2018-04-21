#' Give models a meaningful names for comparison.
#'
#' Assign models with names based on method, metric, preProcess and sampling from the parameter of params dataframe in ml_lis funtion.
#'
#' The function uses foreach function to get the method, metric,preProcess and sampling for each model from a list of models.
#'
#'
#'
#'
#'
#'@param models
#'
#'
#'@return a list contains the all the models with names.
#'
#'
#'@examples
#'down_sampling_models= assign_model_names(down_sampling_models)
#'
#'
#'@seealso ml_list, model_list_load
#'
#'
#'
#'@export

assign_model_names=function(models){
  model_names=foreach::foreach(i=seq_along(models))%do%{
    method=models[[i]]$method
    metric=models[[i]]$metric
    preProcess=models[[i]]$preProcess$method%>%names
    sampling=models[[i]]$control$sampling$name
    preProcess=glue::collapse(preProcess,sep="_")
    model_name=paste(i,method,sampling,preProcess,metric,sep="_")
    return(model_name)
  }
  names(models)=model_names
  return(models)
}
