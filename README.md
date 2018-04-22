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
It takes a while to install all the necessary packages, so go grab a cup of tea or coffeee. 


This pacakge is still in the early stage of developement and currently only support classification problems. But I will add support for regression soon. 

## Tutorial


### Model training
The main function is ml_list. Below is an example of how to use it. 



```r
# construct the parameter space
params_grid = expand.grid(sampling = c("up","down","rose","smote","ADAS")
                        ,metric = c("ROC","Accuracy","Kappa","Sens","Spec")
                        ,preProcess = list(c("zv","nzv","center","scale"),c("center","scale"))
                        ,method = c("glmnet","glm","bayesglm")
                        ,search = "random"
                        ,tuneLength = 10
                        ,k = 10,nthread = 3)
# install missing package dependencies.
install_pkg_model_names(params_grid$method)
 
iris_list = ml_list(data = iris,target = "Species"
                   ,params = params_grid, summaryFunction = multiClassSummary
                   ,save_model ="iris_models")
```

By assigning save_model option a character value "iris_model", each model is saved to a folder called iris_model.


side notes:

1. The sampling methods in this package contain more than up, down, rose, smote as supported by caret. The current version also supports ADAS, ANS, BLSMOTE, DBSMOTE, RSLS, SLS. For details on these sampling methods, please see the https://CRAN.R-project.org/package=smotefamily on CRAN.

2. The dataset iris is a multiclass classification problem, thus ROC, Sens and Spec are not really supported metrics. It is used to showcase all the possible metrics and how the packages do the error handling. 

3. For more detailed information on ml_list and ml_tune. Use `r ?ml_list` and `?ml_tune` in the R console. 






### Model Selection

This package also have some tools to help with model selection. We separate the model selection functions into two parts. The first part is to select models based on cross-validation results. The second part is to select models based on development set.

After training the models for a long time, we will need to load all models into the R console. 

```r
iris_list = model_list_load(path="./iris_models")

```

Before we proceed to select the models, we should first visualize the model performance. 

```r
ml_bwplot(iris_list)

```

Then you would notice that there is not meaningful information about what each model is. We should use the `r assing_model_names` function in the automl packages to give models names based on its names based on method, metric, preProcess and sampling methods.

```r
iris_list = assign_model_names(iris_list) 
```

Try visualize the models again. 

```r
ml_bwplot(iris_list)

```

Then, we want to choose models with a median Kappa value in cross-validation bigger than 0.85 and visualize the end results. 
```r
library(magrittr)
iris_list = iris_list %>% ml_cv_filter(metric = "Kappa",min = 0.85,FUN = median) %>% ml_bwplot()
```

This function also prints out whether each model satisfy the condition or not. 

Then, we want choose models with a minimum of Accuracy in cross-validation bigger than 0.87 and visualize the end results. 

```r
iris_list = iris_list %>% ml_cv_filter(metric = "Accuracy",min = 0.87,FUN = min) %>% ml_bwplot()
```

Last but not the least, we want to select models with small correlation between models. Let us assume that we want all out models to have correlation no bigger than 0.75.

This could be easily done using the `r ml_cor_filter` function in automl package.

```r
iris_list = iris_list %>% ml_cor_filter(cor_level=0.75)
```

To summarize all the operations above into a line. Always assign model names after load the models into R console.

```r
iris_list = model_list_load(path="./iris_models") %>% assign_model_names %>% ml_bwplot %>%
  ml_cv_filter(metric = "Kappa",min=0.85,FUN=median) %>% ml_bwplot %>%
  ml_cv_filter(metric = "Accuracy",min=0.85,FUN=min)%>%ml_bwplot() %>% ml_cor_filter(cor_level = 0.75)
```
