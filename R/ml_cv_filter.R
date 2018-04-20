#' A function to filter models based on performance metrics from cross-validation.
#'
#'
#' Given a list of caret models, this function will select models based on the metrics from the cross-validation.
#'
#' What the function does is extract the cross-validation results like this models%>%resamples%>%.$values.
#' Then filter the models based on the summary function defined and the metric to use. This function could handle metrics "ROC", "Accuracy",
#' "Kappa","Spec","Sens" as supported by caret package natively for now. Expect to add more metrics in the future.
#'
#'
#' @param models A list of caret models generated from ml_list function or by combining caret models into a list manually.
#' @param metric A character, the metric used to filter models. The default is "ROC".
#' @param mini A numeric value, the minimum value of the metric summarization.
#' @param max A numeric value, the maximum value of the metric summarization.
#' @param FUN A function that summarise the performance metric from cross-validation, like median, sd or mean. The default is median.
#'
#'
#' @return A list of caret models that its performance metrics from cross-validation satisfy the conditions.
#'
#'
#'
#' @examples
#' \dontrun{
#'  # This select models that has a cv minimum of 0.75 median accuracy
#'  testmodels_metric_filtered=testmodels_churn%>%ml_cv_filter(metric="Accuracy",mini=0.75,FUN=median)
#'
#'  # this select models that has a cv minimum standard deviation of 0.01
#'  testmodels_metric_filtered=testmodels_churn%>%ml_cv_filter(metric="Accuracy",max=0.01,FUN=sd)
#'  # select models that has a cv minimum ROC median of 0.84 and a maximum ROC standard deviation of 0.01
#'  testmodels_metric_filtered=testmodels_churn%>%ml_cv_filter(metric="ROC",mini=0.84,FUN=median)%>%ml_cv_filter(metric="ROC",max=0.01,FUN=sd)
#'  # select models that has a cv median ROC value between 0.84 and 0.84275.
#'  testmodels_metric_filtered=testmodels_churn%>%filter_model(metric="ROC",mini=0.84,max=0.84275,FUN=median)
#'
#'
#'  # you could use custom functions to calculate a statistic for a k-fold performance metric.
#'  # Just define it in the global environment and use the function name without quotes in the FUN argument.
#'  # This function used the performance metrics after feed the model into resamples function in caret package.
#'  # You could get the same dataframe with model_list%>%resamples%>%.$values.
#'
#' }
#'
#'  @export
#'



ml_cv_filter=function(models,metric="ROC",mini=NULL,max=NULL,FUN=median){
  # get all the metrics in the model list
  model_metrics=models%>%lapply( function(model_list){model_list$metric})%>%unlist
  # if the metric is in the model_metrics, then select the models based on minimum value of the metric.
  # if(!metric %in% model_metrics){paste("There is no metric, ",metric,", in the model performance. "
  #                                     ,"Try using metrics:",glue::collapse(unique(model_metrics),sep=", ") )%>%stop() }


  # ==================================
  # define a function to filter models.
  filter_model=function(model,metric,FUN,mini=NULL,max=NULL){
    # model%>%resamples%>%.$values%>%print
    if(!is.null(FUN)){
      # if the FUN variable is not null, then we will use that function to apply to the performance metrics dataframe.
      # resample the models, select the performance metrics dataframe from the object,
      # then select the columns that contains the metric you selected in the function options.
      # then apply the function FUN to the list, and unlist the values and turn the vector into a TRUE or FALSE vector to select models in filtered_models.

      # value_for_switch is 1 when only mini variable is not null
      # value_for_switch is 2 when both mini and max variable are not null.
      # value_for_switch is 3 when only max variable is not null.
      value_for_switch=as.numeric(is.null(mini))+as.numeric(!is.null(max))+1
      switch (value_for_switch
              ,{
                # for using only mini
                print("using mini")
                filter_values=(model%>%resamples%>%.$values%>%select(contains(paste0("~",metric)))%>%apply(2,FUN)%>%unlist)>mini
              }
              ,{
                # for using max and mini
                print("using max and mini")
                filter_values_mini=(model%>%resamples%>%.$values%>%select(contains(paste0("~",metric)))%>%apply(2,FUN)%>%unlist)>mini
                filter_values_max=(model%>%resamples%>%.$values%>%select(contains(paste0("~",metric)))%>%apply(2,FUN)%>%unlist)<max
                filter_values=(filter_values_max & filter_values_mini)
              }
              ,{
                # for using only max
                print("using max")
                filter_values=(model%>%resamples%>%.$values%>%select(contains(paste0("~",metric)))%>%apply(2,FUN)%>%unlist)<max
              }
      )
      #model%>%resamples%>%.$values%>%select(contains(paste0("~",metric)))%>%apply(2,FUN)%>%unlist%>%print
      #filter_values%>%print
      filtered_model_from_metric=model[filter_values]
    }else{
      message("please give FUN variable a value like min or median")
    }

    return(filtered_model_from_metric)
  }
  # ==================================

  # select models based on which metric group the metric is in.
  # if ROC is in that list, then it will return the second option.
  # if ROC is not in that list, then it will return the first option. a.k.a kappa and accuracy models
  switch(as.numeric(metric %in% c("ROC","Sens","Spec"))+1
         ,{
           filtered_models=models[model_metrics %in% c("Accuracy","Kappa")]%>%filter_model(metric=metric,FUN=FUN,mini=mini,max=max)
         }
         ,{
           filtered_models=models[model_metrics %in% c("ROC","Sens","Spec")]%>%filter_model(metric=metric,FUN=FUN,mini=mini,max=max)
         }
  )

  return(filtered_models)
}





