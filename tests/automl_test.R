
# tests for two timeRecord functions. 
devtools::install_github("edwardcooper/automl")
library(automl)
timeRecordB()
timeRecordB(output_message = "just testing")

timeRecordB()
timeRecordB(output_message = "amazing ")
timeRecordR()


#test for ml_tune 
remove.packages("e1071")
install.packages("e1071")
devtools::install_github("edwardcooper/automl",force=TRUE)
library(automl)
?ml_tune
iris_classification=ml_tune(data=iris,target = "Species",metric = "Kappa",search = "random",k=5,tuneLength = 2,repeats = 1,
        method = "rf",preProcess = c("center","scale"),summaryFunction = multiClassSummary)
predict(iris_classification,iris)

#test for ml_list
devtools::install_github("edwardcooper/automl")
library(automl)
?ml_list
params_grid=expand.grid(sampling=c("up","down","rose","ADAS")
                        ,metric=c("ROC","Accuracy","Kappa","Sens","Spec")
                        ,preProcess=list(c("zv","nzv","center","scale"),c("center","scale"))
                        ,method=c("glmnet","glm","bayesglm")
                        ,search="random"
                        ,tuneLength=10
                        ,k=10,nthread=3)

iris_list= ml_list(data=iris,target = "Species"
                   ,params = params_grid,summaryFunction=multiClassSummary,save_model="iris_models")

iris_list

# test for install_pkg_model_names
devtools::install_github("edwardcooper/automl")
library(automl)
?install_pkg_model_names
params_grid=expand.grid(sampling=c("up","down","rose","smote","ADAS")
                        ,metric=c("ROC","Accuracy","Kappa","Sens","Spec")
                        ,preProcess=list(c("zv","nzv","center","scale"),c("center","scale"))
                        ,method=c("glmnet","glm","bayesglm")
                        ,search="random"
                        ,tuneLength=10
                        ,k=10,nthread=3)
install_pkg_model_names(params_grid$method)

# test for model_list_load
devtools::install_github("edwardcooper/automl")
library(automl)
?model_list_load
iris_list=model_list_load(path="./iris_models")


#test for ml_bwplot
devtools::install_github("edwardcooper/automl")
library(automl)
iris_list=model_list_load(path="./iris_models")
ml_bwplot(iris_list)

# test for assign_names
devtools::install_github("edwardcooper/automl")
library(automl)
iris_list=model_list_load(path="./iris_models")
iris_list=assign_model_names(iris_list)
ml_bwplot(iris_list)


# test for ml_cv_filter
devtools::install_github("edwardcooper/automl")
library(automl)
iris_list=model_list_load(path="./iris_models")
iris_list=assign_model_names(iris_list)
ml_bwplot(iris_list)
library(magrittr)
iris_list=iris_list%>%ml_cv_filter(metric = "Kappa",min = 0.85,FUN = median) %>% ml_bwplot() %>%
            ml_cv_filter(metric = "Accuracy",min=0.85,FUN=min) %>% ml_bwplot()


# test for ml_cor_filter 

devtools::install_github("edwardcooper/automl")
library(automl)
iris_list=model_list_load(path="./iris_models")
iris_list=assign_model_names(iris_list)
ml_bwplot(iris_list)
library(magrittr)
iris_list=iris_list%>%ml_cv_filter(metric = "Kappa",min=0.85,FUN=median)%>%ml_bwplot()%>%
  ml_cv_filter(metric = "Accuracy",min=0.85,FUN=min)%>%ml_bwplot()

iris_list = iris_list %>% ml_cor_filter(cor_level = 0.75)




