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

If an error occurred when installing, the most likely reason is an old version of R and/or Rstudio. Update R and Rstudio by re-installing them. 

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



This is the sessionInfo.

R version 3.4.4 (2018-03-15)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.4 LTS

Matrix products: default
BLAS: /usr/lib/libblas/libblas.so.3.6.0
LAPACK: /usr/lib/lapack/liblapack.so.3.6.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] testthat_1.0.2  automl_0.0.9000

loaded via a namespace (and not attached):
 [1] nlme_3.1-137       bitops_1.0-6       xts_0.10-0         lubridate_1.7.4    devtools_1.13.5    dimRed_0.1.0       doParallel_1.0.11  tools_3.4.4       
 [9] R6_2.2.2           rpart_4.1-13       KernSmooth_2.23-15 lazyeval_0.2.0     colorspace_1.3-2   nnet_7.3-12        DMwR_0.4.1         withr_2.1.2       
[17] tidyselect_0.2.4   mnormt_1.5-5       curl_2.6           compiler_3.4.4     caTools_1.17.1     scales_0.4.1       sfsmisc_1.1-2      DEoptimR_1.0-8    
[25] psych_1.8.3.3      robustbase_0.92-8  stringr_1.3.0      digest_0.6.12      foreign_0.8-69     dbscan_1.1-1       pkgconfig_2.0.1    rlang_0.2.0       
[33] TTR_0.23-2         ddalpha_1.3.2      rstudioapi_0.6     quantmod_0.4-10    MLmetrics_1.1.1    FNN_1.1            bindr_0.1.1        zoo_1.8-0         
[41] jsonlite_1.5       gtools_3.5.0       dplyr_0.7.4        ModelMetrics_1.1.0 RCurl_1.95-4.10    magrittr_1.5       ROSE_0.0-3         Matrix_1.2-14     
[49] Rcpp_0.12.16       munsell_0.4.3      abind_1.4-5        whisker_0.3-2      stringi_1.1.7      yaml_2.1.14        MASS_7.3-49        gplots_3.0.1      
[57] plyr_1.8.4         recipes_0.1.2      grid_3.4.4         parallel_3.4.4     gdata_2.18.0       crayon_1.3.4       lattice_0.20-35    splines_3.4.4     
[65] pillar_1.2.1       reshape2_1.4.3     codetools_0.2-15   stats4_3.4.4       CVST_0.2-1         magic_1.5-6        glue_1.2.0         foreach_1.4.4     
[73] gtable_0.2.0       purrr_0.2.4        tidyr_0.8.0        kernlab_0.9-25     assertthat_0.2.0   ggplot2_2.2.1      DRR_0.0.2          gower_0.1.2       
[81] prodlim_1.6.1      h2o_3.16.0.2       broom_0.4.4        class_7.3-14       survival_2.42-3    geometry_0.3-6     timeDate_3043.102  smotefamily_1.2   
[89] RcppRoll_0.2.2     tibble_1.4.2       iterators_1.0.9    memoise_1.1.0      bindrcpp_0.2.2     lava_1.5           caret_6.0-79       ROCR_1.0-7        
[97] ipred_0.9-6  
