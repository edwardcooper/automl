#' A function to filter models based on inter-model correlation.
#'
#'
#' This function will also remove models that have NA value in resampled performance. a.k.a NA value in modelCor function output.
#' Mainly based on modelCor function in caret.
#'
#' What the function does is to first get rid of model performance with missing values. Second, filter models based on cor_level,
#' which is to get rid of the models with high correlation.
#'
#'
#' @param models A list of caret models generated from ml_list function or by combining caret models into a list manually.
#' @param cor_level A numeric, the maximum inter-model correlation computed from modelCor function from caret package.
#'
#'
#' @return A list of caret models that its performance metrics from cross-validation satisfy the conditions.
#'
#'
#'
#' @examples
#' \dontrun{
#'  # a maximum of correlation 0.9 between models.
#'  low_cor_models_churn=testmodels_churn%>%ml_cor_filter(cor_level = 0.9)
#'  # a maximum of correlation 0.7 between models.
#'  low_cor_models_churn=testmodels_churn%>%ml_cor_filter(cor_level = 0.7)
#'
#' }
#'
#'
#'
#'@export

ml_cor_filter=function(models,cor_level=0.9){
  # a function to remove models that have NA performance value after resample. a.k.a. modelCor function produces NA values.

  remove_models=function(models,cor_level){

    # suppress the warning from the modelCor, since we are trying to get rid of all models that have NA correlation value in modelCor.
    suppressWarnings(na_index<-(models%>%resamples%>%modelCor%>%is.na%>%apply(2,sum))==length(models[-1]))

    non_na_models=models[!na_index]
    paste("Number of NA model(s) removed:",(length(models)-length(non_na_models)) )%>%message

    high_cor_index=non_na_models%>%resamples%>%modelCor%>%findCorrelation(cutoff = cor_level)
    # the all models have a correlation level below cor_level, then you need to return the original list of models.
    if(!length(high_cor_index) ){
      low_cor_models=non_na_models
    }else{
      low_cor_models=non_na_models[-high_cor_index]
    }

    paste("Number of high correlation model(s) removed:",(length(non_na_models)-length(low_cor_models)) )%>%message

    return(low_cor_models)
  }

  # get the metrics from the caret model list.
  model_metrics=models%>%lapply( function(model_list){model_list$metric})%>%unlist
  # plot the model performance for metric-group ROC,Sens,Spec and/or Accuracy, Kappa.
  # decide the number of plots a.k.a groups
  # if there are two groups then find their indexes and get the models for differnt group.
  # if there is one group, then just plot it.
  if(c("ROC","Sens","Spec") %in% model_metrics && c("Accuracy","Kappa") %in% model_metrics){
    message("For ROC, Sens, and Spec metrics:")
    roc_models=models[model_metrics %in% c("ROC","Sens","Spec")]
    cleaned_roc_models=roc_models%>%remove_models(cor_level = cor_level)


    message("For Accuracy, Kappa metrics:")
    accu_models=models[model_metrics %in% c("Accuracy","Kappa")]
    cleaned_accu_models=accu_models%>%remove_models(cor_level = cor_level)

    cleaned_models=c(cleaned_roc_models,cleaned_accu_models)
  }else{
    cleaned_models=models%>%remove_models(cor_level = cor_level)
  }


  return (cleaned_models)
}

