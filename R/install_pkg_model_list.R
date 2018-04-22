#' install missing packages from pre-trained models
#'
#' check and install missing packages dependencies from a list of pre-trained caret models.
#'
#' Given a list of pre-trained caret models from others, you might not have all the packages required to predict with those models. That is when you should you use this function.
#' The input of the function is just a list of caret models. This function depends on the function install_pkg_model_names
#'
#' @param models A list of pre-trained caret models.
#'
#' @examples
#' install_pkg_model_list(churn_down_sampling_models)
#'
#' install_pkg_model_list(models=down_sampling_models)
#'
#'

install_pkg_model_list=function(models){
  model_libs=foreach::foreach(i=seq_along(models),.combine = c)%do%{
    return(models[[i]]$modelInfo$library)
  }
  install_pkg_model_names(model_libs)
}
