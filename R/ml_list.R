#' A wrapper on ml_tune function to train hundreds of machine learning models.
#'
#' Auto-tune ml model with different sampling methods, different metrics, preprocessing method, number of cores and etc, and return many models in a list.
#'
#'
#' params is the a dataframe used to store all the variables for all parameters in ml_tune that are not in ml_list.
#' If you give save_model="fold_name" instead of NULL, evey ml model will be saved to that folder (it will create a folder if it does not exist)
#' plus a final rds file containing every model with return with the name "folder_name.rds" if the program execute successfully.
#' The goal of save_model option is to save the models to disk in case anything unexpected happened.
#'
#'
#' @import foreach
#' @import magrittr
#'
#'
#'
#' @param data the data to be trained in dataframe format.
#'
#' @param target A character, column name of the target variable.
#'
#' @param params A dataframe, each column contains different information for model training.
#'
#' @param summaryFunction A function name. Use twoClassSummary for binary classification and multiClassSummary for multi-class classification.
#'
#' @param save_model A character or NULL, if NULL no models will be saved to disk, if given a character(the folder name), all models will be saved to a folder.
#'
#'
#' @return a list contains the all the models. Each element in the list has same structure as train function in caret package would return.
#'
#'
#' @examples
#'
#'params_grid=expand.grid(sampling=c("up","down","rose","smote","ADAS")
#'                         ,metric=c("ROC","Accuracy","Kappa","Sens","Spec")
#'                         ,preProcess=list(c("zv","nzv","center","scale"),c("center","scale"))
#'                         ,method=c("glmnet","glm","bayesglm")
#'                         ,search="random"
#'                         ,tuneLength=10
#'                         ,k=10,nthread=3)
#'
#'
#'@seealso To test why one algorithm does not work or to fine-tune a specific model, try function \code{\link{ml_tune}} or use caret's train function \code{\link[caret]{train}}.
#'
#'
#'
#'@export

ml_list=function(data,target,params,summaryFunction=twoClassSummary,save_model=NULL){
  timeRecordB()
  # print the total numbers of models to be trained.
  print(paste("Total training model(s):",sum(params[,"tuneLength"]),sep=" " ))
  params%>%print()
  library(foreach)
  library(magrittr)


  # just do not add the .combine=list sovles the strange list structure.
  # remove the output if there is an error in training the model. .errorhandling = "remove".
  # use pass instead of remove in errorhandling in foreach.
  # See https://cran.r-project.org/web/packages/foreach/foreach.pdf for details.
  model_list=foreach(i=1:nrow(params),.packages = c("caret","magrittr"),.errorhandling = "pass")%do%{

    ### If there is sampling information in the params then give sampling that value, if sampling has a NULL character value, give it a NULL.
    if("sampling" %in% colnames(params) ){
      sampling=params[i,"sampling"]%>%as.character()
      if(sampling=="NULL"){sampling=NULL}
    }else{sampling=NULL}
    # Do the same for preprocess variable.
    if("preProcess" %in% colnames(params) ){
      preProcess=params[i,"preProcess"]%>%.[[1]]
      if(preProcess[1]=="NULL"){preProcess=NULL}
    }else{preProcess=NULL}

    # give nthread a number of 4 if not specified. Since most desktop or more powerful laptops have four cores.
    if("nthread" %in% colnames(params)){
      nthread=params[i,"nthread"]%>%as.numeric()
    }else{
      nthread=4
    }
    # give repeats a default number 1 if not specified.
    if("repeats" %in% colnames(params)){
      repeats=params[i,"repeats"]%>%as.numeric()
    }else{
      repeats=1
    }
    method=params[i,"method"]%>%as.character()
    search=params[i,"search"]%>%as.character()
    tuneLength=params[i,"tuneLength"]%>%as.character()
    metric=params[i,"metric"]%>%as.character()
    k=params[i,"k"]%>%as.numeric()


    # model training part.
    # add tryCatch for error handling.

    ml_model_train=ml_tune(data=data,target=target,sampling=sampling,preProcess=preProcess
                           ,metric=metric
                           ,tuneLength=tuneLength
                           ,search=search
                           ,repeats = repeats
                           ,k=k
                           ,nthread=nthread
                           ,method=method
                           ,summaryFunction = summaryFunction)


    #paste(method,metric,tuneLength,search,sampling,preProcess,sep=" ")%>%message()
    #print the number of models that have been trained.
    paste("Finished training: ",i,"/",nrow(params),sep="")%>%message()


    # save each model to disk.
    # ======================================
    # change the preprocess vector into a single chr.
    preProcess_message=glue::collapse(preProcess,sep="_")
    file_name=paste(i,method,sampling,preProcess_message,metric,sep="_")
    # if the save_model is not null, then save each model
    if(!is.null(save_model)){
      # Use the save_model string as the name for the subdirectory to store each models.
      dir_path=paste("./",save_model,sep="")
      # If the dir_path does not exist, create a subdirectory.
      if(!dir.exists(dir_path)){  dir.create(dir_path)  }
      # save the models to that subdirectory with file_name.
      file_name=paste(dir_path,"/",file_name,sep="")
      # save the models
      saveRDS(ml_model_train,file=paste(file_name,".rds",sep=""))
    }
    # ====================================================
    return(ml_model_train)
  }

  # finally save the entire model list to disk.
  if(!is.null(save_model)){ saveRDS(model_list,file=paste(save_model,".rds",sep="") ) }

  return(model_list)
}

