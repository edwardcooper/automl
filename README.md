# automl
A R package to make training hundreds of machine learning models with a few lines of code. 

It is basically a wrapper on top of the caret package.

## Installation 



To use it, please manually install e1071 pacakge first,
```r
install.packages("e1071")
```
Then, install the latest version of the automl packages in github: 
```r
devtools::install_github("edwardcooper/automl")
```

This pacakge is still in the early stage of developement and currently only support classification problems.

## Tutorial
The main function is ml_list. Below is an example of how to use it. 



```r
# construct the parameter space
params_grid=expand.grid(sampling=c("up","down","rose","smote","ADAS")
                        ,metric=c("ROC","Accuracy","Kappa","Sens","Spec")
                        ,preProcess=list(c("zv","nzv","center","scale"),c("center","scale"))
                        ,method=c("glmnet","glm","bayesglm")
                        ,search="random"
                        ,tuneLength=10
                        ,k=10,nthread=3)
# install missing package dependencies.
install_pkg_model_names(params_grid$method)
 
iris_list= ml_list(data=iris,target = "Species"
                   ,params = params_grid,summaryFunction=multiClassSummary
                   ,save_model="iris_models")
```

By assigning save_model option a character value "iris_model", each model is saved to a folder called iris_model. 
