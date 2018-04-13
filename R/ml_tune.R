#' Wrapper for auto-tune many ML algorithms supported by caret.
#'
#' Auto-tune ml model with different sampling methods, different metrics, preprocessing method, number of cores and etc, and return one model.
#'
#' When using grid search, there will be N_hyper_params^tuneLength of the models being trained.
#' When using random grid search, there will be tuneLength of models being trained, plus the eta is not set.
#' Use Random whenever possible unless you what to fine-tune one machine learning algorithm.
#'
#'
#' @importFrom  DMwR SMOTE
#' @importFrom ROSE ROSE
#' @import smotefamily
#' @import FNN
#' @import dbscan
#'
#'
#' @import foreach
#' @import doParallel
#' @import magrittr
#' @import caret
#' @import dplyr
#'
#' @import h2o
#'
#'
#'
#' @param data the data to be trained in dataframe format.
#'
#' @param target A character, column name of the target variable.
#'
#' @param sampling A character, examples are up, down, rose, smote as supported by caret. The current version also supports ADAS, ANS, BLSMOTE, DBSMOTE, RSLS, SLS.
#'                 For details on these sampling methods, please see the \href{smotefamily package}{https://CRAN.R-project.org/package=smotefamily} on CRAN.
#'
#' @param metric A character, examples are Accuracy, Kappa, ROC,Sens, and Spec as natively supported in caret package. F measures are expected in version(0.1.1).
#'
#' @param search A character, random or grid. Future version(0.1.1) would support user-defined hyper-parameter search.
#'
#' @param k A numeric, the number of cross-validation folds.
#'
#' @param tuneLength A numeric, the number of hyper-parameter combinations to try, the number of models to train is tuneLength\* k \* repeats.
#'
#' @param repeats A numeric, the number of repeats in cross-validation.
#'
#'
#' @param method A character, the name of the machine learning algorithm.
#'
#'
#' @param  preProcess A character vector, the names of the pre-processing methods to apply.
#'
#'
#' @param nthread A numeric, the number of cores to use in model training. It is best to set it to the number of physical cores you have minus 1.
#'
#' @param summaryFunction A function name. Use twoClassSummary for binary classification and multiClassSummary for multi-class classification.
#'
#' @return a list contains the model informaiton. The same structure as train function in caret package would return.
#'
#'
#' @examples
#' \dontrun{
#'
#'  ml_tune(data=training,target="target",sampling="down",metric="Accuracy",search = "random"
#'  ,k=10,tuneLength=2,repeats=1,method="xgbLinear",preProcess=NULL,summaryFunction=twoClassSummary,nthread=4)
#' }
#'
#'
#'
#' @export





