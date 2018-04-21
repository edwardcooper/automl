#' A function to visualize the model performance.
#'
#' A wrapper around the bwplot function in caret to visualize models even if models are trained using different metrics.
#'
#' If the models contains metrics from c("ROC","Sens","Spec") and c("Accuracy","Kappa"), then it will plot two graphs.
#'  You could not plot the "ROC","Sens" or "Spec" value for a model if the model trained by using "Accuracy" or "Kappa", and vice versa.
#'
#'
#'
#'
#'
#' @param models A list of models from ml_list function or manually combine finely tuned models from ml_tune or train function from caret package.
#' @param metric A character, the metric of model performance, the available values are "ROC","Sens","Spec","Accuracy","Kappa".
#'
#'
#'
#' @examples
#' # plot all the metrics
#' \dontrun{
#'   ml_bwplot(models)
#' }
#'
#' # plot only the ROC metric for all models.
#' \dontrun{
#' ml_bwplot(models,metric="ROC")
#' }
#'
#'
#' @seealso To see how the list of models are generated \code{\link{ml_list}} and \code{\link{ml_tune}}.
#'  The bwplot function is not documented on CRAN but you could see it on caret tutorial \url{https://topepo.github.io/caret/model-training-and-tuning.html}
#'
#'
#'@export


## plot the model performance for models with different metrics.
ml_bwplot=function(models,metric=NULL){
  requireNamespace("caret")
  # get the metrics from the caret model list.
  model_metrics=models%>%lapply( function(model_list){model_list$metric})%>%unlist
  # plot the model performance for metric-group ROC,Sens,Spec and/or Accuracy, Kappa.
  # decide the number of plots a.k.a groups
  # if there are two groups then find their indexes and get the models for differnt group.
  # if there is one group, then just plot it.
  if(c("ROC","Sens","Spec") %in% model_metrics && c("Accuracy","Kappa") %in% model_metrics){
    # if the model selection does not depend on model correlation. a.k.a the cor_level is null.
    if(is.null(metric)){
      models[model_metrics %in% c("ROC","Sens","Spec")]%>%resamples%>%bwplot%>%print

      models[model_metrics %in% c("Accuracy","Kappa")]%>%resamples%>%bwplot%>%print
    }else{
      models[model_metrics %in% c("ROC","Sens","Spec")]%>%resamples%>%bwplot(metric=metric)%>%print

      models[model_metrics %in% c("Accuracy","Kappa")]%>%resamples%>%bwplot(metric=metric)%>%print
    }

  }else{
    if(is.null(metric)){
      models%>%resamples%>%bwplot%>%print
    }else{
      models%>%resamples%>%bwplot(metric=metric)%>%print
    }
  }
  return(models)
}