ml_tune=function(data,target,sampling=NULL,metric="Accuracy",search = "random",k=10,tuneLength=2,repeats=1,method="xgbLinear",preProcess=NULL,summaryFunction=twoClassSummary,nthread=3){
  # load the machine learning library.
  library(caret)
  # register parallel backend package
  library(doParallel)


  # if the method name contains h2o then it is essential to initialize the h2o
  if(grepl(pattern="h2o",method)){
    library(h2o)
    h2o.init(nthreads=nthread) }

  # set the number of cores to 1 for some algorithms.
  if(method %in% c("OneR","LMT","mlpKerasDecay","mlpKerasDecayCost","mlpKerasDropout") ){
    nthread=1
  }
  # register the backend
  cl=makeCluster(nthread)
  registerDoParallel(cl)


  # implement different sampling methods. Only invoke the switch below if the sampling method is in the vector  c("ADAS","ANS","BLSMOTE","DBSMOTE","RSLS","SLS")
  if(!is.null(sampling)){
    if(sampling %in% c("ADAS","ANS","BLSMOTE","DBSMOTE","RSLS","SLS")){
      switch(sampling,
             ADAS={sampling <- list(name = "ADAS",
                                    func = function (x, y) {

                                      library(smotefamily)
                                      library(FNN)
                                      dat <- if (is.data.frame(x)) x else as.data.frame(x)

                                      dat$.y <- y

                                      dat <- ADAS(X=dat[, !grepl(".y", colnames(dat), fixed = TRUE)],target=dat$.y)
                                      dat=dat$data
                                      list(x = dat[,!colnames(dat)=="class"],
                                           y = as.factor(dat[,colnames(dat)=="class"]))

                                    }
                                    ,first = TRUE)

             },
             ANS={
               sampling <- list(name = "ANS",
                                func = function (x, y) {

                                  library(smotefamily)
                                  library(FNN)
                                  dat <- if (is.data.frame(x)) x else as.data.frame(x)

                                  dat$.y <- y

                                  dat <- ANS(X=dat[, !grepl(".y", colnames(dat), fixed = TRUE)],target=dat$.y)
                                  dat=dat$data
                                  list(x = dat[,!colnames(dat)=="class"],
                                       y = as.factor(dat[,colnames(dat)=="class"]))

                                }
                                ,first = TRUE)
             },
             BLSMOTE={
               sampling<-list(name = "BLSMOTE",
                              func = function (x, y) {

                                library(smotefamily)
                                library(FNN)
                                dat <- if (is.data.frame(x)) x else as.data.frame(x)

                                dat$.y <- y

                                dat <- BLSMOTE(X=dat[, !grepl(".y", colnames(dat), fixed = TRUE)],target=dat$.y)
                                dat=dat$data
                                list(x = dat[,!colnames(dat)=="class"],
                                     y = as.factor(dat[,colnames(dat)=="class"]))

                              }
                              ,first = TRUE)
             },
             DBSMOTE={
               sampling<-list(name = "DBSMOTE",
                              func = function (x, y) {

                                library(smotefamily)
                                library(dbscan)
                                dat <- if (is.data.frame(x)) x else as.data.frame(x)

                                dat$.y <- y

                                dat <- DBSMOTE(X=dat[, !grepl(".y", colnames(dat), fixed = TRUE)],target=dat$.y)
                                dat=dat$data
                                list(x = dat[,!colnames(dat)=="class"],
                                     y = as.factor(dat[,colnames(dat)=="class"]))

                              }
                              ,first = TRUE)
             },
             RSLS={
               sampling<-list(name = "RSLS",
                              func = function (x, y) {

                                library(smotefamily)
                                library(dbscan)
                                dat <- if (is.data.frame(x)) x else as.data.frame(x)

                                dat$.y <- y

                                dat <- RSLS(X=dat[, !grepl(".y", colnames(dat), fixed = TRUE)],target=dat$.y)
                                dat=dat$data
                                list(x = dat[,!colnames(dat)=="class"],
                                     y = as.factor(dat[,colnames(dat)=="class"]))

                              }
                              ,first = TRUE)
             },
             SLS={
               sampling<-list(name = "SLS",
                              func = function (x, y) {

                                library(smotefamily)
                                library(dbscan)
                                dat <- if (is.data.frame(x)) x else as.data.frame(x)

                                dat$.y <- y

                                dat <- SLS(X=dat[, !grepl(".y", colnames(dat), fixed = TRUE)],target=dat$.y)
                                dat=dat$data
                                list(x = dat[,!colnames(dat)=="class"],
                                     y = as.factor(dat[,colnames(dat)=="class"]))

                              }
                              ,first = TRUE)
             }

      )

    }
  }

  # end of the if for changing sampling method.

  # record the time
  timeRecordB()
  # change the trainControl for different metric.
  switch(metric,
         Accuracy={
           ctrl_with_sampling<- trainControl(method = "repeatedcv",number = k, repeats = repeats,sampling = sampling,search=search)
         },Kappa={
           ctrl_with_sampling<- trainControl(method = "repeatedcv",number = k, repeats = repeats,sampling = sampling,search=search)
         },ROC={
           ctrl_with_sampling<- trainControl(method = "repeatedcv",number = k, repeats = repeats,sampling = sampling,search=search,classProbs = TRUE,summaryFunction = summaryFunction)
         },Sens={
           ctrl_with_sampling<- trainControl(method = "repeatedcv",number = k, repeats = repeats,sampling = sampling,search=search,classProbs = TRUE,summaryFunction = summaryFunction)
         },Spec={
           ctrl_with_sampling<- trainControl(method = "repeatedcv",number = k, repeats = repeats,sampling = sampling,search=search,classProbs = TRUE,summaryFunction = summaryFunction)
         }
  )


  # train the function
  # consider change the input into x and y in the future.
  ml_with_sampling_preprocess=train(  x=data[,colnames(data)!=target]
                                      , y=data[,colnames(data)==target]
                                      , method=method
                                      , metric=metric
                                      , trControl=ctrl_with_sampling
                                      , tuneLength=tuneLength,preProcess=preProcess)
  # collapse the vector for preprocessing to a single character.
  preProcess=glue::collapse(preProcess,sep=" ")
  # The output message paste together.
  output_message=paste(method,sampling[[1]],metric,"tuneLength:",tuneLength,"search:",search,"preProcess:",preProcess,"cv_num:",k,"repeats:",repeats,sep=" ")
  # output the model that just finished training.
  output_message%>%message()
  #record the time use.
  timeRecordB(output_message = output_message)


  # wrap up the parallel connections.
  if(grepl(pattern="h2o",method)){
    h2o.shutdown(prompt = FALSE) }
  stopCluster(cl)
  stopImplicitCluster()
  gc()
  return(ml_with_sampling_preprocess)
}


