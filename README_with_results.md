automl
======

An R package to make training hundreds of machine learning models with a few lines of code.

It is basically a wrapper on top of the caret package.

Installation
------------

To use it, please manually install e1071 package first,

``` r
install.packages("e1071")
```

    ## Installing package into '/home/edward/R/x86_64-pc-linux-gnu-library/3.4'
    ## (as 'lib' is unspecified)

Then, install the latest version of the automl packages in Github:

``` r
devtools::install_github("edwardcooper/automl")
```

    ## Skipping install of 'automl' from a github remote, the SHA1 (da2361fb) has not changed since last install.
    ##   Use `force = TRUE` to force installation

It takes a while to install all the necessary packages, so go grab a cup of tea or coffee.

This package is still in the early stage of development and currently only support classification problems. But I will add support for regression soon.

If an error occurred when installing, the most likely reason is an old version of R and/or Rstudio. Update R and Rstudio by re-installing them.

Tutorial
--------

### Model training

The main function is ml\_list. Below is an example of how to use it.

``` r
library(automl)
```

    ## Warning: replacing previous import 'MLmetrics::MAE' by 'caret::MAE' when
    ## loading 'automl'

    ## Warning: replacing previous import 'MLmetrics::RMSE' by 'caret::RMSE' when
    ## loading 'automl'

``` r
# construct the parameter space
params_grid = expand.grid(sampling = c("up","down","rose","smote","ADAS")
                        ,metric = c("ROC","Accuracy","Kappa","Sens","Spec")
                        ,preProcess = list(c("zv","nzv","center","scale"),c("center","scale"))
                        ,method = c("rf","xgbTree","LogitBoost")
                        ,search = "random"
                        ,tuneLength = 10
                        ,k = 10,nthread = 3)
# install missing package dependencies.
install_pkg_model_names(params_grid$method)
```

    ## No missing package dependency.

``` r
iris_list = ml_list(data = iris,target = "Species"
                   ,params = params_grid, summaryFunction = multiClassSummary
                   ,save_model ="iris_models")
```

    ## [1] "Fun time log has been created"

    ## Loading required package: magrittr

    ## [1] "Total training model(s): 1500"
    ##     sampling   metric             preProcess     method search tuneLength
    ## 1         up      ROC zv, nzv, center, scale         rf random         10
    ## 2       down      ROC zv, nzv, center, scale         rf random         10
    ## 3       rose      ROC zv, nzv, center, scale         rf random         10
    ## 4      smote      ROC zv, nzv, center, scale         rf random         10
    ## 5       ADAS      ROC zv, nzv, center, scale         rf random         10
    ## 6         up Accuracy zv, nzv, center, scale         rf random         10
    ## 7       down Accuracy zv, nzv, center, scale         rf random         10
    ## 8       rose Accuracy zv, nzv, center, scale         rf random         10
    ## 9      smote Accuracy zv, nzv, center, scale         rf random         10
    ## 10      ADAS Accuracy zv, nzv, center, scale         rf random         10
    ## 11        up    Kappa zv, nzv, center, scale         rf random         10
    ## 12      down    Kappa zv, nzv, center, scale         rf random         10
    ## 13      rose    Kappa zv, nzv, center, scale         rf random         10
    ## 14     smote    Kappa zv, nzv, center, scale         rf random         10
    ## 15      ADAS    Kappa zv, nzv, center, scale         rf random         10
    ## 16        up     Sens zv, nzv, center, scale         rf random         10
    ## 17      down     Sens zv, nzv, center, scale         rf random         10
    ## 18      rose     Sens zv, nzv, center, scale         rf random         10
    ## 19     smote     Sens zv, nzv, center, scale         rf random         10
    ## 20      ADAS     Sens zv, nzv, center, scale         rf random         10
    ## 21        up     Spec zv, nzv, center, scale         rf random         10
    ## 22      down     Spec zv, nzv, center, scale         rf random         10
    ## 23      rose     Spec zv, nzv, center, scale         rf random         10
    ## 24     smote     Spec zv, nzv, center, scale         rf random         10
    ## 25      ADAS     Spec zv, nzv, center, scale         rf random         10
    ## 26        up      ROC          center, scale         rf random         10
    ## 27      down      ROC          center, scale         rf random         10
    ## 28      rose      ROC          center, scale         rf random         10
    ## 29     smote      ROC          center, scale         rf random         10
    ## 30      ADAS      ROC          center, scale         rf random         10
    ## 31        up Accuracy          center, scale         rf random         10
    ## 32      down Accuracy          center, scale         rf random         10
    ## 33      rose Accuracy          center, scale         rf random         10
    ## 34     smote Accuracy          center, scale         rf random         10
    ## 35      ADAS Accuracy          center, scale         rf random         10
    ## 36        up    Kappa          center, scale         rf random         10
    ## 37      down    Kappa          center, scale         rf random         10
    ## 38      rose    Kappa          center, scale         rf random         10
    ## 39     smote    Kappa          center, scale         rf random         10
    ## 40      ADAS    Kappa          center, scale         rf random         10
    ## 41        up     Sens          center, scale         rf random         10
    ## 42      down     Sens          center, scale         rf random         10
    ## 43      rose     Sens          center, scale         rf random         10
    ## 44     smote     Sens          center, scale         rf random         10
    ## 45      ADAS     Sens          center, scale         rf random         10
    ## 46        up     Spec          center, scale         rf random         10
    ## 47      down     Spec          center, scale         rf random         10
    ## 48      rose     Spec          center, scale         rf random         10
    ## 49     smote     Spec          center, scale         rf random         10
    ## 50      ADAS     Spec          center, scale         rf random         10
    ## 51        up      ROC zv, nzv, center, scale    xgbTree random         10
    ## 52      down      ROC zv, nzv, center, scale    xgbTree random         10
    ## 53      rose      ROC zv, nzv, center, scale    xgbTree random         10
    ## 54     smote      ROC zv, nzv, center, scale    xgbTree random         10
    ## 55      ADAS      ROC zv, nzv, center, scale    xgbTree random         10
    ## 56        up Accuracy zv, nzv, center, scale    xgbTree random         10
    ## 57      down Accuracy zv, nzv, center, scale    xgbTree random         10
    ## 58      rose Accuracy zv, nzv, center, scale    xgbTree random         10
    ## 59     smote Accuracy zv, nzv, center, scale    xgbTree random         10
    ## 60      ADAS Accuracy zv, nzv, center, scale    xgbTree random         10
    ## 61        up    Kappa zv, nzv, center, scale    xgbTree random         10
    ## 62      down    Kappa zv, nzv, center, scale    xgbTree random         10
    ## 63      rose    Kappa zv, nzv, center, scale    xgbTree random         10
    ## 64     smote    Kappa zv, nzv, center, scale    xgbTree random         10
    ## 65      ADAS    Kappa zv, nzv, center, scale    xgbTree random         10
    ## 66        up     Sens zv, nzv, center, scale    xgbTree random         10
    ## 67      down     Sens zv, nzv, center, scale    xgbTree random         10
    ## 68      rose     Sens zv, nzv, center, scale    xgbTree random         10
    ## 69     smote     Sens zv, nzv, center, scale    xgbTree random         10
    ## 70      ADAS     Sens zv, nzv, center, scale    xgbTree random         10
    ## 71        up     Spec zv, nzv, center, scale    xgbTree random         10
    ## 72      down     Spec zv, nzv, center, scale    xgbTree random         10
    ## 73      rose     Spec zv, nzv, center, scale    xgbTree random         10
    ## 74     smote     Spec zv, nzv, center, scale    xgbTree random         10
    ## 75      ADAS     Spec zv, nzv, center, scale    xgbTree random         10
    ## 76        up      ROC          center, scale    xgbTree random         10
    ## 77      down      ROC          center, scale    xgbTree random         10
    ## 78      rose      ROC          center, scale    xgbTree random         10
    ## 79     smote      ROC          center, scale    xgbTree random         10
    ## 80      ADAS      ROC          center, scale    xgbTree random         10
    ## 81        up Accuracy          center, scale    xgbTree random         10
    ## 82      down Accuracy          center, scale    xgbTree random         10
    ## 83      rose Accuracy          center, scale    xgbTree random         10
    ## 84     smote Accuracy          center, scale    xgbTree random         10
    ## 85      ADAS Accuracy          center, scale    xgbTree random         10
    ## 86        up    Kappa          center, scale    xgbTree random         10
    ## 87      down    Kappa          center, scale    xgbTree random         10
    ## 88      rose    Kappa          center, scale    xgbTree random         10
    ## 89     smote    Kappa          center, scale    xgbTree random         10
    ## 90      ADAS    Kappa          center, scale    xgbTree random         10
    ## 91        up     Sens          center, scale    xgbTree random         10
    ## 92      down     Sens          center, scale    xgbTree random         10
    ## 93      rose     Sens          center, scale    xgbTree random         10
    ## 94     smote     Sens          center, scale    xgbTree random         10
    ## 95      ADAS     Sens          center, scale    xgbTree random         10
    ## 96        up     Spec          center, scale    xgbTree random         10
    ## 97      down     Spec          center, scale    xgbTree random         10
    ## 98      rose     Spec          center, scale    xgbTree random         10
    ## 99     smote     Spec          center, scale    xgbTree random         10
    ## 100     ADAS     Spec          center, scale    xgbTree random         10
    ## 101       up      ROC zv, nzv, center, scale LogitBoost random         10
    ## 102     down      ROC zv, nzv, center, scale LogitBoost random         10
    ## 103     rose      ROC zv, nzv, center, scale LogitBoost random         10
    ## 104    smote      ROC zv, nzv, center, scale LogitBoost random         10
    ## 105     ADAS      ROC zv, nzv, center, scale LogitBoost random         10
    ## 106       up Accuracy zv, nzv, center, scale LogitBoost random         10
    ## 107     down Accuracy zv, nzv, center, scale LogitBoost random         10
    ## 108     rose Accuracy zv, nzv, center, scale LogitBoost random         10
    ## 109    smote Accuracy zv, nzv, center, scale LogitBoost random         10
    ## 110     ADAS Accuracy zv, nzv, center, scale LogitBoost random         10
    ## 111       up    Kappa zv, nzv, center, scale LogitBoost random         10
    ## 112     down    Kappa zv, nzv, center, scale LogitBoost random         10
    ## 113     rose    Kappa zv, nzv, center, scale LogitBoost random         10
    ## 114    smote    Kappa zv, nzv, center, scale LogitBoost random         10
    ## 115     ADAS    Kappa zv, nzv, center, scale LogitBoost random         10
    ## 116       up     Sens zv, nzv, center, scale LogitBoost random         10
    ## 117     down     Sens zv, nzv, center, scale LogitBoost random         10
    ## 118     rose     Sens zv, nzv, center, scale LogitBoost random         10
    ## 119    smote     Sens zv, nzv, center, scale LogitBoost random         10
    ## 120     ADAS     Sens zv, nzv, center, scale LogitBoost random         10
    ## 121       up     Spec zv, nzv, center, scale LogitBoost random         10
    ## 122     down     Spec zv, nzv, center, scale LogitBoost random         10
    ## 123     rose     Spec zv, nzv, center, scale LogitBoost random         10
    ## 124    smote     Spec zv, nzv, center, scale LogitBoost random         10
    ## 125     ADAS     Spec zv, nzv, center, scale LogitBoost random         10
    ## 126       up      ROC          center, scale LogitBoost random         10
    ## 127     down      ROC          center, scale LogitBoost random         10
    ## 128     rose      ROC          center, scale LogitBoost random         10
    ## 129    smote      ROC          center, scale LogitBoost random         10
    ## 130     ADAS      ROC          center, scale LogitBoost random         10
    ## 131       up Accuracy          center, scale LogitBoost random         10
    ## 132     down Accuracy          center, scale LogitBoost random         10
    ## 133     rose Accuracy          center, scale LogitBoost random         10
    ## 134    smote Accuracy          center, scale LogitBoost random         10
    ## 135     ADAS Accuracy          center, scale LogitBoost random         10
    ## 136       up    Kappa          center, scale LogitBoost random         10
    ## 137     down    Kappa          center, scale LogitBoost random         10
    ## 138     rose    Kappa          center, scale LogitBoost random         10
    ## 139    smote    Kappa          center, scale LogitBoost random         10
    ## 140     ADAS    Kappa          center, scale LogitBoost random         10
    ## 141       up     Sens          center, scale LogitBoost random         10
    ## 142     down     Sens          center, scale LogitBoost random         10
    ## 143     rose     Sens          center, scale LogitBoost random         10
    ## 144    smote     Sens          center, scale LogitBoost random         10
    ## 145     ADAS     Sens          center, scale LogitBoost random         10
    ## 146       up     Spec          center, scale LogitBoost random         10
    ## 147     down     Spec          center, scale LogitBoost random         10
    ## 148     rose     Spec          center, scale LogitBoost random         10
    ## 149    smote     Spec          center, scale LogitBoost random         10
    ## 150     ADAS     Spec          center, scale LogitBoost random         10
    ##      k nthread
    ## 1   10       3
    ## 2   10       3
    ## 3   10       3
    ## 4   10       3
    ## 5   10       3
    ## 6   10       3
    ## 7   10       3
    ## 8   10       3
    ## 9   10       3
    ## 10  10       3
    ## 11  10       3
    ## 12  10       3
    ## 13  10       3
    ## 14  10       3
    ## 15  10       3
    ## 16  10       3
    ## 17  10       3
    ## 18  10       3
    ## 19  10       3
    ## 20  10       3
    ## 21  10       3
    ## 22  10       3
    ## 23  10       3
    ## 24  10       3
    ## 25  10       3
    ## 26  10       3
    ## 27  10       3
    ## 28  10       3
    ## 29  10       3
    ## 30  10       3
    ## 31  10       3
    ## 32  10       3
    ## 33  10       3
    ## 34  10       3
    ## 35  10       3
    ## 36  10       3
    ## 37  10       3
    ## 38  10       3
    ## 39  10       3
    ## 40  10       3
    ## 41  10       3
    ## 42  10       3
    ## 43  10       3
    ## 44  10       3
    ## 45  10       3
    ## 46  10       3
    ## 47  10       3
    ## 48  10       3
    ## 49  10       3
    ## 50  10       3
    ## 51  10       3
    ## 52  10       3
    ## 53  10       3
    ## 54  10       3
    ## 55  10       3
    ## 56  10       3
    ## 57  10       3
    ## 58  10       3
    ## 59  10       3
    ## 60  10       3
    ## 61  10       3
    ## 62  10       3
    ## 63  10       3
    ## 64  10       3
    ## 65  10       3
    ## 66  10       3
    ## 67  10       3
    ## 68  10       3
    ## 69  10       3
    ## 70  10       3
    ## 71  10       3
    ## 72  10       3
    ## 73  10       3
    ## 74  10       3
    ## 75  10       3
    ## 76  10       3
    ## 77  10       3
    ## 78  10       3
    ## 79  10       3
    ## 80  10       3
    ## 81  10       3
    ## 82  10       3
    ## 83  10       3
    ## 84  10       3
    ## 85  10       3
    ## 86  10       3
    ## 87  10       3
    ## 88  10       3
    ## 89  10       3
    ## 90  10       3
    ## 91  10       3
    ## 92  10       3
    ## 93  10       3
    ## 94  10       3
    ## 95  10       3
    ## 96  10       3
    ## 97  10       3
    ## 98  10       3
    ## 99  10       3
    ## 100 10       3
    ## 101 10       3
    ## 102 10       3
    ## 103 10       3
    ## 104 10       3
    ## 105 10       3
    ## 106 10       3
    ## 107 10       3
    ## 108 10       3
    ## 109 10       3
    ## 110 10       3
    ## 111 10       3
    ## 112 10       3
    ## 113 10       3
    ## 114 10       3
    ## 115 10       3
    ## 116 10       3
    ## 117 10       3
    ## 118 10       3
    ## 119 10       3
    ## 120 10       3
    ## 121 10       3
    ## 122 10       3
    ## 123 10       3
    ## 124 10       3
    ## 125 10       3
    ## 126 10       3
    ## 127 10       3
    ## 128 10       3
    ## 129 10       3
    ## 130 10       3
    ## 131 10       3
    ## 132 10       3
    ## 133 10       3
    ## 134 10       3
    ## 135 10       3
    ## 136 10       3
    ## 137 10       3
    ## 138 10       3
    ## 139 10       3
    ## 140 10       3
    ## 141 10       3
    ## 142 10       3
    ## 143 10       3
    ## 144 10       3
    ## 145 10       3
    ## 146 10       3
    ## 147 10       3
    ## 148 10       3
    ## 149 10       3
    ## 150 10       3

    ## Loading required package: lattice

    ## Loading required package: ggplot2

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 1/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf down ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 2/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## Loading required package: grid

    ## rf smote ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 4/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 6/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf down Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 7/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :4     NA's   :4

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf smote Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 9/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :4     NA's   :4

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf up Kappa tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 11/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf down Kappa tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 12/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :5     NA's   :5

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf smote Kappa tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 14/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :5     NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 16/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf down Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 17/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf smote Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 19/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 21/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf down Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 22/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf smote Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 24/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 26/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf down ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 27/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :3                   NA's   :3     NA's   :3     NA's   :3    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :3     NA's   :3        NA's   :3        NA's   :3          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :3           NA's   :3      NA's   :3     NA's   :3          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :3

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf smote ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 29/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :4                   NA's   :4     NA's   :4     NA's   :4    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :4     NA's   :4        NA's   :4        NA's   :4          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :4           NA's   :4      NA's   :4     NA's   :4          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :4

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 31/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf down Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 32/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :5     NA's   :5

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf smote Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 34/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :5     NA's   :5

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf up Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 36/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf down Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 37/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :4     NA's   :4

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : missing values found in aggregated results

    ## rf smote Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 39/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :5     NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 41/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf down Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 42/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf smote Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 44/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf up Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 46/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf down Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 47/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :4                   NA's   :4     NA's   :4     NA's   :4    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :4     NA's   :4        NA's   :4        NA's   :4          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :4           NA's   :4      NA's   :4     NA's   :4          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :4

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## missing values found in aggregated results

    ## rf smote Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 49/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :5                   NA's   :5     NA's   :5     NA's   :5    
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :5     NA's   :5        NA's   :5        NA's   :5          
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :5           NA's   :5      NA's   :5     NA's   :5          
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :5

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree up ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 51/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree down ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 52/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree smote ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 54/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## xgbTree up Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 56/150

    ## xgbTree down Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 57/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## xgbTree smote Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 59/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## xgbTree up Kappa tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 61/150

    ## xgbTree down Kappa tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 62/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## xgbTree smote Kappa tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 64/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree up Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 66/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree down Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 67/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## xgbTree smote Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 69/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree up Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 71/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree down Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 72/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## xgbTree smote Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 74/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## xgbTree up ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 76/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree down ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 77/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree smote ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 79/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## xgbTree up Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 81/150

    ## xgbTree down Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 82/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## xgbTree smote Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 84/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## xgbTree up Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 86/150

    ## xgbTree down Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 87/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## xgbTree smote Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 89/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree up Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 91/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree down Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 92/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## xgbTree smote Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 94/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree up Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 96/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## xgbTree down Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 97/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## xgbTree smote Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 99/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## LogitBoost down ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 102/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## LogitBoost smote ROC tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 104/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## LogitBoost up Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 106/150

    ## LogitBoost down Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 107/150

    ## LogitBoost smote Accuracy tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 109/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## LogitBoost up Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 116/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## LogitBoost smote Sens tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 119/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## LogitBoost up Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 121/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## LogitBoost down Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 122/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## LogitBoost smote Spec tuneLength: 10 search: random preProcess: zv nzv center scale cv_num: 10 repeats: 1

    ## Finished training: 124/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## LogitBoost up ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 126/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## LogitBoost smote ROC tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 129/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "ROC" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## LogitBoost up Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 131/150

    ## LogitBoost down Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 132/150

    ## LogitBoost smote Accuracy tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 134/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Accuracy metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## LogitBoost up Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 136/150

    ## LogitBoost smote Kappa tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 139/150

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the Kappa metric values are missing:
    ##     Accuracy       Kappa    
    ##  Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   : NA  
    ##  NA's   :10    NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## LogitBoost up Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 141/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## LogitBoost down Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 142/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## LogitBoost smote Sens tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 144/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Sens" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## LogitBoost up Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 146/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## LogitBoost down Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 147/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
    ## trainInfo, : There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## LogitBoost smote Spec tuneLength: 10 search: random preProcess: center scale cv_num: 10 repeats: 1

    ## Finished training: 149/150

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## The metric "Spec" was not in the result set. logLoss will be used instead.

    ## Warning in train.default(x = data[, colnames(data) != target], y = data[, :
    ## There were missing values in resampled performance measures.

    ## Something is wrong; all the logLoss metric values are missing:
    ##     logLoss         AUC          prAUC        Accuracy       Kappa    
    ##  Min.   : NA   Min.   :0.5   Min.   : NA   Min.   : NA   Min.   : NA  
    ##  1st Qu.: NA   1st Qu.:0.5   1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
    ##  Median : NA   Median :0.5   Median : NA   Median : NA   Median : NA  
    ##  Mean   :NaN   Mean   :0.5   Mean   :NaN   Mean   :NaN   Mean   :NaN  
    ##  3rd Qu.: NA   3rd Qu.:0.5   3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
    ##  Max.   : NA   Max.   :0.5   Max.   : NA   Max.   : NA   Max.   : NA  
    ##  NA's   :10                  NA's   :10    NA's   :10    NA's   :10   
    ##     Mean_F1    Mean_Sensitivity Mean_Specificity Mean_Pos_Pred_Value
    ##  Min.   : NA   Min.   : NA      Min.   : NA      Min.   : NA        
    ##  1st Qu.: NA   1st Qu.: NA      1st Qu.: NA      1st Qu.: NA        
    ##  Median : NA   Median : NA      Median : NA      Median : NA        
    ##  Mean   :NaN   Mean   :NaN      Mean   :NaN      Mean   :NaN        
    ##  3rd Qu.: NA   3rd Qu.: NA      3rd Qu.: NA      3rd Qu.: NA        
    ##  Max.   : NA   Max.   : NA      Max.   : NA      Max.   : NA        
    ##  NA's   :10    NA's   :10       NA's   :10       NA's   :10         
    ##  Mean_Neg_Pred_Value Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##  Min.   : NA         Min.   : NA    Min.   : NA   Min.   : NA        
    ##  1st Qu.: NA         1st Qu.: NA    1st Qu.: NA   1st Qu.: NA        
    ##  Median : NA         Median : NA    Median : NA   Median : NA        
    ##  Mean   :NaN         Mean   :NaN    Mean   :NaN   Mean   :NaN        
    ##  3rd Qu.: NA         3rd Qu.: NA    3rd Qu.: NA   3rd Qu.: NA        
    ##  Max.   : NA         Max.   : NA    Max.   : NA   Max.   : NA        
    ##  NA's   :10          NA's   :10     NA's   :10    NA's   :10         
    ##  Mean_Balanced_Accuracy
    ##  Min.   : NA           
    ##  1st Qu.: NA           
    ##  Median : NA           
    ##  Mean   :NaN           
    ##  3rd Qu.: NA           
    ##  Max.   : NA           
    ##  NA's   :10

    ## All loaded packages are removed.

By assigning save\_model option a character value "iris\_model", each model is saved to a folder called iris\_model.

side notes:

1.  The sampling methods in this package contain more than up, down, rose, smote as supported by the caret. The current version also supports ADAS, ANS, BLSMOTE, DBSMOTE, RSLS, SLS. For details on these sampling methods, please see the <https://CRAN.R-project.org/package=smotefamily> on CRAN.

2.  The dataset iris is a multi-class classification problem, thus ROC, Sens, and Spec are not really supported metrics. It is used to showcase all the possible metrics and how the packages do the error handling.

For more detailed information on ml\_list and ml\_tune. Use /home/edward/R/x86\_64-pc-linux-gnu-library/3.4/automl/help/ml\_list and /home/edward/R/x86\_64-pc-linux-gnu-library/3.4/automl/help/ml\_tune in the R console.

### Model Selection

This package also has some tools to help with model selection. We separate the model selection functions into two parts. The first part is to select models based on cross-validation results. The second part is to select models based on the development set.

After training the models for a long time, we will need to load all models into the R console.

``` r
iris_list = model_list_load(path="./iris_models")
```

    ## Loading 88 models.

    ## Finished loading model: 102_LogitBoost_down_zv_nzv_center_scale_ROC.rds 
    ##  1 / 88

    ## Finished loading model: 104_LogitBoost_smote_zv_nzv_center_scale_ROC.rds 
    ##  2 / 88

    ## Finished loading model: 106_LogitBoost_up_zv_nzv_center_scale_Accuracy.rds 
    ##  3 / 88

    ## Finished loading model: 107_LogitBoost_down_zv_nzv_center_scale_Accuracy.rds 
    ##  4 / 88

    ## Finished loading model: 109_LogitBoost_smote_zv_nzv_center_scale_Accuracy.rds 
    ##  5 / 88

    ## Finished loading model: 111_LogitBoost_up_zv_nzv_center_scale_Kappa.rds 
    ##  6 / 88

    ## Finished loading model: 114_LogitBoost_smote_zv_nzv_center_scale_Kappa.rds 
    ##  7 / 88

    ## Finished loading model: 116_LogitBoost_up_zv_nzv_center_scale_Sens.rds 
    ##  8 / 88

    ## Finished loading model: 117_LogitBoost_down_zv_nzv_center_scale_Sens.rds 
    ##  9 / 88

    ## Finished loading model: 119_LogitBoost_smote_zv_nzv_center_scale_Sens.rds 
    ##  10 / 88

    ## Finished loading model: 11_rf_up_zv_nzv_center_scale_Kappa.rds 
    ##  11 / 88

    ## Finished loading model: 121_LogitBoost_up_zv_nzv_center_scale_Spec.rds 
    ##  12 / 88

    ## Finished loading model: 122_LogitBoost_down_zv_nzv_center_scale_Spec.rds 
    ##  13 / 88

    ## Finished loading model: 124_LogitBoost_smote_zv_nzv_center_scale_Spec.rds 
    ##  14 / 88

    ## Finished loading model: 126_LogitBoost_up_center_scale_ROC.rds 
    ##  15 / 88

    ## Finished loading model: 127_LogitBoost_down_center_scale_ROC.rds 
    ##  16 / 88

    ## Finished loading model: 129_LogitBoost_smote_center_scale_ROC.rds 
    ##  17 / 88

    ## Finished loading model: 12_rf_down_zv_nzv_center_scale_Kappa.rds 
    ##  18 / 88

    ## Finished loading model: 131_LogitBoost_up_center_scale_Accuracy.rds 
    ##  19 / 88

    ## Finished loading model: 132_LogitBoost_down_center_scale_Accuracy.rds 
    ##  20 / 88

    ## Finished loading model: 134_LogitBoost_smote_center_scale_Accuracy.rds 
    ##  21 / 88

    ## Finished loading model: 136_LogitBoost_up_center_scale_Kappa.rds 
    ##  22 / 88

    ## Finished loading model: 137_LogitBoost_down_center_scale_Kappa.rds 
    ##  23 / 88

    ## Finished loading model: 139_LogitBoost_smote_center_scale_Kappa.rds 
    ##  24 / 88

    ## Finished loading model: 141_LogitBoost_up_center_scale_Sens.rds 
    ##  25 / 88

    ## Finished loading model: 142_LogitBoost_down_center_scale_Sens.rds 
    ##  26 / 88

    ## Finished loading model: 144_LogitBoost_smote_center_scale_Sens.rds 
    ##  27 / 88

    ## Finished loading model: 146_LogitBoost_up_center_scale_Spec.rds 
    ##  28 / 88

    ## Finished loading model: 147_LogitBoost_down_center_scale_Spec.rds 
    ##  29 / 88

    ## Finished loading model: 149_LogitBoost_smote_center_scale_Spec.rds 
    ##  30 / 88

    ## Finished loading model: 14_rf_smote_zv_nzv_center_scale_Kappa.rds 
    ##  31 / 88

    ## Finished loading model: 16_rf_up_zv_nzv_center_scale_Sens.rds 
    ##  32 / 88

    ## Finished loading model: 17_rf_down_zv_nzv_center_scale_Sens.rds 
    ##  33 / 88

    ## Finished loading model: 19_rf_smote_zv_nzv_center_scale_Sens.rds 
    ##  34 / 88

    ## Finished loading model: 1_rf_up_zv_nzv_center_scale_ROC.rds 
    ##  35 / 88

    ## Finished loading model: 21_rf_up_zv_nzv_center_scale_Spec.rds 
    ##  36 / 88

    ## Finished loading model: 22_rf_down_zv_nzv_center_scale_Spec.rds 
    ##  37 / 88

    ## Finished loading model: 24_rf_smote_zv_nzv_center_scale_Spec.rds 
    ##  38 / 88

    ## Finished loading model: 26_rf_up_center_scale_ROC.rds 
    ##  39 / 88

    ## Finished loading model: 27_rf_down_center_scale_ROC.rds 
    ##  40 / 88

    ## Finished loading model: 29_rf_smote_center_scale_ROC.rds 
    ##  41 / 88

    ## Finished loading model: 2_rf_down_zv_nzv_center_scale_ROC.rds 
    ##  42 / 88

    ## Finished loading model: 31_rf_up_center_scale_Accuracy.rds 
    ##  43 / 88

    ## Finished loading model: 32_rf_down_center_scale_Accuracy.rds 
    ##  44 / 88

    ## Finished loading model: 34_rf_smote_center_scale_Accuracy.rds 
    ##  45 / 88

    ## Finished loading model: 36_rf_up_center_scale_Kappa.rds 
    ##  46 / 88

    ## Finished loading model: 37_rf_down_center_scale_Kappa.rds 
    ##  47 / 88

    ## Finished loading model: 39_rf_smote_center_scale_Kappa.rds 
    ##  48 / 88

    ## Finished loading model: 41_rf_up_center_scale_Sens.rds 
    ##  49 / 88

    ## Finished loading model: 42_rf_down_center_scale_Sens.rds 
    ##  50 / 88

    ## Finished loading model: 44_rf_smote_center_scale_Sens.rds 
    ##  51 / 88

    ## Finished loading model: 46_rf_up_center_scale_Spec.rds 
    ##  52 / 88

    ## Finished loading model: 47_rf_down_center_scale_Spec.rds 
    ##  53 / 88

    ## Finished loading model: 49_rf_smote_center_scale_Spec.rds 
    ##  54 / 88

    ## Finished loading model: 4_rf_smote_zv_nzv_center_scale_ROC.rds 
    ##  55 / 88

    ## Finished loading model: 51_xgbTree_up_zv_nzv_center_scale_ROC.rds 
    ##  56 / 88

    ## Finished loading model: 52_xgbTree_down_zv_nzv_center_scale_ROC.rds 
    ##  57 / 88

    ## Finished loading model: 54_xgbTree_smote_zv_nzv_center_scale_ROC.rds 
    ##  58 / 88

    ## Finished loading model: 56_xgbTree_up_zv_nzv_center_scale_Accuracy.rds 
    ##  59 / 88

    ## Finished loading model: 57_xgbTree_down_zv_nzv_center_scale_Accuracy.rds 
    ##  60 / 88

    ## Finished loading model: 59_xgbTree_smote_zv_nzv_center_scale_Accuracy.rds 
    ##  61 / 88

    ## Finished loading model: 61_xgbTree_up_zv_nzv_center_scale_Kappa.rds 
    ##  62 / 88

    ## Finished loading model: 62_xgbTree_down_zv_nzv_center_scale_Kappa.rds 
    ##  63 / 88

    ## Finished loading model: 64_xgbTree_smote_zv_nzv_center_scale_Kappa.rds 
    ##  64 / 88

    ## Finished loading model: 66_xgbTree_up_zv_nzv_center_scale_Sens.rds 
    ##  65 / 88

    ## Finished loading model: 67_xgbTree_down_zv_nzv_center_scale_Sens.rds 
    ##  66 / 88

    ## Finished loading model: 69_xgbTree_smote_zv_nzv_center_scale_Sens.rds 
    ##  67 / 88

    ## Finished loading model: 6_rf_up_zv_nzv_center_scale_Accuracy.rds 
    ##  68 / 88

    ## Finished loading model: 71_xgbTree_up_zv_nzv_center_scale_Spec.rds 
    ##  69 / 88

    ## Finished loading model: 72_xgbTree_down_zv_nzv_center_scale_Spec.rds 
    ##  70 / 88

    ## Finished loading model: 74_xgbTree_smote_zv_nzv_center_scale_Spec.rds 
    ##  71 / 88

    ## Finished loading model: 76_xgbTree_up_center_scale_ROC.rds 
    ##  72 / 88

    ## Finished loading model: 77_xgbTree_down_center_scale_ROC.rds 
    ##  73 / 88

    ## Finished loading model: 79_xgbTree_smote_center_scale_ROC.rds 
    ##  74 / 88

    ## Finished loading model: 7_rf_down_zv_nzv_center_scale_Accuracy.rds 
    ##  75 / 88

    ## Finished loading model: 81_xgbTree_up_center_scale_Accuracy.rds 
    ##  76 / 88

    ## Finished loading model: 82_xgbTree_down_center_scale_Accuracy.rds 
    ##  77 / 88

    ## Finished loading model: 84_xgbTree_smote_center_scale_Accuracy.rds 
    ##  78 / 88

    ## Finished loading model: 86_xgbTree_up_center_scale_Kappa.rds 
    ##  79 / 88

    ## Finished loading model: 87_xgbTree_down_center_scale_Kappa.rds 
    ##  80 / 88

    ## Finished loading model: 89_xgbTree_smote_center_scale_Kappa.rds 
    ##  81 / 88

    ## Finished loading model: 91_xgbTree_up_center_scale_Sens.rds 
    ##  82 / 88

    ## Finished loading model: 92_xgbTree_down_center_scale_Sens.rds 
    ##  83 / 88

    ## Finished loading model: 94_xgbTree_smote_center_scale_Sens.rds 
    ##  84 / 88

    ## Finished loading model: 96_xgbTree_up_center_scale_Spec.rds 
    ##  85 / 88

    ## Finished loading model: 97_xgbTree_down_center_scale_Spec.rds 
    ##  86 / 88

    ## Finished loading model: 99_xgbTree_smote_center_scale_Spec.rds 
    ##  87 / 88

    ## Finished loading model: 9_rf_smote_zv_nzv_center_scale_Accuracy.rds 
    ##  88 / 88

Before we proceed to select the models, we should first visualize the model performance.

``` r
ml_bwplot(iris_list)
```

    ## Loading required package: lattice

    ## Loading required package: ggplot2

    ## Warning in resamples.default(.): Some performance measures were
    ## not computed for each model: AUC, logLoss, Mean_Balanced_Accuracy,
    ## Mean_Detection_Rate, Mean_F1, Mean_Neg_Pred_Value, Mean_Pos_Pred_Value,
    ## Mean_Precision, Mean_Recall, Mean_Sensitivity, Mean_Specificity, prAUC

![](README_with_results_files/figure-markdown_github/unnamed-chunk-5-1.png)

    ## [[1]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    3     0.3352184  0.9643333  0.2860532  0.9447619  0.9164196  0.9403920
    ##   10     0.2684269  0.9746667  0.4842227  0.9457143  0.9182946  0.9431698
    ##   14     0.2652790  0.9753333  0.5611447  0.9333333  0.9000000  0.9313973
    ##   22     0.3086473  0.9786667  0.6555666  0.9457143  0.9182946  0.9435907
    ##   34     0.5303002  0.9706667  0.6589441  0.9400000  0.9100000  0.9385522
    ##   42     0.7066009  0.9650000  0.6608264  0.9390476  0.9082946  0.9364358
    ##   45     0.6993804  0.9746667  0.6800804  0.9461905  0.9191473  0.9446489
    ##   74     1.0635595  0.9710000  0.6880024  0.9395238  0.9091473  0.9374940
    ##   78     1.1109784  0.9710000  0.6946691  0.9400000  0.9100000  0.9385522
    ##   84     1.1116338  0.9723333  0.7035620  0.9400000  0.9100000  0.9385522
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9718519         0.9587302          
    ##   0.9433333         0.9725926         0.9587302          
    ##   0.9333333         0.9666667         0.9492063          
    ##   0.9433333         0.9725926         0.9571429          
    ##   0.9400000         0.9700000         0.9531746          
    ##   0.9366667         0.9692593         0.9531746          
    ##   0.9450000         0.9729630         0.9571429          
    ##   0.9383333         0.9696296         0.9531746          
    ##   0.9400000         0.9700000         0.9531746          
    ##   0.9400000         0.9700000         0.9531746          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9767677            0.9587302       0.9400000    0.3149206          
    ##   0.9767677            0.9587302       0.9433333    0.3152381          
    ##   0.9712121            0.9492063       0.9333333    0.3111111          
    ##   0.9762626            0.9571429       0.9433333    0.3152381          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.9737374            0.9531746       0.9366667    0.3130159          
    ##   0.9762626            0.9571429       0.9450000    0.3153968          
    ##   0.9737374            0.9531746       0.9383333    0.3131746          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.9559259             
    ##   0.9579630             
    ##   0.9500000             
    ##   0.9579630             
    ##   0.9550000             
    ##   0.9529630             
    ##   0.9589815             
    ##   0.9539815             
    ##   0.9550000             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 14.
    ## 
    ## [[2]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    2     0.3946975  0.9740000  0.2337500  0.9548718  0.9298148  0.9447811
    ##    8     0.2113433  0.9846667  0.4177937  0.9328571  0.8993130  0.9321212
    ##    9     0.1765634  0.9860000  0.4597116  0.9457143  0.9186260  0.9447811
    ##   12     0.2147832  0.9840000  0.4859550  0.9466667  0.9200000  0.9462626
    ##   17     0.2419652  0.9720000  0.5315124  0.9514286  0.9270875  0.9499832
    ##   36     0.4408927  0.9706667  0.6043034  0.9466667  0.9200000  0.9463973
    ##   52     0.6942436  0.9656667  0.6596402  0.9333333  0.9000000  0.9327946
    ##   54     0.7073603  0.9630000  0.6557228  0.9333333  0.9000000  0.9327946
    ##   64     0.8324383  0.9673333  0.6546778  0.9333333  0.9000000  0.9327946
    ##   90     1.0773647  0.9703333  0.6553510  0.9333333  0.9000000  0.9327946
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9422222         0.9766667         0.9555556          
    ##   0.9333333         0.9666667         0.9383333          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9516667         0.9762963         0.9550000          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9333333         0.9666667         0.9394444          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9800866            0.9555556       0.9422222    0.3182906          
    ##   0.9681145            0.9383333       0.9333333    0.3109524          
    ##   0.9744781            0.9505556       0.9466667    0.3152381          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9772054            0.9550000       0.9516667    0.3171429          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   Mean_Balanced_Accuracy
    ##   0.9594444             
    ##   0.9500000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9639815             
    ##   0.9600000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 9.
    ## 
    ## [[3]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##     6    0.9533333  0.9300000
    ##    20    0.9333333  0.9000000
    ##    21    0.9333333  0.9000000
    ##    30    0.9333333  0.9000000
    ##    33    0.9266667  0.8900000
    ##    44    0.9333333  0.9000000
    ##    52    0.9333333  0.9000000
    ##    57    0.9328571  0.8993130
    ##    77    0.9328571  0.8991473
    ##   100    0.9385714  0.9077745
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## [[4]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    3     0.9384982  0.9072759
    ##   10     0.9466667  0.9200000
    ##   19     0.9466667  0.9200000
    ##   25     0.9466667  0.9200000
    ##   57     0.9466667  0.9200000
    ##   58     0.9466667  0.9200000
    ##   75     0.9400000  0.9100000
    ##   87     0.9400000  0.9100000
    ##   90     0.9400000  0.9100000
    ##   91     0.9400000  0.9100000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 10.
    ## 
    ## [[5]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##     6    0.9452381  0.9177745
    ##     7    0.9390476  0.9084615
    ##    17    0.9533333  0.9300000
    ##    20    0.9466667  0.9200000
    ##    40    0.9452381  0.9177745
    ##    50    0.9442857  0.9162348
    ##    51    0.9390476  0.9084603
    ##    53    0.9452381  0.9177745
    ##    61    0.9452381  0.9177745
    ##   100    0.9333333  0.9000000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 17.
    ## 
    ## [[6]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa   
    ##   12     0.9600000  0.940000
    ##   19     0.9523077  0.927963
    ##   26     0.9457143  0.918125
    ##   32     0.9333333  0.900000
    ##   49     0.9333333  0.900000
    ##   73     0.9333333  0.900000
    ##   81     0.9266667  0.890000
    ##   82     0.9266667  0.890000
    ##   89     0.9333333  0.900000
    ##   96     0.9323810  0.898125
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 12.
    ## 
    ## [[7]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    2     0.9419963  0.9108651
    ##   18     0.9533333  0.9300000
    ##   30     0.9533333  0.9300000
    ##   35     0.9533333  0.9300000
    ##   40     0.9533333  0.9300000
    ##   45     0.9533333  0.9300000
    ##   47     0.9533333  0.9300000
    ##   48     0.9533333  0.9300000
    ##   58     0.9533333  0.9300000
    ##   61     0.9528571  0.9291473
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 18.
    ## 
    ## [[8]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   19     0.2182044  0.9820000  0.6232969  0.9461905  0.9193130  0.9455892
    ##   26     0.2875129  0.9800000  0.6775926  0.9457143  0.9184615  0.9448653
    ##   29     0.3337741  0.9793333  0.6973307  0.9400000  0.9100000  0.9396633
    ##   39     0.4125892  0.9773333  0.7053704  0.9333333  0.9000000  0.9330640
    ##   44     0.5233674  0.9733333  0.7012902  0.9266667  0.8900000  0.9263300
    ##   56     0.6292771  0.9706667  0.7272963  0.9266667  0.8900000  0.9263300
    ##   67     0.7381259  0.9716667  0.7122963  0.9200000  0.8800000  0.9195960
    ##   73     0.7421799  0.9723333  0.7040362  0.9266667  0.8900000  0.9263300
    ##   97     0.9649257  0.9723333  0.6100362  0.9266667  0.8900000  0.9263300
    ##   98     1.0235940  0.9703333  0.6692479  0.9266667  0.8900000  0.9263300
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9494444          
    ##   0.9450000         0.9729630         0.9472222          
    ##   0.9400000         0.9700000         0.9427778          
    ##   0.9333333         0.9666667         0.9350000          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9200000         0.9600000         0.9238889          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9266667         0.9633333         0.9294444          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9741751            0.9494444       0.9466667    0.3153968          
    ##   0.9735690            0.9472222       0.9450000    0.3152381          
    ##   0.9708418            0.9427778       0.9400000    0.3133333          
    ##   0.9672054            0.9350000       0.9333333    0.3111111          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9611448            0.9238889       0.9200000    0.3066667          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   Mean_Balanced_Accuracy
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9500000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9400000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9450000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 19.
    ## 
    ## [[9]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    7     0.2353778  0.9856667  0.3653439  0.9461905  0.9191473  0.9452044
    ##   21     0.2478021  0.9846667  0.6225852  0.9400000  0.9100000  0.9391077
    ##   24     0.3022456  0.9820000  0.6384450  0.9466667  0.9200000  0.9458418
    ##   27     0.3310015  0.9820000  0.6473828  0.9400000  0.9100000  0.9391077
    ##   30     0.3879973  0.9726667  0.6683508  0.9466667  0.9200000  0.9458418
    ##   35     0.4995667  0.9760000  0.6712019  0.9466667  0.9200000  0.9458418
    ##   63     0.8120911  0.9726667  0.6355481  0.9333333  0.9000000  0.9310186
    ##   75     1.0228167  0.9713333  0.6251754  0.9333333  0.9000000  0.9310186
    ##   88     1.1516888  0.9726667  0.5944016  0.9333333  0.9000000  0.9310186
    ##   98     1.2745900  0.9713333  0.5914677  0.9333333  0.9000000  0.9310186
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9450000         0.9729630         0.9533333          
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9333333         0.9666667         0.9463889          
    ##   0.9333333         0.9666667         0.9463889          
    ##   0.9333333         0.9666667         0.9463889          
    ##   0.9333333         0.9666667         0.9463889          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9450000    0.3153968          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   Mean_Balanced_Accuracy
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9600000             
    ##   0.9550000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 7.
    ## 
    ## [[10]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    7     0.1774257  0.9886667  0.3935952  0.9595238  0.9391473  0.9567618
    ##   13     0.2293104  0.9906667  0.5433016  0.9528571  0.9291473  0.9500278
    ##   16     0.2831730  0.9873333  0.5679661  0.9533333  0.9300000  0.9510860
    ##   51     0.7244054  0.9800000  0.6750275  0.9400000  0.9100000  0.9367762
    ##   54     0.7653373  0.9806667  0.6893011  0.9400000  0.9100000  0.9367762
    ##   70     0.9084932  0.9886667  0.7020728  0.9400000  0.9100000  0.9367762
    ##   72     0.9429589  0.9820000  0.6780969  0.9400000  0.9100000  0.9367762
    ##   76     0.9555947  0.9776667  0.6528263  0.9400000  0.9100000  0.9367762
    ##   90     1.0534377  0.9756667  0.6633801  0.9400000  0.9100000  0.9367762
    ##   94     1.0738390  0.9743333  0.6603588  0.9461905  0.9191473  0.9428729
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9583333         0.9796296         0.9708333          
    ##   0.9516667         0.9762963         0.9652778          
    ##   0.9533333         0.9766667         0.9652778          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9450000         0.9729630         0.9613095          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9832168            0.9708333       0.9583333    0.3198413          
    ##   0.9801865            0.9652778       0.9516667    0.3176190          
    ##   0.9801865            0.9652778       0.9533333    0.3177778          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9776612            0.9613095       0.9450000    0.3153968          
    ##   Mean_Balanced_Accuracy
    ##   0.9689815             
    ##   0.9639815             
    ##   0.9650000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9589815             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 7.
    ## 
    ## [[11]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9400000  0.91 
    ##    2    0.9466667  0.92 
    ##    3    0.9333333  0.90 
    ##    4    0.9400000  0.91 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[12]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    5     0.2689410  0.9773333  0.3486349  0.9461905  0.9191473  0.9443627
    ##   20     0.3321563  0.9700000  0.5955455  0.9447619  0.9165891  0.9420298
    ##   22     0.3696460  0.9686667  0.6022360  0.9452381  0.9174419  0.9430880
    ##   50     0.7416837  0.9673333  0.7097756  0.9400000  0.9100000  0.9395286
    ##   60     0.8538661  0.9686667  0.7166194  0.9385714  0.9074419  0.9363540
    ##   65     0.8694841  0.9720000  0.7323920  0.9400000  0.9100000  0.9395286
    ##   80     1.0278368  0.9750000  0.6893108  0.9385714  0.9074419  0.9363540
    ##   91     1.1412967  0.9760000  0.6254405  0.9385714  0.9074419  0.9363540
    ##   92     1.0986420  0.9763333  0.6710886  0.9400000  0.9100000  0.9395286
    ##   94     1.1611194  0.9750000  0.6761442  0.9385714  0.9074419  0.9363540
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9450000         0.9729630         0.9501587          
    ##   0.9416667         0.9722222         0.9477778          
    ##   0.9433333         0.9725926         0.9477778          
    ##   0.9400000         0.9700000         0.9450000          
    ##   0.9366667         0.9692593         0.9422222          
    ##   0.9400000         0.9700000         0.9450000          
    ##   0.9366667         0.9692593         0.9422222          
    ##   0.9366667         0.9692593         0.9422222          
    ##   0.9400000         0.9700000         0.9450000          
    ##   0.9366667         0.9692593         0.9422222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9747727            0.9501587       0.9450000    0.3153968          
    ##   0.9740152            0.9477778       0.9416667    0.3149206          
    ##   0.9740152            0.9477778       0.9433333    0.3150794          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   Mean_Balanced_Accuracy
    ##   0.9589815             
    ##   0.9569444             
    ##   0.9579630             
    ##   0.9550000             
    ##   0.9529630             
    ##   0.9550000             
    ##   0.9529630             
    ##   0.9529630             
    ##   0.9550000             
    ##   0.9529630             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 5.
    ## 
    ## [[13]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    9     0.1960401  0.9900000  0.4728690  0.9390476  0.9081250  0.9361953
    ##   19     0.2862639  0.9740000  0.6409881  0.9466667  0.9200000  0.9457071
    ##   37     0.4559892  0.9693333  0.6949567  0.9461905  0.9191473  0.9446489
    ##   42     0.4873048  0.9693333  0.7157900  0.9466667  0.9200000  0.9457071
    ##   51     0.6226899  0.9666667  0.7186074  0.9466667  0.9200000  0.9457071
    ##   55     0.6772778  0.9670000  0.7112759  0.9466667  0.9200000  0.9457071
    ##   56     0.6616503  0.9696667  0.7217658  0.9466667  0.9200000  0.9457071
    ##   59     0.7135012  0.9666667  0.6955393  0.9466667  0.9200000  0.9457071
    ##   76     0.9209786  0.9650000  0.6994643  0.9461905  0.9191473  0.9446489
    ##   93     1.0768694  0.9710000  0.5662133  0.9400000  0.9100000  0.9385522
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9366667         0.9692593         0.9488095          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9450000         0.9729630         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9450000         0.9729630         0.9543651          
    ##   0.9400000         0.9700000         0.9503968          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9725589            0.9488095       0.9366667    0.3130159          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9450000    0.3153968          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9450000    0.3153968          
    ##   0.9730640            0.9503968       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.9529630             
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 9.
    ## 
    ## [[14]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   10     0.1520599  0.9926667  0.5189074  0.9523810  0.9284603  0.9512650
    ##   17     0.1565226  0.9893333  0.6210622  0.9528571  0.9293130  0.9523232
    ##   26     0.2802461  0.9780000  0.6349497  0.9533333  0.9300000  0.9529966
    ##   35     0.2906773  0.9806667  0.6576513  0.9528571  0.9293130  0.9523232
    ##   52     0.4635829  0.9740000  0.6707561  0.9466667  0.9200000  0.9463973
    ##   54     0.4932399  0.9760000  0.6754008  0.9466667  0.9200000  0.9463973
    ##   58     0.4843326  0.9746667  0.6589227  0.9528571  0.9293130  0.9523232
    ##   68     0.5582325  0.9736667  0.6503976  0.9466667  0.9200000  0.9463973
    ##   72     0.6004874  0.9760000  0.6730952  0.9466667  0.9200000  0.9463973
    ##   78     0.6584321  0.9750000  0.6459884  0.9466667  0.9200000  0.9463973
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9516667         0.9762963         0.9577778          
    ##   0.9533333         0.9766667         0.9577778          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9577778          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9533333         0.9766667         0.9577778          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9466667         0.9733333         0.9511111          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9778788            0.9577778       0.9516667    0.3174603          
    ##   0.9778788            0.9577778       0.9533333    0.3176190          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9778788            0.9577778       0.9533333    0.3176190          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9778788            0.9577778       0.9533333    0.3176190          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.9639815             
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9650000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 10.
    ## 
    ## [[15]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa     Mean_F1  
    ##   10     0.2390373  0.9766667  0.5103746  0.9400000  0.910000  0.9385522
    ##   40     0.5151878  0.9736667  0.6986151  0.9400000  0.910000  0.9389731
    ##   46     0.6316926  0.9713333  0.6983558  0.9395238  0.909313  0.9382997
    ##   48     0.6236132  0.9713333  0.6916336  0.9400000  0.910000  0.9389731
    ##   56     0.6984395  0.9720000  0.7030992  0.9466667  0.920000  0.9457071
    ##   58     0.7115657  0.9720000  0.7097659  0.9466667  0.920000  0.9457071
    ##   71     0.9203462  0.9670000  0.6617183  0.9400000  0.910000  0.9389731
    ##   88     1.0849187  0.9656667  0.6569339  0.9466667  0.920000  0.9457071
    ##   90     1.1098588  0.9636667  0.6553122  0.9466667  0.920000  0.9457071
    ##   97     1.1468845  0.9650000  0.5846561  0.9466667  0.920000  0.9457071
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9531746          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9400000         0.9700000         0.9504762          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9466667         0.9733333         0.9571429          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9729293            0.9504762       0.9400000    0.3131746          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.960                 
    ##   0.960                 
    ##   0.955                 
    ##   0.960                 
    ##   0.960                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 10.
    ## 
    ## [[16]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    6     0.2236553  0.9813333  0.4254939  0.9533333  0.9300000  0.9529966
    ##   14     0.2398600  0.9753333  0.5743635  0.9533333  0.9300000  0.9529966
    ##   23     0.3792280  0.9653333  0.6164975  0.9533333  0.9300000  0.9529966
    ##   53     0.8893873  0.9613333  0.6699499  0.9447619  0.9170862  0.9431842
    ##   58     0.9565556  0.9606667  0.6816767  0.9447619  0.9170862  0.9431842
    ##   65     1.0151079  0.9616667  0.6833831  0.9466667  0.9200000  0.9462626
    ##   74     1.1668342  0.9603333  0.6990797  0.9461905  0.9191473  0.9452044
    ##   78     1.1917924  0.9580000  0.6966486  0.9461905  0.9191473  0.9452044
    ##   85     1.2688470  0.9583333  0.6282042  0.9400000  0.9100000  0.9391077
    ##   93     1.3587910  0.9596667  0.6232481  0.9461905  0.9191473  0.9452044
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9561111          
    ##   0.9533333         0.9766667         0.9561111          
    ##   0.9533333         0.9766667         0.9561111          
    ##   0.9433333         0.9725926         0.9483333          
    ##   0.9433333         0.9725926         0.9483333          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9450000         0.9729630         0.9505556          
    ##   0.9450000         0.9729630         0.9505556          
    ##   0.9400000         0.9700000         0.9465873          
    ##   0.9450000         0.9729630         0.9505556          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9738721            0.9483333       0.9433333    0.3149206          
    ##   0.9738721            0.9483333       0.9433333    0.3149206          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9450000    0.3153968          
    ##   0.9744781            0.9505556       0.9450000    0.3153968          
    ##   0.9719529            0.9465873       0.9400000    0.3133333          
    ##   0.9744781            0.9505556       0.9450000    0.3153968          
    ##   Mean_Balanced_Accuracy
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9579630             
    ##   0.9579630             
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9589815             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## [[17]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   14     0.1813388  0.9886667  0.6065370  0.9533333  0.9300000  0.9528620
    ##   15     0.1824237  0.9900000  0.6223836  0.9590476  0.9384615  0.9580640
    ##   35     0.3433115  0.9833333  0.6838466  0.9400000  0.9100000  0.9395286
    ##   39     0.3650385  0.9806667  0.6711074  0.9457143  0.9184615  0.9447306
    ##   47     0.4312681  0.9780000  0.6678514  0.9457143  0.9184615  0.9447306
    ##   58     0.5685432  0.9813333  0.6627797  0.9395238  0.9091473  0.9384704
    ##   67     0.6897191  0.9783333  0.5917707  0.9333333  0.9000000  0.9323737
    ##   92     0.8564847  0.9736667  0.6276220  0.9333333  0.9000000  0.9323737
    ##   95     0.8787314  0.9730000  0.5404858  0.9333333  0.9000000  0.9323737
    ##   97     0.9386153  0.9723333  0.5417146  0.9333333  0.9000000  0.9323737
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9555556          
    ##   0.9583333         0.9796296         0.9600000          
    ##   0.9400000         0.9700000         0.9422222          
    ##   0.9450000         0.9729630         0.9466667          
    ##   0.9450000         0.9729630         0.9466667          
    ##   0.9383333         0.9696296         0.9422222          
    ##   0.9333333         0.9666667         0.9382540          
    ##   0.9333333         0.9666667         0.9382540          
    ##   0.9333333         0.9666667         0.9382540          
    ##   0.9333333         0.9666667         0.9382540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9774411            0.9555556       0.9533333    0.3177778          
    ##   0.9801684            0.9600000       0.9583333    0.3196825          
    ##   0.9707744            0.9422222       0.9400000    0.3133333          
    ##   0.9735017            0.9466667       0.9450000    0.3152381          
    ##   0.9735017            0.9466667       0.9450000    0.3152381          
    ##   0.9707744            0.9422222       0.9383333    0.3131746          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   Mean_Balanced_Accuracy
    ##   0.9650000             
    ##   0.9689815             
    ##   0.9550000             
    ##   0.9589815             
    ##   0.9589815             
    ##   0.9539815             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 14.
    ## 
    ## [[18]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9600000  0.94 
    ##    4    0.9600000  0.94 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[19]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    5     0.9512821  0.9263558
    ##    9     0.9447619  0.9169129
    ##   29     0.9466667  0.9200000
    ##   38     0.9533333  0.9300000
    ##   40     0.9533333  0.9300000
    ##   44     0.9533333  0.9300000
    ##   51     0.9533333  0.9300000
    ##   64     0.9528571  0.9293130
    ##   90     0.9533333  0.9300000
    ##   96     0.9528571  0.9291473
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 38.
    ## 
    ## [[20]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    6     0.9439744  0.9155502
    ##   14     0.9425641  0.9133604
    ##   16     0.9502564  0.9253748
    ##   17     0.9389744  0.9081818
    ##   28     0.9256410  0.8881818
    ##   44     0.9195238  0.8791473
    ##   47     0.9195238  0.8791473
    ##   80     0.9195238  0.8791473
    ##   86     0.9261905  0.8891473
    ##   91     0.9266667  0.8900000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 16.
    ## 
    ## [[21]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    5     0.9451648  0.9175401
    ##    6     0.9523077  0.9283929
    ##   19     0.9266667  0.8900000
    ##   23     0.9457143  0.9187879
    ##   27     0.9457143  0.9187879
    ##   30     0.9400000  0.9100000
    ##   40     0.9457143  0.9182946
    ##   45     0.9384982  0.9075401
    ##   58     0.9328571  0.8991473
    ##   95     0.9200000  0.8800000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## [[22]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    3     0.9446886  0.9168531
    ##    7     0.9400000  0.9100000
    ##   11     0.9461905  0.9191473
    ##   29     0.9466667  0.9200000
    ##   31     0.9466667  0.9200000
    ##   69     0.9400000  0.9100000
    ##   82     0.9400000  0.9100000
    ##   84     0.9400000  0.9100000
    ##   94     0.9400000  0.9100000
    ##   97     0.9400000  0.9100000
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 29.
    ## 
    ## [[23]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##     2    0.9435897  0.9149675
    ##    10    0.9400000  0.9100000
    ##    11    0.9400000  0.9100000
    ##    27    0.9528571  0.9293130
    ##    28    0.9461905  0.9193130
    ##    31    0.9461905  0.9193130
    ##    66    0.9333333  0.9000000
    ##    74    0.9400000  0.9100000
    ##    92    0.9461905  0.9193130
    ##   100    0.9333333  0.9000000
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 27.
    ## 
    ## [[24]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##   10     0.9461905  0.9193130
    ##   15     0.9461905  0.9191473
    ##   33     0.9466667  0.9200000
    ##   42     0.9395238  0.9093130
    ##   53     0.9333333  0.9000000
    ##   59     0.9333333  0.9000000
    ##   60     0.9328571  0.8991473
    ##   68     0.9333333  0.9000000
    ##   85     0.9333333  0.9000000
    ##   93     0.9333333  0.9000000
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 33.
    ## 
    ## [[25]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    6     0.2287970  0.9793333  0.4158290  0.9528571  0.9293130  0.9517677
    ##    9     0.1875224  0.9873333  0.4814199  0.9461905  0.9191473  0.9446489
    ##   14     0.2065621  0.9826667  0.5948366  0.9333333  0.9000000  0.9323737
    ##   22     0.2536365  0.9806667  0.6446341  0.9395238  0.9093130  0.9382997
    ##   50     0.5737994  0.9766667  0.6743968  0.9333333  0.9000000  0.9323737
    ##   51     0.6382952  0.9730000  0.6646524  0.9333333  0.9000000  0.9323737
    ##   65     0.7420538  0.9730000  0.6706720  0.9333333  0.9000000  0.9323737
    ##   75     0.8318287  0.9690000  0.6079934  0.9328571  0.8991473  0.9313155
    ##   87     0.8894616  0.9726667  0.5634008  0.9400000  0.9100000  0.9391077
    ##   99     0.8887503  0.9720000  0.5155574  0.9400000  0.9100000  0.9391077
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9615873          
    ##   0.9450000         0.9729630         0.9571429          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9400000         0.9700000         0.9504762          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9316667         0.9662963         0.9438095          
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9400000         0.9700000         0.9493651          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9789899            0.9615873       0.9533333    0.3176190          
    ##   0.9762626            0.9571429       0.9450000    0.3153968          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9729293            0.9504762       0.9400000    0.3131746          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9695960            0.9438095       0.9316667    0.3109524          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.9650000             
    ##   0.9589815             
    ##   0.9500000             
    ##   0.9550000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9489815             
    ##   0.9550000             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 9.
    ## 
    ## [[26]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    6     0.2272908  0.9820000  0.4290212  0.9523077  0.9281818  0.9528620
    ##   30     0.3631492  0.9740000  0.7098645  0.9261905  0.8893130  0.9259981
    ##   51     0.6673798  0.9706667  0.7197658  0.9195238  0.8793130  0.9192641
    ##   57     0.7988438  0.9673333  0.7102204  0.9133333  0.8700000  0.9133381
    ##   59     0.7988933  0.9693333  0.7040090  0.9133333  0.8700000  0.9133381
    ##   63     0.8879738  0.9660000  0.6796584  0.9133333  0.8700000  0.9133381
    ##   66     0.9312421  0.9690000  0.7102655  0.9133333  0.8700000  0.9133381
    ##   90     1.2914023  0.9590000  0.6824066  0.9266667  0.8900000  0.9256397
    ##   91     1.2672117  0.9596667  0.6582796  0.9266667  0.8900000  0.9256397
    ##   99     1.4473887  0.9603333  0.6266129  0.9266667  0.8900000  0.9256397
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9758333         0.9611111          
    ##   0.9266667         0.9633333         0.9451852          
    ##   0.9200000         0.9600000         0.9396296          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9266667         0.9633333         0.9382540          
    ##   0.9266667         0.9633333         0.9382540          
    ##   0.9266667         0.9633333         0.9382540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781145            0.9611111       0.9533333    0.3174359          
    ##   0.9673737            0.9451852       0.9266667    0.3087302          
    ##   0.9643434            0.9396296       0.9200000    0.3065079          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9665657            0.9382540       0.9266667    0.3088889          
    ##   0.9665657            0.9382540       0.9266667    0.3088889          
    ##   0.9665657            0.9382540       0.9266667    0.3088889          
    ##   Mean_Balanced_Accuracy
    ##   0.9645833             
    ##   0.9450000             
    ##   0.9400000             
    ##   0.9350000             
    ##   0.9350000             
    ##   0.9350000             
    ##   0.9350000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9450000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## [[27]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa     Mean_F1  
    ##   13     0.2043910  0.9800000  0.5162116  0.9533333  0.930000  0.9529966
    ##   14     0.2075586  0.9813333  0.5307222  0.9533333  0.930000  0.9529966
    ##   22     0.2926234  0.9860000  0.6249471  0.9461905  0.919313  0.9455892
    ##   26     0.3221863  0.9820000  0.6576365  0.9533333  0.930000  0.9529966
    ##   28     0.4027806  0.9786667  0.6459357  0.9400000  0.910000  0.9396633
    ##   30     0.4313569  0.9753333  0.6440971  0.9400000  0.910000  0.9396633
    ##   55     0.6932177  0.9673333  0.6865605  0.9400000  0.910000  0.9396633
    ##   57     0.7675104  0.9626667  0.6865759  0.9400000  0.910000  0.9396633
    ##   89     0.9842565  0.9690000  0.6133566  0.9466667  0.920000  0.9462626
    ##   94     1.0575754  0.9700000  0.6328011  0.9466667  0.920000  0.9462626
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9466667         0.9733333         0.9522222          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9466667         0.9733333         0.9533333          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9748485            0.9522222       0.9466667    0.3153968          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.960                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 13.
    ## 
    ## [[28]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   20     0.3279714  0.9786667  0.6166331  0.9528571  0.9291473  0.9513829
    ##   21     0.3112965  0.9813333  0.6175241  0.9528571  0.9291473  0.9513829
    ##   30     0.4423963  0.9746667  0.6730891  0.9533333  0.9300000  0.9524411
    ##   36     0.5130059  0.9746667  0.7063704  0.9461905  0.9193130  0.9450337
    ##   43     0.5941090  0.9733333  0.7118675  0.9333333  0.9000000  0.9323737
    ##   60     0.8463338  0.9676667  0.7131492  0.9395238  0.9093130  0.9384343
    ##   71     0.9685520  0.9656667  0.6807823  0.9266667  0.8900000  0.9257744
    ##   94     1.1963412  0.9673333  0.7078783  0.9266667  0.8900000  0.9257744
    ##   95     1.1823810  0.9666667  0.6224815  0.9266667  0.8900000  0.9257744
    ##   99     1.2639822  0.9666667  0.6358148  0.9395238  0.9093130  0.9384343
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9516667         0.9762963         0.9626984          
    ##   0.9516667         0.9762963         0.9626984          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9466667         0.9733333         0.9560317          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9400000         0.9700000         0.9482540          
    ##   0.9266667         0.9633333         0.9360317          
    ##   0.9266667         0.9633333         0.9360317          
    ##   0.9266667         0.9633333         0.9360317          
    ##   0.9400000         0.9700000         0.9482540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9792929            0.9626984       0.9516667    0.3176190          
    ##   0.9792929            0.9626984       0.9516667    0.3176190          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9759596            0.9560317       0.9466667    0.3153968          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9723232            0.9482540       0.9400000    0.3131746          
    ##   0.9659596            0.9360317       0.9266667    0.3088889          
    ##   0.9659596            0.9360317       0.9266667    0.3088889          
    ##   0.9659596            0.9360317       0.9266667    0.3088889          
    ##   0.9723232            0.9482540       0.9400000    0.3131746          
    ##   Mean_Balanced_Accuracy
    ##   0.9639815             
    ##   0.9639815             
    ##   0.9650000             
    ##   0.9600000             
    ##   0.9500000             
    ##   0.9550000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 21.
    ## 
    ## [[29]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    5     0.2702916  0.9713333  0.3615129  0.9528571  0.9291473  0.9509620
    ##   21     0.3752966  0.9753333  0.6008470  0.9400000  0.9100000  0.9381313
    ##   33     0.4786156  0.9693333  0.6531764  0.9461905  0.9191473  0.9442280
    ##   39     0.6055244  0.9686667  0.6553386  0.9400000  0.9100000  0.9381313
    ##   42     0.6132065  0.9686667  0.6552275  0.9400000  0.9100000  0.9381313
    ##   49     0.7282757  0.9680000  0.6666720  0.9400000  0.9100000  0.9381313
    ##   53     0.7936043  0.9670000  0.6615860  0.9400000  0.9100000  0.9381313
    ##   81     1.0907266  0.9656667  0.5564127  0.9400000  0.9100000  0.9381313
    ##   95     1.2189188  0.9643333  0.5282341  0.9466667  0.9200000  0.9452862
    ##   99     1.2135210  0.9630000  0.5249497  0.9466667  0.9200000  0.9452862
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9516667         0.9762963         0.9642857          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9450000         0.9729630         0.9587302          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9466667         0.9733333         0.9587302          
    ##   0.9466667         0.9733333         0.9587302          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9797980            0.9642857       0.9516667    0.3176190          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9767677            0.9587302       0.9450000    0.3153968          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.9639815             
    ##   0.9550000             
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9600000             
    ##   0.9600000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 5.
    ## 
    ## [[30]]
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    1     0.6116584  0.9380000  0.2242209  0.9397863  0.9036713  0.9320400
    ##   25     0.4532285  0.9693333  0.5912082  0.9319048  0.8977745  0.9300337
    ##   28     0.4856553  0.9720000  0.5898867  0.9261905  0.8893130  0.9248316
    ##   67     1.0170263  0.9756667  0.5871507  0.9200000  0.8800000  0.9189057
    ##   85     1.2140226  0.9730000  0.5184423  0.9195238  0.8791473  0.9178475
    ##   86     1.2077461  0.9706667  0.5828127  0.9133333  0.8700000  0.9117508
    ##   90     1.2188038  0.9753333  0.6032857  0.9195238  0.8791473  0.9178475
    ##   94     1.2231541  0.9753333  0.6035534  0.9200000  0.8800000  0.9189057
    ##   98     1.2456689  0.9753333  0.5835534  0.9195238  0.8791473  0.9178475
    ##   99     1.2694722  0.9756667  0.4661746  0.9133333  0.8700000  0.9117508
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9155556         0.9710185         0.9358025          
    ##   0.9316667         0.9662963         0.9410317          
    ##   0.9266667         0.9633333         0.9365873          
    ##   0.9200000         0.9600000         0.9299206          
    ##   0.9183333         0.9596296         0.9299206          
    ##   0.9133333         0.9566667         0.9259524          
    ##   0.9183333         0.9596296         0.9299206          
    ##   0.9200000         0.9600000         0.9299206          
    ##   0.9183333         0.9596296         0.9299206          
    ##   0.9133333         0.9566667         0.9259524          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9736640            0.9358025       0.9155556    0.3132621          
    ##   0.9689226            0.9410317       0.9316667    0.3106349          
    ##   0.9661953            0.9365873       0.9266667    0.3087302          
    ##   0.9628620            0.9299206       0.9200000    0.3066667          
    ##   0.9628620            0.9299206       0.9183333    0.3065079          
    ##   0.9603367            0.9259524       0.9133333    0.3044444          
    ##   0.9628620            0.9299206       0.9183333    0.3065079          
    ##   0.9628620            0.9299206       0.9200000    0.3066667          
    ##   0.9628620            0.9299206       0.9183333    0.3065079          
    ##   0.9603367            0.9259524       0.9133333    0.3044444          
    ##   Mean_Balanced_Accuracy
    ##   0.9432870             
    ##   0.9489815             
    ##   0.9450000             
    ##   0.9400000             
    ##   0.9389815             
    ##   0.9350000             
    ##   0.9389815             
    ##   0.9400000             
    ##   0.9389815             
    ##   0.9350000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 25.
    ## 
    ## [[31]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9533333  0.93 
    ##    2    0.9400000  0.91 
    ##    3    0.9466667  0.92 
    ##    4    0.9333333  0.90 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.
    ## 
    ## [[32]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1325623  0.9940000  0.7228175  0.9466667  0.92   0.9458418
    ##    2    0.1196242  0.9946667  0.4303254  0.9466667  0.92   0.9458418
    ##    3    0.1275468  0.9926667  0.3135198  0.9533333  0.93   0.9525758
    ##    4    0.1282826  0.9946667  0.2503254  0.9533333  0.93   0.9525758
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9533333         0.9766667         0.9604762          
    ##   0.9533333         0.9766667         0.9604762          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[33]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1259582  0.9960000  0.6927698  0.9466667  0.92   0.9457071
    ##    2    0.1183532  0.9966667  0.4942698  0.9600000  0.94   0.9591751
    ##    3    0.1181455  0.9973333  0.3151111  0.9533333  0.93   0.9524411
    ##    4    0.1157227  0.9986667  0.2908889  0.9533333  0.93   0.9524411
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9600000         0.9800000         0.9682540          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9533333         0.9766667         0.9626984          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 4.
    ## 
    ## [[34]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy  Kappa  Mean_F1  
    ##    1    0.1218002  0.9940000  0.6297619  0.96      0.94   0.9591751
    ##    2    0.1102341  0.9960000  0.4062063  0.94      0.91   0.9393939
    ##    3    0.3480561  0.9896667  0.2287619  0.96      0.94   0.9591751
    ##    4    0.3771713  0.9896667  0.1887619  0.94      0.91   0.9393939
    ##   NA          NaN  0.5000000        NaN   NaN       NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.96              0.98              0.9682540          
    ##   0.94              0.97              0.9472222          
    ##   0.96              0.98              0.9682540          
    ##   0.94              0.97              0.9472222          
    ##    NaN               NaN                    NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9823232            0.9682540       0.96         0.3200000          
    ##   0.9720539            0.9472222       0.94         0.3133333          
    ##   0.9823232            0.9682540       0.96         0.3200000          
    ##   0.9720539            0.9472222       0.94         0.3133333          
    ##         NaN                  NaN        NaN               NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.970                 
    ##   0.955                 
    ##   0.970                 
    ##   0.955                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[35]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1340707  0.9960000  0.6926667  0.9400000  0.91   0.9391077
    ##    2    0.1129814  0.9973333  0.5017778  0.9600000  0.94   0.9597306
    ##    3    0.1146355  0.9960000  0.2993333  0.9533333  0.93   0.9529966
    ##    4    0.1152305  0.9960000  0.2926667  0.9533333  0.93   0.9529966
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9588889          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[36]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1293391  0.9953333  0.7181587  0.9400000  0.91   0.9381313
    ##    2    0.1084996  0.9960000  0.5261032  0.9533333  0.93   0.9524411
    ##    3    0.1092443  0.9960000  0.2861032  0.9600000  0.94   0.9595960
    ##    4    0.1081212  0.9953333  0.3050397  0.9600000  0.94   0.9595960
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9600000         0.9800000         0.9666667          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.965                 
    ##   0.970                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 4.
    ## 
    ## [[37]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC    prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1282627  0.994  0.7361508  0.9466667  0.92   0.9457071
    ##    2    0.1038169  0.996  0.4727698  0.9600000  0.94   0.9587542
    ##    3    0.1056095  0.996  0.3194365  0.9600000  0.94   0.9587542
    ##    4    0.1129823  0.996  0.2727698  0.9600000  0.94   0.9587542
    ##   NA          NaN  0.500        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9600000         0.9800000         0.9698413          
    ##   0.9600000         0.9800000         0.9698413          
    ##   0.9600000         0.9800000         0.9698413          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9828283            0.9698413       0.9600000    0.3200000          
    ##   0.9828283            0.9698413       0.9600000    0.3200000          
    ##   0.9828283            0.9698413       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.96                  
    ##   0.97                  
    ##   0.97                  
    ##   0.97                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[38]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1397263  0.9906667  0.6229802  0.9466667  0.92   0.9459764
    ##    2    0.1159716  0.9960000  0.4194365  0.9533333  0.93   0.9527104
    ##    3    0.1354053  0.9966667  0.1940476  0.9533333  0.93   0.9527104
    ##    4    0.3411941  0.9916667  0.1718254  0.9600000  0.94   0.9593098
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9526984          
    ##   0.9533333         0.9766667         0.9582540          
    ##   0.9533333         0.9766667         0.9582540          
    ##   0.9600000         0.9800000         0.9660317          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9750505            0.9526984       0.9466667    0.3155556          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[39]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1268246  0.9973333  0.7152143  0.9466667  0.92   0.9462626
    ##    2    0.1099272  0.9986667  0.5308889  0.9600000  0.94   0.9597306
    ##    3    0.1168412  0.9986667  0.3308889  0.9600000  0.94   0.9597306
    ##    4    0.1110455  0.9986667  0.2842222  0.9600000  0.94   0.9597306
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9600000         0.9800000         0.9644444          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.96                  
    ##   0.97                  
    ##   0.97                  
    ##   0.97                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[40]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1324381  0.9933333  0.6813175  0.9466667  0.92   0.9458418
    ##    2    0.1155678  0.9946667  0.5104286  0.9533333  0.93   0.9525758
    ##    3    0.1154441  0.9946667  0.3370952  0.9600000  0.94   0.9593098
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9533333         0.9766667         0.9604762          
    ##   0.9600000         0.9800000         0.9660317          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## [[41]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1133918  0.9960000  0.6726548  0.9400000  0.91   0.9385522
    ##    2    0.1006643  0.9960000  0.3993214  0.9600000  0.94   0.9578200
    ##    3    0.1136024  0.9960000  0.2461032  0.9466667  0.92   0.9425759
    ##    4    0.1055672  0.9953333  0.1983056  0.9466667  0.92   0.9443519
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9468254          
    ##   0.9600000         0.9800000         0.9708333          
    ##   0.9466667         0.9733333         0.9638889          
    ##   0.9466667         0.9733333         0.9569444          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9723485            0.9468254       0.9400000    0.3133333          
    ##   0.9832168            0.9708333       0.9600000    0.3200000          
    ##   0.9785548            0.9638889       0.9466667    0.3155556          
    ##   0.9764828            0.9569444       0.9466667    0.3155556          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.970                 
    ##   0.960                 
    ##   0.960                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[42]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1297650  0.9960000  0.6860000  0.9466667  0.92   0.9452862
    ##    2    0.1144485  0.9950000  0.4641032  0.9533333  0.93   0.9524411
    ##    3    0.1182448  0.9946667  0.3169921  0.9533333  0.93   0.9529966
    ##    4    0.1190760  0.9960000  0.2527698  0.9533333  0.93   0.9529966
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9587302          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9588889          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[43]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9533333  0.93 
    ##    3    0.9466667  0.92 
    ##    4    0.9466667  0.92 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[44]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9533333  0.93 
    ##    2    0.9533333  0.93 
    ##    3    0.9600000  0.94 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## [[45]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9533333  0.93 
    ##    2    0.9600000  0.94 
    ##    3    0.9666667  0.95 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## [[46]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9533333  0.93 
    ##    3    0.9533333  0.93 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[47]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9466667  0.92 
    ##    3    0.9400000  0.91 
    ##    4    0.9333333  0.90 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.
    ## 
    ## [[48]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    3    0.9466667  0.92 
    ##    4    0.9466667  0.92 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.
    ## 
    ## [[49]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1296743  0.9973333  0.6951111  0.9400000  0.91   0.9389731
    ##    2    0.1153589  0.9973333  0.4684444  0.9533333  0.93   0.9528620
    ##    3    0.1131822  0.9973333  0.3151111  0.9600000  0.94   0.9595960
    ##    4    0.1120445  0.9973333  0.2951111  0.9600000  0.94   0.9595960
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9533333         0.9766667         0.9611111          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9600000         0.9800000         0.9666667          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.965                 
    ##   0.970                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 4.
    ## 
    ## [[50]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1335013  0.9893333  0.6538690  0.9333333  0.90   0.9327946
    ##    2    0.1175270  0.9906667  0.4562103  0.9466667  0.92   0.9462626
    ##    3    0.1247644  0.9920000  0.3119881  0.9466667  0.92   0.9462626
    ##    4    0.1208986  0.9906667  0.2762103  0.9466667  0.92   0.9462626
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9466667         0.9733333         0.9505556          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.95                  
    ##   0.96                  
    ##   0.96                  
    ##   0.96                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[51]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1476016  0.9910000  0.6570741  0.9466667  0.92   0.9462626
    ##    2    0.1178078  0.9973333  0.4151111  0.9600000  0.94   0.9595960
    ##    3    0.3181564  0.9930000  0.2467778  0.9533333  0.93   0.9528620
    ##    4    0.5576547  0.9886667  0.1597778  0.9466667  0.92   0.9461279
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9533333         0.9766667         0.9611111          
    ##   0.9466667         0.9733333         0.9555556          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9757576            0.9555556       0.9466667    0.3155556          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.970                 
    ##   0.965                 
    ##   0.960                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[52]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1253117  0.9973333  0.7152143  0.9466667  0.92   0.9458418
    ##    2    0.1089687  0.9986667  0.4775556  0.9466667  0.92   0.9458418
    ##    3    0.1097700  0.9986667  0.3242222  0.9466667  0.92   0.9458418
    ##    4    0.1179319  0.9986667  0.2908889  0.9400000  0.91   0.9386869
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9400000         0.9700000         0.9509524          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9731313            0.9509524       0.9400000    0.3133333          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.960                 
    ##   0.955                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[53]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss     AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.12170909  0.9946667  0.7170952  0.9466667  0.92   0.9462626
    ##    2    0.10057619  0.9940000  0.5292619  0.9600000  0.94   0.9597306
    ##    3    0.09434603  0.9960000  0.3263810  0.9600000  0.94   0.9597306
    ##   NA           NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9600000         0.9800000         0.9644444          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.96                  
    ##   0.97                  
    ##   0.97                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## [[54]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1223409  0.9946667  0.6436587  0.9466667  0.92   0.9462626
    ##    2    0.1136952  0.9973333  0.4017778  0.9466667  0.92   0.9457071
    ##    3    0.3207548  0.9916667  0.2310000  0.9600000  0.94   0.9595960
    ##    4    0.3134296  0.9923333  0.1395556  0.9533333  0.93   0.9524411
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9533333         0.9766667         0.9626984          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.970                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[55]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1439495  0.9940000  0.6620556  0.9533333  0.93   0.9528620
    ##    2    0.1110781  1.0000000  0.4066667  0.9466667  0.92   0.9461279
    ##    3    0.1523813  1.0000000  0.2333333  0.9400000  0.91   0.9389731
    ##    4    0.3500835  0.9923333  0.2062222  0.9600000  0.94   0.9595960
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9611111          
    ##   0.9466667         0.9733333         0.9555556          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9600000         0.9800000         0.9666667          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9757576            0.9555556       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.960                 
    ##   0.955                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[56]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02689873   9         1.1186604  0.5017006         18              
    ##   0.10339048   2         4.7965515  0.4114670          8              
    ##   0.12819800   9         4.0864885  0.4380444         13              
    ##   0.14737488   5         7.4903001  0.6127656          3              
    ##   0.16628441   9         0.8456683  0.5064936         18              
    ##   0.30552451   5         2.2512556  0.4552914          3              
    ##   0.47242653  10         4.9995205  0.5576734          6              
    ##   0.50074173  10         5.0396129  0.6057206          8              
    ##   0.55760167   8         0.6192581  0.6240394          8              
    ##   0.58070184   3         6.6124660  0.6642262          1              
    ##   subsample  nrounds  logLoss    AUC        prAUC       Accuracy   Kappa
    ##   0.4582901  231      1.0962507  0.5733333  0.02049735  0.3933333  0.09 
    ##   0.2770308  664      0.5246996  0.9893333  0.59461772  0.9266667  0.89 
    ##   0.4799113  576      0.5333395  0.9806667  0.58737831  0.9066667  0.86 
    ##   0.3218215  231      0.4647924  0.9960000  0.24675000  0.9400000  0.91 
    ##   0.4858883   27      1.0941660  0.5366667  0.01884921  0.3733333  0.06 
    ##   0.7615572  873      0.1768818  0.9900000  0.65887512  0.9533333  0.93 
    ##   0.8824130  967      0.2127645  0.9880000  0.23070370  0.9533333  0.93 
    ##   0.5433916  727      0.2713770  0.9893333  0.29067388  0.9400000  0.91 
    ##   0.8506968   69      0.2202289  0.9893333  0.45171958  0.9333333  0.90 
    ##   0.7160807   20      0.2806223  0.9913333  0.21908466  0.9600000  0.94 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##         NaN  0.3933333         0.6966667               NaN          
    ##   0.9242424  0.9266667         0.9633333         0.9452381          
    ##   0.9022476  0.9066667         0.9533333         0.9284524          
    ##   0.9385522  0.9400000         0.9700000         0.9531746          
    ##         NaN  0.3733333         0.6866667               NaN          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   0.9520202  0.9533333         0.9766667         0.9642857          
    ##   0.9381313  0.9400000         0.9700000         0.9547619          
    ##   0.9313973  0.9333333         0.9666667         0.9492063          
    ##   0.9591751  0.9600000         0.9800000         0.9682540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.8064815                  NaN       0.3933333    0.1311111          
    ##   0.9686869            0.9452381       0.9266667    0.3088889          
    ##   0.9601865            0.9284524       0.9066667    0.3022222          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.8125000                  NaN       0.3733333    0.1244444          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9797980            0.9642857       0.9533333    0.3177778          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9712121            0.9492063       0.9333333    0.3111111          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   Mean_Balanced_Accuracy
    ##   0.545                 
    ##   0.945                 
    ##   0.930                 
    ##   0.955                 
    ##   0.530                 
    ##   0.965                 
    ##   0.965                 
    ##   0.955                 
    ##   0.950                 
    ##   0.970                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 873, max_depth = 5,
    ##  eta = 0.3055245, gamma = 2.251256, colsample_bytree =
    ##  0.4552914, min_child_weight = 3 and subsample = 0.7615572.
    ## 
    ## [[57]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta          max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.007009399  10         2.7677041  0.4400230         19              
    ##   0.093442796   3         7.6039832  0.3720594         20              
    ##   0.112231655   5         6.7528272  0.3499339          0              
    ##   0.150267192   2         3.8199943  0.4380470         11              
    ##   0.220545686   9         5.0419176  0.6847606         14              
    ##   0.263886317   4         7.6075398  0.3560588         20              
    ##   0.379351866   2         0.8739472  0.6774875          6              
    ##   0.388127434   6         8.8303013  0.4505690         12              
    ##   0.437113916   2         9.5706032  0.4429705          9              
    ##   0.445374085   3         3.2304913  0.5855829          6              
    ##   subsample  nrounds  logLoss    AUC        prAUC       Accuracy   Kappa
    ##   0.5574600  662      1.0728689  0.8440000  0.27994243  0.6933333  0.54 
    ##   0.5802884   71      1.0776776  0.6733333  0.04870503  0.4800000  0.22 
    ##   0.6661648  392      0.3003087  0.9900000  0.56954425  0.9466667  0.92 
    ##   0.3097329  792      0.7397086  0.9500000  0.43419096  0.8133333  0.72 
    ##   0.5595999  471      0.4756692  0.9833333  0.52042641  0.9266667  0.89 
    ##   0.8796389  603      0.5092331  0.9720000  0.45118251  0.9000000  0.85 
    ##   0.8108775   83      0.1817846  0.9866667  0.47131349  0.9600000  0.94 
    ##   0.4118080  593      0.5497505  0.9753333  0.33417857  0.8800000  0.82 
    ##   0.9054366  155      0.3030860  0.9880000  0.33207143  0.9333333  0.90 
    ##   0.4138556  548      0.2714938  0.9833333  0.29545238  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.7068302  0.6933333         0.8466667         0.8368607          
    ##   0.6666667  0.4800000         0.7400000         0.8095238          
    ##   0.9461279  0.9466667         0.9733333         0.9527778          
    ##   0.8178050  0.8133333         0.9066667         0.8587302          
    ##   0.9228355  0.9266667         0.9633333         0.9420635          
    ##   0.9231949  0.9000000         0.9500000         0.9370370          
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.8703212  0.8800000         0.9400000         0.8975000          
    ##   0.9326599  0.9333333         0.9666667         0.9416667          
    ##   0.9393939  0.9400000         0.9700000         0.9472222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.8954823            0.8368607       0.6933333    0.2311111          
    ##   0.8057067            0.8095238       0.4800000    0.1600000          
    ##   0.9750842            0.9527778       0.9466667    0.3155556          
    ##   0.9236053            0.8587302       0.8133333    0.2711111          
    ##   0.9685703            0.9420635       0.9266667    0.3088889          
    ##   0.9592929            0.9370370       0.9000000    0.3000000          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9480856            0.8975000       0.8800000    0.2933333          
    ##   0.9690236            0.9416667       0.9333333    0.3111111          
    ##   0.9720539            0.9472222       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.770                 
    ##   0.610                 
    ##   0.960                 
    ##   0.860                 
    ##   0.945                 
    ##   0.925                 
    ##   0.970                 
    ##   0.910                 
    ##   0.950                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 83, max_depth = 2,
    ##  eta = 0.3793519, gamma = 0.8739472, colsample_bytree =
    ##  0.6774875, min_child_weight = 6 and subsample = 0.8108775.
    ## 
    ## [[58]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02482192  10         5.6046046  0.4198726          3              
    ##   0.10125112   1         5.4964911  0.3921863         17              
    ##   0.16247706   6         5.4695929  0.3489723         14              
    ##   0.18142687   2         0.7119628  0.5302325         20              
    ##   0.27393603   1         1.0493663  0.6168994          2              
    ##   0.33377902   5         4.8530878  0.3885611         15              
    ##   0.34202738   4         6.6258888  0.5202839          6              
    ##   0.37514510   2         7.6329697  0.4347916         10              
    ##   0.50028465   2         1.3784108  0.4992919          7              
    ##   0.58456637   4         5.6502746  0.4193118          3              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.7217292  165      0.1976310  0.9906667  0.7163810  0.9666667  0.95 
    ##   0.9944178   22      0.4041025  0.9886667  0.6061508  0.9400000  0.91 
    ##   0.6102231   28      0.2432559  0.9873333  0.6435952  0.9533333  0.93 
    ##   0.2520694   56      0.8411575  0.8280000  0.1826335  0.6200000  0.43 
    ##   0.6846460  828      0.1775707  0.9833333  0.6331958  0.9600000  0.94 
    ##   0.5901326  878      0.2318023  0.9886667  0.5642341  0.9466667  0.92 
    ##   0.2561292  964      0.2519359  0.9913333  0.2824517  0.9600000  0.94 
    ##   0.2590266  191      0.3232451  0.9893333  0.3813069  0.9666667  0.95 
    ##   0.4251053  151      0.1764686  0.9866667  0.6084735  0.9533333  0.93 
    ##   0.8898684  461      0.1792750  0.9893333  0.5300026  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9659091  0.9666667         0.9833333         0.9738095          
    ##   0.9393939  0.9400000         0.9700000         0.9472222          
    ##   0.9529966  0.9533333         0.9766667         0.9588889          
    ##         NaN  0.6200000         0.8100000               NaN          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9461279  0.9466667         0.9733333         0.9527778          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9654040  0.9666667         0.9833333         0.9722222          
    ##   0.9528620  0.9533333         0.9766667         0.9583333          
    ##   0.9395286  0.9400000         0.9700000         0.9450000          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9853535            0.9738095       0.9666667    0.3222222          
    ##   0.9720539            0.9472222       0.9400000    0.3133333          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.8541667                  NaN       0.6200000    0.2066667          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9750842            0.9527778       0.9466667    0.3155556          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9853535            0.9722222       0.9666667    0.3222222          
    ##   0.9781145            0.9583333       0.9533333    0.3177778          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.975                 
    ##   0.955                 
    ##   0.965                 
    ##   0.715                 
    ##   0.970                 
    ##   0.960                 
    ##   0.970                 
    ##   0.975                 
    ##   0.965                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 151, max_depth = 2,
    ##  eta = 0.5002847, gamma = 1.378411, colsample_bytree =
    ##  0.4992919, min_child_weight = 7 and subsample = 0.4251053.
    ## 
    ## [[59]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.01977332  2          3.3573311  0.6979748          8              
    ##   0.08047022  4          6.8644814  0.4510254         11              
    ##   0.09793596  5          0.5646297  0.5920370          7              
    ##   0.17537836  1          3.3400530  0.3681707         13              
    ##   0.20658901  1          8.0403692  0.3429109          9              
    ##   0.21967130  1          4.3154496  0.6160907          6              
    ##   0.32929840  8          3.4895337  0.3907191         10              
    ##   0.41496457  8          9.0741395  0.6129662          2              
    ##   0.52666394  9          6.2630533  0.4037165         20              
    ##   0.54152655  2          2.8150365  0.4553991         12              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.6683340  444      0.9466667  0.92 
    ##   0.3662362  833      0.9000000  0.85 
    ##   0.4059783  886      0.9400000  0.91 
    ##   0.9627660  792      0.9666667  0.95 
    ##   0.6073181  835      0.9666667  0.95 
    ##   0.7204077  744      0.9466667  0.92 
    ##   0.2659633  876      0.8133333  0.72 
    ##   0.3672318  660      0.9466667  0.92 
    ##   0.7104291  605      0.8200000  0.73 
    ##   0.6960119   89      0.9733333  0.96 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 89, max_depth = 2,
    ##  eta = 0.5415266, gamma = 2.815037, colsample_bytree =
    ##  0.4553991, min_child_weight = 12 and subsample = 0.6960119.
    ## 
    ## [[60]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02318672  1          6.6260729  0.5815881         11              
    ##   0.08687563  6          6.0329815  0.4359725          4              
    ##   0.20391038  6          5.1927123  0.5018903         15              
    ##   0.23665068  2          2.0533045  0.5086049          8              
    ##   0.24325575  7          9.9848415  0.4521114          3              
    ##   0.35206828  2          5.6586415  0.5269467         14              
    ##   0.35939171  7          0.2255089  0.5546268          0              
    ##   0.39103786  4          1.9574009  0.3283340          9              
    ##   0.43306637  8          9.5658514  0.4624780         12              
    ##   0.44222726  8          4.7402270  0.5420659          7              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.9933011  958      0.9466667  0.92 
    ##   0.4333983  630      0.9333333  0.90 
    ##   0.4129211  219      0.6733333  0.51 
    ##   0.5046931  510      0.9600000  0.94 
    ##   0.5608606  927      0.9400000  0.91 
    ##   0.4276024  624      0.8200000  0.73 
    ##   0.4703984  259      0.9533333  0.93 
    ##   0.6297550   75      0.9333333  0.90 
    ##   0.6271674  392      0.9266667  0.89 
    ##   0.9146645  547      0.9400000  0.91 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 510, max_depth = 2,
    ##  eta = 0.2366507, gamma = 2.053305, colsample_bytree =
    ##  0.5086049, min_child_weight = 8 and subsample = 0.5046931.
    ## 
    ## [[61]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma       colsample_bytree  min_child_weight
    ##   0.1080750  10         5.37394968  0.5305338          3              
    ##   0.2489482   8         0.58480117  0.6467686         18              
    ##   0.2570017   4         6.72625465  0.3114495          7              
    ##   0.2597606   8         0.93837458  0.5015596          7              
    ##   0.3575489   2         4.99665681  0.5696957         15              
    ##   0.4166273   2         4.19643659  0.4223256         10              
    ##   0.4649823   3         4.48532129  0.5847111         20              
    ##   0.5259216   1         0.04008689  0.5201734         20              
    ##   0.5494047   4         9.06886730  0.3724348         12              
    ##   0.5528741   7         2.95927692  0.3156917          7              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.4205846  153      0.9666667  0.95 
    ##   0.2894986  400      0.9133333  0.87 
    ##   0.6822852  500      0.9466667  0.92 
    ##   0.5367836  161      0.9466667  0.92 
    ##   0.4595061  220      0.9533333  0.93 
    ##   0.3566936  197      0.9600000  0.94 
    ##   0.3995012  250      0.9066667  0.86 
    ##   0.8252749  945      0.9400000  0.91 
    ##   0.5237051  823      0.9533333  0.93 
    ##   0.4957036  680      0.9733333  0.96 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 680, max_depth = 7,
    ##  eta = 0.5528741, gamma = 2.959277, colsample_bytree =
    ##  0.3156917, min_child_weight = 7 and subsample = 0.4957036.
    ## 
    ## [[62]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.02291041   2         7.133687  0.3421018          7              
    ##   0.07356543  10         8.447265  0.4634668         17              
    ##   0.16197901   8         2.279581  0.6690080         15              
    ##   0.18937065   9         8.090003  0.5840178          0              
    ##   0.19188911   6         3.698359  0.5295794         14              
    ##   0.37928599   9         8.432454  0.5722331         17              
    ##   0.38652469   8         5.185679  0.3597529          7              
    ##   0.41088674   8         3.270287  0.5892394          9              
    ##   0.45242852   5         7.656328  0.4181568          6              
    ##   0.54075096   2         7.496749  0.4693078         15              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.7614307  176      0.9466667  0.92 
    ##   0.9493706  987      0.9400000  0.91 
    ##   0.9204220  359      0.9400000  0.91 
    ##   0.9648236  800      0.9400000  0.91 
    ##   0.3774765  482      0.7133333  0.57 
    ##   0.5208409  969      0.7800000  0.67 
    ##   0.6005883  734      0.9466667  0.92 
    ##   0.7192471  154      0.9466667  0.92 
    ##   0.9749795    1      0.8733333  0.81 
    ##   0.4903544  359      0.8400000  0.76 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 154, max_depth = 8,
    ##  eta = 0.4108867, gamma = 3.270287, colsample_bytree =
    ##  0.5892394, min_child_weight = 9 and subsample = 0.7192471.
    ## 
    ## [[63]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.05113976  2          1.558226  0.6613067         16              
    ##   0.12128559  9          5.249478  0.4272196          9              
    ##   0.15112052  2          6.684581  0.3158779         20              
    ##   0.18766465  9          1.476779  0.3380189          9              
    ##   0.20684344  1          3.102837  0.6547995          7              
    ##   0.21163345  6          6.513298  0.5386669          9              
    ##   0.24744339  8          9.742273  0.6543338         14              
    ##   0.53940502  2          2.248686  0.5324960         16              
    ##   0.54818649  4          9.999923  0.6888182          2              
    ##   0.55692288  8          7.392499  0.4576498          9              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.8584007  430      0.9400000  0.91 
    ##   0.3849967    6      0.8266667  0.74 
    ##   0.7468637  693      0.8666667  0.80 
    ##   0.9341637  566      0.9533333  0.93 
    ##   0.7795796  883      0.9466667  0.92 
    ##   0.6124696  696      0.9400000  0.91 
    ##   0.6671114  513      0.9600000  0.94 
    ##   0.2633479  960      0.3333333  0.00 
    ##   0.6649752  991      0.9400000  0.91 
    ##   0.7677560  323      0.9466667  0.92 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 513, max_depth = 8,
    ##  eta = 0.2474434, gamma = 9.742273, colsample_bytree =
    ##  0.6543338, min_child_weight = 14 and subsample = 0.6671114.
    ## 
    ## [[64]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.01566790   9         3.7994296  0.6214079         12              
    ##   0.07772007  10         9.2624978  0.4492375          2              
    ##   0.10680302   1         0.3526196  0.6584419         18              
    ##   0.16497726   3         8.8607822  0.5261489         14              
    ##   0.31896298   5         9.5529211  0.3957696          4              
    ##   0.36515785  10         2.8899243  0.4522077         13              
    ##   0.37010109   4         4.4303998  0.3094816          6              
    ##   0.45748265   2         6.0934960  0.6734609         12              
    ##   0.46060447   5         4.9750261  0.4437970          3              
    ##   0.56419203   1         8.6560237  0.5230141          2              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.4559758  891      0.9466667  0.92 
    ##   0.5492621  452      0.9600000  0.94 
    ##   0.3442853  364      0.9200000  0.88 
    ##   0.9594428  612      0.9400000  0.91 
    ##   0.5913660  841      0.9600000  0.94 
    ##   0.4503320   10      0.9600000  0.94 
    ##   0.6562713  248      0.9400000  0.91 
    ##   0.5056584  218      0.9600000  0.94 
    ##   0.2656208  550      0.9666667  0.95 
    ##   0.5600102  932      0.9600000  0.94 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 550, max_depth = 5,
    ##  eta = 0.4606045, gamma = 4.975026, colsample_bytree =
    ##  0.443797, min_child_weight = 3 and subsample = 0.2656208.
    ## 
    ## [[65]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.1711763   7         4.0201309  0.4792185          4              
    ##   0.2123928   3         3.7996952  0.6314419         16              
    ##   0.2233327  10         8.1886254  0.6388212         19              
    ##   0.3114193   3         0.6204786  0.4332426          6              
    ##   0.3167788  10         5.6649142  0.3200350         20              
    ##   0.3934875   3         7.1117361  0.3864775         16              
    ##   0.4039595   7         4.0780334  0.6618091         20              
    ##   0.5164765   6         8.8833465  0.5347621         11              
    ##   0.5472755   2         7.8088403  0.4082921         10              
    ##   0.5818291   6         7.8141741  0.6959499         15              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.5134995  591      0.2400123  0.9880000  0.6009783  0.9466667  0.92 
    ##   0.5031642  567      0.6912813  0.9540000  0.4795521  0.8133333  0.72 
    ##   0.4081254   43      1.0992611  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.9508625  303      0.1745498  0.9880000  0.7300733  0.9533333  0.93 
    ##   0.9308598  797      0.4695414  0.9806667  0.4783942  0.9200000  0.88 
    ##   0.8519089   24      0.3855669  0.9840000  0.3857763  0.9400000  0.91 
    ##   0.4494396  665      1.1002218  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.4124411  494      0.4625657  0.9806667  0.2505238  0.9400000  0.91 
    ##   0.7391800  342      0.3003213  0.9873333  0.3786987  0.9466667  0.92 
    ##   0.7497127  972      0.3343389  0.9880000  0.2010100  0.9600000  0.94 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9457071  0.9466667         0.9733333         0.9543651          
    ##   0.7931099  0.8133333         0.9066667         0.8380159          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9175589  0.9200000         0.9600000         0.9342857          
    ##   0.9383165  0.9400000         0.9700000         0.9471429          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9363035  0.9400000         0.9700000         0.9531746          
    ##   0.9448653  0.9466667         0.9733333         0.9603175          
    ##   0.9591751  0.9600000         0.9800000         0.9682540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9222931            0.8380159       0.8133333    0.2711111          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9645455            0.9342857       0.9200000    0.3066667          
    ##   0.9725253            0.9471429       0.9400000    0.3133333          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9746309            0.9531746       0.9400000    0.3133333          
    ##   0.9772727            0.9603175       0.9466667    0.3155556          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.860                 
    ##   0.500                 
    ##   0.965                 
    ##   0.940                 
    ##   0.955                 
    ##   0.500                 
    ##   0.955                 
    ##   0.960                 
    ##   0.970                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 303, max_depth = 3,
    ##  eta = 0.3114193, gamma = 0.6204786, colsample_bytree =
    ##  0.4332426, min_child_weight = 6 and subsample = 0.9508625.
    ## 
    ## [[66]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta          max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.007667202  3          9.679453  0.5085298          2              
    ##   0.144041742  3          1.122959  0.3852799          0              
    ##   0.217176709  2          2.484552  0.3601234          7              
    ##   0.354994566  2          2.533954  0.6333314          9              
    ##   0.365698881  8          1.935811  0.4914190          1              
    ##   0.366906612  5          6.360774  0.4654635          9              
    ##   0.422495611  8          4.381504  0.4138440         14              
    ##   0.461129683  3          1.422534  0.5790226         11              
    ##   0.513000411  9          9.469561  0.4551831         12              
    ##   0.555684358  2          2.306238  0.3848269         17              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6358158    8      1.0357675  0.9993333  0.3587778  0.9400000  0.91 
    ##   0.4774259   89      0.1556786  1.0000000  0.7200000  0.9533333  0.93 
    ##   0.6281727  101      0.2306922  0.9986667  0.6175556  0.9466667  0.92 
    ##   0.8878387  323      0.2032836  0.9880000  0.4316667  0.9533333  0.93 
    ##   0.9918338  550      0.1808321  0.9866667  0.5976154  0.9466667  0.92 
    ##   0.5227873  142      0.3342754  0.9933333  0.4048889  0.9400000  0.91 
    ##   0.4429405  997      0.6088149  0.9633333  0.4502274  0.8800000  0.82 
    ##   0.9873013  557      0.2352406  0.9860000  0.3773704  0.9533333  0.93 
    ##   0.3898151  522      0.6289586  0.9226667  0.2121824  0.8400000  0.76 
    ##   0.2549660  618      1.1022069  0.5000000  0.0000000  0.3333333  0.00 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9389731  0.9400000         0.9700000         0.9515873          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.9457071  0.9466667         0.9733333         0.9571429          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.9462626  0.9466667         0.9733333         0.9533333          
    ##   0.9389731  0.9400000         0.9700000         0.9515873          
    ##   0.8770034  0.8800000         0.9400000         0.8980952          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.8237124  0.8400000         0.9200000         0.8811508          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9456566            0.8980952       0.8800000    0.2933333          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9355811            0.8811508       0.8400000    0.2800000          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ##   0.960                 
    ##   0.955                 
    ##   0.910                 
    ##   0.965                 
    ##   0.880                 
    ##   0.500                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 89, max_depth = 3,
    ##  eta = 0.1440417, gamma = 1.122959, colsample_bytree =
    ##  0.3852799, min_child_weight = 0 and subsample = 0.4774259.
    ## 
    ## [[67]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.03786024  1          2.6394359  0.6606319         17              
    ##   0.09544453  8          9.4563443  0.5381277         13              
    ##   0.15934164  4          5.3182797  0.4526872          3              
    ##   0.23062235  3          2.2042970  0.3091873          4              
    ##   0.30861361  5          4.3452149  0.5621675         20              
    ##   0.52052732  7          3.6358938  0.6228069          9              
    ##   0.52310614  1          1.6044475  0.3675567         13              
    ##   0.53085493  9          2.2080442  0.3403656          3              
    ##   0.55692464  1          6.4181113  0.5699536          6              
    ##   0.56878986  8          0.5043435  0.5427443         13              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.5147065  822      0.2870434  0.9840000  0.6654689  0.9533333  0.93 
    ##   0.6985028  510      0.2219314  0.9860000  0.4758968  0.9600000  0.94 
    ##   0.4122969  567      0.2040386  0.9860000  0.6114656  0.9600000  0.94 
    ##   0.7363155   66      0.1601561  0.9846667  0.7313523  0.9600000  0.94 
    ##   0.4145206  479      0.3877680  0.9880000  0.5384444  0.9333333  0.90 
    ##   0.3749733   96      0.2016621  0.9906667  0.3016852  0.9600000  0.94 
    ##   0.7369557  777      0.2055362  0.9846667  0.6036368  0.9533333  0.93 
    ##   0.6415972   44      0.1519773  0.9866667  0.6236667  0.9533333  0.93 
    ##   0.5423490  508      0.1993021  0.9866667  0.3447579  0.9466667  0.92 
    ##   0.9426138  105      0.1797367  0.9860000  0.5612143  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9593098  0.9600000         0.9800000         0.9660317          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9305977  0.9333333         0.9666667         0.9479762          
    ##   0.9593098  0.9600000         0.9800000         0.9660317          
    ##   0.9531313  0.9533333         0.9766667         0.9566667          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9709946            0.9479762       0.9333333    0.3111111          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##   0.9775758            0.9566667       0.9533333    0.3177778          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.970                 
    ##   0.970                 
    ##   0.970                 
    ##   0.950                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 44, max_depth = 9,
    ##  eta = 0.5308549, gamma = 2.208044, colsample_bytree =
    ##  0.3403656, min_child_weight = 3 and subsample = 0.6415972.
    ## 
    ## [[68]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9600000  0.94 
    ##    3    0.9533333  0.93 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[69]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma       colsample_bytree  min_child_weight
    ##   0.07679714   6         3.45905008  0.6990506         17              
    ##   0.09879551  10         2.84835280  0.3438217         12              
    ##   0.16281988   6         0.62415557  0.6397767          5              
    ##   0.16626407   9         1.57437163  0.4609147         12              
    ##   0.18653167   7         3.86278281  0.4130433         13              
    ##   0.21543600   5         9.35232525  0.3107740         15              
    ##   0.26902121   3         8.00661121  0.5112715          2              
    ##   0.29361136  10         4.52793301  0.6978550         19              
    ##   0.43984604  10         0.08058162  0.6451435         15              
    ##   0.45541263   6         1.47998299  0.4737206         12              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6045450  282      0.6136444  0.9686667  0.5133466  0.8733333  0.81 
    ##   0.7755132  345      0.2955228  0.9913333  0.6696349  0.9466667  0.92 
    ##   0.7837174  410      0.1738284  0.9893333  0.6271111  0.9466667  0.92 
    ##   0.3163578  653      0.8475860  0.9153333  0.3385421  0.7666667  0.65 
    ##   0.2625426  762      1.0992872  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.5740249  717      0.5320947  0.9813333  0.4120093  0.9066667  0.86 
    ##   0.9004434  421      0.2853867  0.9900000  0.2817850  0.9533333  0.93 
    ##   0.3196867  316      1.0991560  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.5968259  689      0.4837012  0.9553333  0.4832219  0.9000000  0.85 
    ##   0.4203703  582      0.5104745  0.9546667  0.4535203  0.8533333  0.78 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.8665477  0.8733333         0.9366667         0.9016270          
    ##   0.9454209  0.9466667         0.9733333         0.9565079          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.7635404  0.7666667         0.8833333         0.8293981          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9013540  0.9066667         0.9533333         0.9258730          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.8968013  0.9000000         0.9500000         0.9123016          
    ##   0.8498329  0.8533333         0.9266667         0.8635317          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9458275            0.9016270       0.8733333    0.2911111          
    ##   0.9761616            0.9565079       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9097956            0.8293981       0.7666667    0.2555556          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9601865            0.9258730       0.9066667    0.3022222          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9545034            0.9123016       0.9000000    0.3000000          
    ##   0.9316667            0.8635317       0.8533333    0.2844444          
    ##   Mean_Balanced_Accuracy
    ##   0.905                 
    ##   0.960                 
    ##   0.960                 
    ##   0.825                 
    ##   0.500                 
    ##   0.930                 
    ##   0.965                 
    ##   0.500                 
    ##   0.925                 
    ##   0.890                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 410, max_depth = 6,
    ##  eta = 0.1628199, gamma = 0.6241556, colsample_bytree =
    ##  0.6397767, min_child_weight = 5 and subsample = 0.7837174.
    ## 
    ## [[70]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma         colsample_bytree  min_child_weight
    ##   0.08809242  10         8.2056751801  0.4641190          6              
    ##   0.10319878   2         0.2100015339  0.3481472          8              
    ##   0.16700377   4         9.4669227628  0.6852647          9              
    ##   0.17013891  10         0.3038071212  0.6818806          3              
    ##   0.31062089   3         0.8240623795  0.6157133          2              
    ##   0.43803344   6         0.0001099613  0.3620442         14              
    ##   0.46331258   3         1.2930661393  0.4596024         10              
    ##   0.50955328   9         1.8497421104  0.4467608         17              
    ##   0.57799926   9         8.1801533536  0.4934722          5              
    ##   0.58628698   4         7.9319810541  0.5179946          4              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.9900371  740      0.2967533  0.9906667  0.5533333  0.9466667  0.92 
    ##   0.5356134  748      0.2503429  0.9940000  0.7099881  0.9466667  0.92 
    ##   0.9236924  935      0.3126787  0.9900000  0.2078148  0.9400000  0.91 
    ##   0.8580117  353      0.1617054  0.9940000  0.6862294  0.9600000  0.94 
    ##   0.8856134  155      0.1611613  0.9966667  0.6009365  0.9533333  0.93 
    ##   0.3098723  139      1.0997898  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.4880862   75      0.3674466  0.9866667  0.5284630  0.9400000  0.91 
    ##   0.7476076  331      0.4671074  0.9666667  0.4845833  0.8466667  0.77 
    ##   0.2927765  296      0.4673023  0.9880000  0.1874444  0.9533333  0.93 
    ##   0.4887616  259      0.3227356  0.9920000  0.1401111  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9457071  0.9466667         0.9733333         0.9571429          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9389731  0.9400000         0.9700000         0.9515873          
    ##   0.9591751  0.9600000         0.9800000         0.9682540          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9391077  0.9400000         0.9700000         0.9493651          
    ##   0.8381663  0.8466667         0.9233333         0.8657540          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9307456            0.8657540       0.8466667    0.2822222          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.955                 
    ##   0.970                 
    ##   0.965                 
    ##   0.500                 
    ##   0.955                 
    ##   0.885                 
    ##   0.965                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 155, max_depth = 3,
    ##  eta = 0.3106209, gamma = 0.8240624, colsample_bytree =
    ##  0.6157133, min_child_weight = 2 and subsample = 0.8856134.
    ## 
    ## [[71]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.1044003  3          1.0827506  0.6973693          3              
    ##   0.1401327  1          5.4470214  0.5948446         18              
    ##   0.1962707  6          9.3391737  0.4175283          8              
    ##   0.2207797  4          7.9396321  0.6645086          4              
    ##   0.2335025  9          2.7477346  0.4404394         16              
    ##   0.2718008  9          0.8106173  0.6541888          7              
    ##   0.2827898  3          0.3877643  0.3048975          6              
    ##   0.3385495  8          7.9925519  0.5336980         12              
    ##   0.5684560  5          1.5458878  0.5799034          0              
    ##   0.5889252  7          1.7633113  0.5789626         12              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.4498778  330      0.1385510  0.9906667  0.7143788  0.9533333  0.93 
    ##   0.4441995   13      0.4178851  0.9826667  0.4574392  0.9533333  0.93 
    ##   0.6853471  519      0.2226369  0.9940000  0.5964167  0.9400000  0.91 
    ##   0.3407840   31      0.2956315  0.9926667  0.3363889  0.9466667  0.92 
    ##   0.3360731  704      0.3744480  0.9800000  0.5805608  0.9400000  0.91 
    ##   0.2593646  323      0.2227795  0.9873333  0.5873961  0.9600000  0.94 
    ##   0.4716272  455      0.1579903  0.9840000  0.7105783  0.9533333  0.93 
    ##   0.5472981  283      0.2158978  0.9893333  0.2702024  0.9533333  0.93 
    ##   0.8629546  732      0.1554581  0.9906667  0.5243399  0.9466667  0.92 
    ##   0.6231147  232      0.1887364  0.9893333  0.4308995  0.9466667  0.92 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9529966  0.9533333         0.9766667         0.9588889          
    ##   0.9520202  0.9533333         0.9766667         0.9642857          
    ##   0.9391077  0.9400000         0.9700000         0.9493651          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9392424  0.9400000         0.9700000         0.9471429          
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9797980            0.9642857       0.9533333    0.3177778          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9720202            0.9471429       0.9400000    0.3133333          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.965                 
    ##   0.955                 
    ##   0.960                 
    ##   0.955                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##   0.960                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 330, max_depth = 3,
    ##  eta = 0.1044003, gamma = 1.082751, colsample_bytree =
    ##  0.6973693, min_child_weight = 3 and subsample = 0.4498778.
    ## 
    ## [[72]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.06118835  10         8.010300  0.6447350          5              
    ##   0.13366803  10         9.444070  0.4466298         13              
    ##   0.14130938   3         3.411456  0.6460579          5              
    ##   0.24060975  10         1.626389  0.5003619         19              
    ##   0.25305518   6         3.255874  0.4842713         10              
    ##   0.28231763   9         9.390287  0.6058024         19              
    ##   0.36147542   7         8.172109  0.3848698          3              
    ##   0.45881386   8         7.249477  0.5115489          9              
    ##   0.48283169   8         7.100266  0.6588138          2              
    ##   0.53491707   9         1.193591  0.3282547          3              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6463226   97      0.3459818  0.9940000  0.3534040  0.9533333  0.93 
    ##   0.4429549  479      0.6146870  0.9860000  0.4564471  0.8666667  0.80 
    ##   0.8449205  600      0.1975113  0.9893333  0.4481667  0.9466667  0.92 
    ##   0.7603895  998      0.5343303  0.9560000  0.4602848  0.8800000  0.82 
    ##   0.7415224  117      0.2715794  0.9853333  0.5630339  0.9333333  0.90 
    ##   0.6473647  166      0.6803745  0.9433333  0.3220847  0.8066667  0.71 
    ##   0.7667083  780      0.2943370  0.9846667  0.3881089  0.9266667  0.89 
    ##   0.4691874  416      0.3484014  0.9866667  0.2575000  0.9400000  0.91 
    ##   0.7566718  946      0.2629864  0.9886667  0.1741389  0.9400000  0.91 
    ##   0.8573895  748      0.1703316  0.9880000  0.6758333  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.8527371  0.8666667         0.9333333         0.8932540          
    ##   0.9452862  0.9466667         0.9733333         0.9587302          
    ##   0.8713277  0.8800000         0.9400000         0.9173280          
    ##   0.9323737  0.9333333         0.9666667         0.9410317          
    ##   0.7828838  0.8066667         0.9033333         0.8485450          
    ##   0.9256397  0.9266667         0.9633333         0.9354762          
    ##   0.9388215  0.9400000         0.9700000         0.9487302          
    ##   0.9389731  0.9400000         0.9700000         0.9488095          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9456627            0.8932540       0.8666667    0.2888889          
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   0.9509657            0.9173280       0.8800000    0.2933333          
    ##   0.9689226            0.9410317       0.9333333    0.3111111          
    ##   0.9230723            0.8485450       0.8066667    0.2688889          
    ##   0.9658923            0.9354762       0.9266667    0.3088889          
    ##   0.9725253            0.9487302       0.9400000    0.3133333          
    ##   0.9725589            0.9488095       0.9400000    0.3133333          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.900                 
    ##   0.960                 
    ##   0.910                 
    ##   0.950                 
    ##   0.855                 
    ##   0.945                 
    ##   0.955                 
    ##   0.955                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 748, max_depth = 9,
    ##  eta = 0.5349171, gamma = 1.193591, colsample_bytree =
    ##  0.3282547, min_child_weight = 3 and subsample = 0.8573895.
    ## 
    ## [[73]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma       colsample_bytree  min_child_weight
    ##   0.08061082   5         2.58494277  0.5649485         13              
    ##   0.08092330  10         6.32256319  0.6636697         20              
    ##   0.14194862   9         0.04869052  0.4127050         12              
    ##   0.16090168   5         6.52716701  0.6972769         11              
    ##   0.16558239   5         0.31172497  0.3102848         10              
    ##   0.20233384   7         5.19521673  0.4428835         16              
    ##   0.23645137   6         4.88584352  0.3080061          4              
    ##   0.39156295   6         0.82946260  0.6306322          3              
    ##   0.46927568   6         1.26465500  0.4769778         12              
    ##   0.47355036  10         2.25558818  0.3539293          1              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.8498066   15      0.4342546  0.9900000  0.5181587  0.9400000  0.91 
    ##   0.4927142   54      1.0987481  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.3973226  232      0.6220150  0.9660000  0.5321771  0.8733333  0.81 
    ##   0.7984823   40      0.2850815  0.9873333  0.3845375  0.9533333  0.93 
    ##   0.5247511  199      0.3379564  0.9793333  0.6209862  0.9466667  0.92 
    ##   0.9579428  768      0.3253810  0.9913333  0.5769709  0.9533333  0.93 
    ##   0.2989947  329      0.3561690  0.9873333  0.4505079  0.9400000  0.91 
    ##   0.6832081  558      0.1532308  0.9900000  0.5931248  0.9400000  0.91 
    ##   0.4531894  643      0.4877043  0.9540000  0.4689481  0.8733333  0.81 
    ##   0.7589756  239      0.1608662  0.9933333  0.5898889  0.9466667  0.92 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9395286  0.9400000         0.9700000         0.9450000          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.8659753  0.8733333         0.9366667         0.8983730          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##   0.9463973  0.9466667         0.9733333         0.9483333          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9392424  0.9400000         0.9700000         0.9471429          
    ##   0.9388215  0.9400000         0.9700000         0.9487302          
    ##   0.8675806  0.8733333         0.9366667         0.8903439          
    ##   0.9465320  0.9466667         0.9733333         0.9488889          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9454571            0.8983730       0.8733333    0.2911111          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9738721            0.9483333       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9720202            0.9471429       0.9400000    0.3133333          
    ##   0.9725253            0.9487302       0.9400000    0.3133333          
    ##   0.9418651            0.8903439       0.8733333    0.2911111          
    ##   0.9739394            0.9488889       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.500                 
    ##   0.905                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.955                 
    ##   0.905                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 558, max_depth = 6,
    ##  eta = 0.391563, gamma = 0.8294626, colsample_bytree =
    ##  0.6306322, min_child_weight = 3 and subsample = 0.6832081.
    ## 
    ## [[74]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.08392365   2         4.0885515  0.5530213         18              
    ##   0.10627085   5         9.7664267  0.3042507          3              
    ##   0.16774697   5         8.2877220  0.4999599          5              
    ##   0.18311111   2         0.7325850  0.4252894          4              
    ##   0.21701939   1         0.1437945  0.3606564          7              
    ##   0.38328808   2         2.2652616  0.3392443         15              
    ##   0.44986129   9         2.6610265  0.6533824         17              
    ##   0.48758133  10         2.5214148  0.4774016          4              
    ##   0.50254068   4         5.4124344  0.6592041          6              
    ##   0.58164617   9         6.0980736  0.5181328         12              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.2725230  580      0.6013855  0.9680000  0.5894643  0.8733333  0.81 
    ##   0.5994505  816      0.2448766  0.9913333  0.5777698  0.9533333  0.93 
    ##   0.8199521  442      0.2227926  0.9866667  0.5757381  0.9400000  0.91 
    ##   0.8003048  987      0.1483827  0.9880000  0.7552186  0.9600000  0.94 
    ##   0.8410956  800      0.1773160  0.9860000  0.7403161  0.9466667  0.92 
    ##   0.4889788  826      0.2516554  0.9820000  0.5829108  0.9400000  0.91 
    ##   0.8820809  133      0.1972530  0.9926667  0.4867778  0.9400000  0.91 
    ##   0.9326889  670      0.1431900  0.9866667  0.6836035  0.9466667  0.92 
    ##   0.7538141  707      0.1612311  0.9906667  0.2116746  0.9533333  0.93 
    ##   0.9141440  346      0.1688718  0.9900000  0.3753254  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.8937149  0.8733333         0.9366667         0.9084656          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##   0.9393771  0.9400000         0.9700000         0.9449206          
    ##   0.9598653  0.9600000         0.9800000         0.9622222          
    ##   0.9462626  0.9466667         0.9733333         0.9477778          
    ##   0.9396633  0.9400000         0.9700000         0.9427778          
    ##   0.9396633  0.9400000         0.9700000         0.9455556          
    ##   0.9462626  0.9466667         0.9733333         0.9505556          
    ##   0.9532660  0.9533333         0.9766667         0.9544444          
    ##   0.9524411  0.9533333         0.9766667         0.9599206          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9461953            0.9084656       0.8733333    0.2911111          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9714141            0.9449206       0.9400000    0.3133333          
    ##   0.9806061            0.9622222       0.9600000    0.3200000          
    ##   0.9738047            0.9477778       0.9466667    0.3155556          
    ##   0.9708418            0.9427778       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9769697            0.9544444       0.9533333    0.3177778          
    ##   0.9786195            0.9599206       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.905                 
    ##   0.965                 
    ##   0.955                 
    ##   0.970                 
    ##   0.960                 
    ##   0.955                 
    ##   0.955                 
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 670, max_depth =
    ##  10, eta = 0.4875813, gamma = 2.521415, colsample_bytree =
    ##  0.4774016, min_child_weight = 4 and subsample = 0.9326889.
    ## 
    ## [[75]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9333333  0.90 
    ##    2    0.9400000  0.91 
    ##    3    0.9400000  0.91 
    ##    4    0.9400000  0.91 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## [[76]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta          max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.007197151  1          0.7537243  0.3249564          7              
    ##   0.051918530  8          3.6714157  0.6729646          7              
    ##   0.116556008  7          2.3301342  0.5203881         10              
    ##   0.151592050  6          3.0171335  0.4157416         16              
    ##   0.236554432  5          3.2798069  0.6345319         20              
    ##   0.298182203  9          6.1629241  0.5261419         15              
    ##   0.299564148  9          1.6686567  0.3244383         19              
    ##   0.431651242  3          3.5050640  0.6735275         14              
    ##   0.478822647  3          7.6112002  0.6374092          5              
    ##   0.521503184  5          7.2127554  0.4900766          3              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.3120868   87      0.9200000  0.88 
    ##   0.8294789  758      0.9533333  0.93 
    ##   0.7433008  143      0.9333333  0.90 
    ##   0.4790736  991      0.8333333  0.75 
    ##   0.8111834  548      0.9000000  0.85 
    ##   0.5462849  888      0.8866667  0.83 
    ##   0.2644786  559      0.3333333  0.00 
    ##   0.3828410   74      0.6466667  0.47 
    ##   0.5456732  680      0.9466667  0.92 
    ##   0.7164638  309      0.9466667  0.92 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 758, max_depth = 8,
    ##  eta = 0.05191853, gamma = 3.671416, colsample_bytree =
    ##  0.6729646, min_child_weight = 7 and subsample = 0.8294789.
    ## 
    ## [[77]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.0910314   1         3.628095  0.4720691         15              
    ##   0.1258026   3         7.567689  0.6220617         17              
    ##   0.1487173   2         7.057589  0.4530419          4              
    ##   0.1594589   5         2.796545  0.6412727          4              
    ##   0.1958673   3         5.782795  0.5285112          7              
    ##   0.2267639  10         2.360814  0.5072708          3              
    ##   0.2487977   1         2.297137  0.3246502         16              
    ##   0.3910595  10         4.026326  0.5647506          1              
    ##   0.4544462   8         1.405832  0.6188143         14              
    ##   0.5179775  10         9.293311  0.4928403         13              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.7416362  928      0.9533333  0.93 
    ##   0.7935345  352      0.9266667  0.89 
    ##   0.2765360  936      0.9533333  0.93 
    ##   0.8316447  378      0.9533333  0.93 
    ##   0.9979966  454      0.9466667  0.92 
    ##   0.8467192  644      0.9533333  0.93 
    ##   0.7088739  201      0.9200000  0.88 
    ##   0.7810665  717      0.9466667  0.92 
    ##   0.9666887  866      0.9200000  0.88 
    ##   0.6922868  975      0.9466667  0.92 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 378, max_depth = 5,
    ##  eta = 0.1594589, gamma = 2.796545, colsample_bytree =
    ##  0.6412727, min_child_weight = 4 and subsample = 0.8316447.
    ## 
    ## [[78]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.01046016   3         6.475696  0.5673195         14              
    ##   0.03457191   9         7.626895  0.3236170          4              
    ##   0.03467552   8         1.704382  0.5920545          2              
    ##   0.11132244  10         5.761194  0.4976062         20              
    ##   0.13225047   9         1.567260  0.5762311          5              
    ##   0.13522966   8         9.279105  0.4622737         11              
    ##   0.25087908   7         6.669634  0.4350663          4              
    ##   0.39797412   2         5.270653  0.5508534         20              
    ##   0.51411112   6         4.550411  0.5637687         19              
    ##   0.55362912   5         6.156018  0.5836972         10              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.5506944  587      0.9466667  0.92 
    ##   0.4995951  353      0.9600000  0.94 
    ##   0.8452255  213      0.9666667  0.95 
    ##   0.3848943  101      0.9266667  0.89 
    ##   0.4190964  836      0.9400000  0.91 
    ##   0.7478293  107      0.9533333  0.93 
    ##   0.8527888  984      0.9600000  0.94 
    ##   0.8727175  428      0.9600000  0.94 
    ##   0.8589031  428      0.9533333  0.93 
    ##   0.3812043  935      0.9533333  0.93 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 213, max_depth = 8,
    ##  eta = 0.03467552, gamma = 1.704382, colsample_bytree =
    ##  0.5920545, min_child_weight = 2 and subsample = 0.8452255.
    ## 
    ## [[79]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.0846476  7          3.4749771  0.3004973          9              
    ##   0.1765531  4          3.3045303  0.5103993          9              
    ##   0.2147205  9          1.0499941  0.3783441          4              
    ##   0.2210476  1          0.1196085  0.6988883          0              
    ##   0.2543210  6          3.1299276  0.5634506          9              
    ##   0.3194816  9          1.7552308  0.3105342          4              
    ##   0.3385963  3          9.8176875  0.4649259         17              
    ##   0.5560383  4          8.0694684  0.3721173         14              
    ##   0.5565639  5          8.2755434  0.3288977          2              
    ##   0.5869358  9          0.8287797  0.4133708         20              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.6800086  652      0.9600000  0.94 
    ##   0.9528743  689      0.9333333  0.90 
    ##   0.9721741  699      0.9466667  0.92 
    ##   0.6400155  922      0.9400000  0.91 
    ##   0.4461656  120      0.9533333  0.93 
    ##   0.8500604  192      0.9600000  0.94 
    ##   0.5944375  633      0.8800000  0.82 
    ##   0.3815287   24      0.4533333  0.18 
    ##   0.8950544  826      0.9400000  0.91 
    ##   0.6389890  743      0.8066667  0.71 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 192, max_depth = 9,
    ##  eta = 0.3194816, gamma = 1.755231, colsample_bytree =
    ##  0.3105342, min_child_weight = 4 and subsample = 0.8500604.
    ## 
    ## [[80]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.03830604   1         2.7315305  0.4114250          9              
    ##   0.16075994   7         0.1691309  0.5665999         15              
    ##   0.21063282   2         6.2429227  0.6768615         12              
    ##   0.28131594   4         0.2732952  0.3825514         20              
    ##   0.29220087   3         6.8745560  0.4278071         14              
    ##   0.30718079   6         3.6310421  0.6277714          0              
    ##   0.31569402   1         4.4926747  0.6951173          5              
    ##   0.31877368  10         6.6607938  0.4395008          1              
    ##   0.48063072   8         8.3109185  0.4716291          3              
    ##   0.50305939   6         5.1374075  0.4666909          8              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.9327957  300      0.9400000  0.91 
    ##   0.6478413  520      0.9066667  0.86 
    ##   0.6535730  213      0.9600000  0.94 
    ##   0.5436269  267      0.3866667  0.08 
    ##   0.7700209  892      0.9600000  0.94 
    ##   0.8251955  442      0.9466667  0.92 
    ##   0.5550232  805      0.9466667  0.92 
    ##   0.5742196  141      0.9600000  0.94 
    ##   0.4509303  138      0.9533333  0.93 
    ##   0.6375803  607      0.9533333  0.93 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 141, max_depth =
    ##  10, eta = 0.3187737, gamma = 6.660794, colsample_bytree =
    ##  0.4395008, min_child_weight = 1 and subsample = 0.5742196.
    ## 
    ## [[81]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.01577306   6         5.146963  0.6463264         15              
    ##   0.06080005   6         4.679627  0.5224421         18              
    ##   0.19734906   1         8.125592  0.4499746          0              
    ##   0.22171691   5         5.709033  0.5148860         16              
    ##   0.27245948   8         2.515852  0.5449236         20              
    ##   0.28202071   1         4.944401  0.6361081          1              
    ##   0.38481254   2         5.753888  0.6367432          9              
    ##   0.39407208  10         7.450093  0.3359475         10              
    ##   0.42093056   4         6.841863  0.4603674          9              
    ##   0.49707879   2         2.566466  0.4433417          8              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.5387405  668      0.9600000  0.94 
    ##   0.5933934  406      0.9533333  0.93 
    ##   0.5404422  211      0.9400000  0.91 
    ##   0.6086528  842      0.9533333  0.93 
    ##   0.9878323  481      0.9466667  0.92 
    ##   0.8828356   29      0.9600000  0.94 
    ##   0.8097595  556      0.9533333  0.93 
    ##   0.6797143  226      0.9533333  0.93 
    ##   0.5119351  605      0.9466667  0.92 
    ##   0.3395818  708      0.9400000  0.91 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 29, max_depth = 1,
    ##  eta = 0.2820207, gamma = 4.944401, colsample_bytree =
    ##  0.6361081, min_child_weight = 1 and subsample = 0.8828356.
    ## 
    ## [[82]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.1388809   3         5.955362  0.5849898          5              
    ##   0.1537872   9         4.347723  0.3193375         17              
    ##   0.1728224   5         1.911082  0.5838075         13              
    ##   0.2186833  10         8.551929  0.5605444          5              
    ##   0.2480394   6         7.878192  0.6334121         12              
    ##   0.2550822   8         9.761854  0.3810816          0              
    ##   0.2871994   7         5.960339  0.4810414          1              
    ##   0.3969319  10         7.480943  0.5230883          6              
    ##   0.5556354   4         5.340683  0.4521864          4              
    ##   0.5854146   5         8.076015  0.3296669          5              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6026610  893      0.2744858  0.9906667  0.3311402  0.9533333  0.93 
    ##   0.3467158  134      1.0990439  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.2519020  132      1.0992815  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.4490877  380      0.3861478  0.9940000  0.1803810  0.9666667  0.95 
    ##   0.4852002  382      0.4569275  0.9840000  0.4141281  0.9266667  0.89 
    ##   0.3065502  891      0.5290423  0.9913333  0.1431944  0.9666667  0.95 
    ##   0.9241088   65      0.2590403  0.9893333  0.5430926  0.9466667  0.92 
    ##   0.4094943  287      0.3855502  0.9820000  0.2005527  0.9533333  0.93 
    ##   0.7922793  856      0.2419286  0.9853333  0.3990569  0.9400000  0.91 
    ##   0.8578919  250      0.2646927  0.9900000  0.3036323  0.9466667  0.92 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9528620  0.9533333         0.9766667         0.9583333          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9659091  0.9666667         0.9833333         0.9738095          
    ##   0.9242256  0.9266667         0.9633333         0.9409524          
    ##   0.9659091  0.9666667         0.9833333         0.9738095          
    ##   0.9452862  0.9466667         0.9733333         0.9559524          
    ##   0.9524411  0.9533333         0.9766667         0.9599206          
    ##   0.9393939  0.9400000         0.9700000         0.9472222          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781145            0.9583333       0.9533333    0.3177778          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9853535            0.9738095       0.9666667    0.3222222          
    ##   0.9678788            0.9409524       0.9266667    0.3088889          
    ##   0.9853535            0.9738095       0.9666667    0.3222222          
    ##   0.9760943            0.9559524       0.9466667    0.3155556          
    ##   0.9786195            0.9599206       0.9533333    0.3177778          
    ##   0.9720539            0.9472222       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.500                 
    ##   0.500                 
    ##   0.975                 
    ##   0.945                 
    ##   0.975                 
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 856, max_depth = 4,
    ##  eta = 0.5556354, gamma = 5.340683, colsample_bytree =
    ##  0.4521864, min_child_weight = 4 and subsample = 0.7922793.
    ## 
    ## [[83]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.09206976  10         4.2243853  0.4541813          3              
    ##   0.11198851  10         4.4147238  0.4796879          2              
    ##   0.20282569   7         4.4395848  0.6471912          3              
    ##   0.21034721   1         4.9783199  0.5400968          5              
    ##   0.24533764   4         0.5581937  0.5272064         19              
    ##   0.29121150   6         4.3115777  0.3473085         10              
    ##   0.31908264   5         9.0054663  0.3335191         16              
    ##   0.52322057   2         3.4882961  0.5428025          0              
    ##   0.55675865   7         7.5989179  0.4613484         20              
    ##   0.57996485  10         3.8030698  0.6126855          6              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6935554  471      0.2229986  0.9893333  0.6397328  0.9600000  0.94 
    ##   0.5942913  163      0.2448730  0.9906667  0.6371818  0.9600000  0.94 
    ##   0.4732522  451      0.2507792  0.9926667  0.3133135  0.9466667  0.92 
    ##   0.2611940  185      0.4300671  0.9893333  0.2948995  0.9333333  0.90 
    ##   0.9542316  578      0.4058171  0.9786667  0.4880984  0.9333333  0.90 
    ##   0.9316949  839      0.2310023  0.9840000  0.5452267  0.9600000  0.94 
    ##   0.7397966  681      0.4305628  0.9920000  0.3581389  0.9200000  0.88 
    ##   0.3472747  177      0.2347356  0.9926667  0.3674550  0.9466667  0.92 
    ##   0.3446509  664      1.1021564  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.8190706  391      0.2049596  0.9920000  0.3920913  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9462626  0.9466667         0.9733333         0.9505556          
    ##   0.9329293  0.9333333         0.9666667         0.9400000          
    ##   0.9329293  0.9333333         0.9666667         0.9400000          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9168687  0.9200000         0.9600000         0.9272222          
    ##   0.9463973  0.9466667         0.9733333         0.9511111          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9395286  0.9400000         0.9700000         0.9450000          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9684848            0.9400000       0.9333333    0.3111111          
    ##   0.9684848            0.9400000       0.9333333    0.3111111          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9637374            0.9272222       0.9200000    0.3066667          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.970                 
    ##   0.970                 
    ##   0.960                 
    ##   0.950                 
    ##   0.950                 
    ##   0.970                 
    ##   0.940                 
    ##   0.960                 
    ##   0.500                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 391, max_depth =
    ##  10, eta = 0.5799649, gamma = 3.80307, colsample_bytree =
    ##  0.6126855, min_child_weight = 6 and subsample = 0.8190706.
    ## 
    ## [[84]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02911890   6         7.2396037  0.3928444         19              
    ##   0.04134276   7         0.7513917  0.4451775          1              
    ##   0.06710741   1         6.8279234  0.3754771          0              
    ##   0.11688696   2         4.3346785  0.5488866         20              
    ##   0.14731836   7         3.1083080  0.4070282         13              
    ##   0.23566345   6         7.9694088  0.4572697         11              
    ##   0.37041689   1         9.1038026  0.6393726         14              
    ##   0.37411380  10         6.5937772  0.4868668          8              
    ##   0.37476209   1         0.2522892  0.3215667         17              
    ##   0.52685771   3         2.9123280  0.4692544          5              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.5931709  771      0.2870067  0.9860000  0.7120622  0.9466667  0.92 
    ##   0.7333770  711      0.1838492  0.9860000  0.7731235  0.9466667  0.92 
    ##   0.4229686  937      0.2685509  0.9840000  0.6208439  0.9333333  0.90 
    ##   0.9208558  622      0.2098668  0.9906667  0.4647037  0.9400000  0.91 
    ##   0.4731179  278      0.2497016  0.9926667  0.6748148  0.9333333  0.90 
    ##   0.7666814  514      0.2141175  0.9880000  0.5674696  0.9466667  0.92 
    ##   0.6277230  367      0.2449858  0.9906667  0.2916190  0.9400000  0.91 
    ##   0.2816010  344      0.2630022  0.9886667  0.3706481  0.9533333  0.93 
    ##   0.7984903   19      0.2333134  0.9866667  0.6600741  0.9466667  0.92 
    ##   0.7992996  903      0.1675125  0.9886667  0.6671746  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9444866  0.9466667         0.9733333         0.9575000          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9311533  0.9333333         0.9666667         0.9441667          
    ##   0.9378873  0.9400000         0.9700000         0.9497222          
    ##   0.9311533  0.9333333         0.9666667         0.9441667          
    ##   0.9459764  0.9466667         0.9733333         0.9526984          
    ##   0.9378873  0.9400000         0.9700000         0.9497222          
    ##   0.9512206  0.9533333         0.9766667         0.9630556          
    ##   0.9444866  0.9466667         0.9733333         0.9575000          
    ##   0.9391077  0.9400000         0.9700000         0.9493651          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9765501            0.9575000       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9698834            0.9441667       0.9333333    0.3111111          
    ##   0.9729138            0.9497222       0.9400000    0.3133333          
    ##   0.9698834            0.9441667       0.9333333    0.3111111          
    ##   0.9750505            0.9526984       0.9466667    0.3155556          
    ##   0.9729138            0.9497222       0.9400000    0.3133333          
    ##   0.9795804            0.9630556       0.9533333    0.3177778          
    ##   0.9765501            0.9575000       0.9466667    0.3155556          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.950                 
    ##   0.955                 
    ##   0.950                 
    ##   0.960                 
    ##   0.955                 
    ##   0.965                 
    ##   0.960                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 903, max_depth = 3,
    ##  eta = 0.5268577, gamma = 2.912328, colsample_bytree =
    ##  0.4692544, min_child_weight = 5 and subsample = 0.7992996.
    ## 
    ## [[85]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.0898580   8         4.2481557  0.6433436         11              
    ##   0.1166365   2         2.7533052  0.5964268         14              
    ##   0.2011355   7         9.0182556  0.3947872         16              
    ##   0.2896607   8         1.9663227  0.6157423         13              
    ##   0.3208312   9         2.7031741  0.3334794          7              
    ##   0.3419759   8         1.5981913  0.3588715          7              
    ##   0.3529619   4         0.8863992  0.6286353          2              
    ##   0.3616790   9         3.7397052  0.4716542         15              
    ##   0.3692793   6         5.4284910  0.6234242         16              
    ##   0.5340401  10         1.2666568  0.3056820          0              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.7666666  538      0.2705920  0.9893333  0.4872222  0.9600000  0.94 
    ##   0.7624970  498      0.3460625  0.9886667  0.5260000  0.9533333  0.93 
    ##   0.6493999  734      0.5110511  0.9786667  0.4648214  0.9000000  0.85 
    ##   0.3319070  968      0.8567986  0.8820000  0.2989531  0.7466667  0.62 
    ##   0.9400817  859      0.2071644  0.9893333  0.6265613  0.9600000  0.94 
    ##   0.9121103  788      0.2087577  0.9860000  0.6214921  0.9466667  0.92 
    ##   0.7008902  261      0.1716478  0.9906667  0.5540598  0.9533333  0.93 
    ##   0.9972253  985      0.3060328  0.9846667  0.5336619  0.9333333  0.90 
    ##   0.6742486  284      0.4750298  0.9686667  0.4732976  0.9133333  0.87 
    ##   0.8129723  497      0.1660508  0.9900000  0.6751111  0.9666667  0.95 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.8951756  0.9000000         0.9500000         0.9165079          
    ##   0.7353644  0.7466667         0.8733333         0.8149636          
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.9461279  0.9466667         0.9733333         0.9555556          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.9323737  0.9333333         0.9666667         0.9438095          
    ##   0.9107407  0.9133333         0.9566667         0.9255556          
    ##   0.9663300  0.9666667         0.9833333         0.9722222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9560451            0.9165079       0.9000000    0.3000000          
    ##   0.9034776            0.8149636       0.7466667    0.2488889          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9757576            0.9555556       0.9466667    0.3155556          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9610101            0.9255556       0.9133333    0.3044444          
    ##   0.9848485            0.9722222       0.9666667    0.3222222          
    ##   Mean_Balanced_Accuracy
    ##   0.970                 
    ##   0.965                 
    ##   0.925                 
    ##   0.810                 
    ##   0.970                 
    ##   0.960                 
    ##   0.965                 
    ##   0.950                 
    ##   0.935                 
    ##   0.975                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 497, max_depth =
    ##  10, eta = 0.5340401, gamma = 1.266657, colsample_bytree =
    ##  0.305682, min_child_weight = 0 and subsample = 0.8129723.
    ## 
    ## [[86]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.04127460   7         4.439470  0.6539961          1              
    ##   0.07036760   2         3.466033  0.4360968         14              
    ##   0.07522631   5         1.777239  0.4482443         15              
    ##   0.08756956   9         8.762193  0.6132994         17              
    ##   0.09345269   3         4.684225  0.3181939          7              
    ##   0.11511415   5         5.480428  0.5371404          7              
    ##   0.14617628   7         3.410177  0.5981696         18              
    ##   0.16705043   3         5.373987  0.4661775         12              
    ##   0.27234896  10         1.012380  0.3871026         17              
    ##   0.36236869   1         3.235187  0.3956206         13              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.8252415  931      0.2196169  0.9880000  0.5773936  0.9533333  0.93 
    ##   0.8789530  913      0.3090693  0.9893333  0.6356474  0.9333333  0.90 
    ##   0.9339287  639      0.3279687  0.9833333  0.6066714  0.9333333  0.90 
    ##   0.5008285  987      0.8205034  0.9353333  0.3377302  0.8066667  0.71 
    ##   0.8651732  291      0.2299387  0.9880000  0.6467328  0.9466667  0.92 
    ##   0.8680104  564      0.2389894  0.9900000  0.3672884  0.9466667  0.92 
    ##   0.7702796  357      0.4821382  0.9820000  0.5214761  0.9066667  0.86 
    ##   0.9992501  370      0.2709127  0.9886667  0.5647665  0.9466667  0.92 
    ##   0.6648086  384      0.5328704  0.9413333  0.4737769  0.8733333  0.81 
    ##   0.9701819  111      0.2836838  0.9846667  0.5578730  0.9600000  0.94 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9529966  0.9533333         0.9766667         0.9561111          
    ##   0.9325084  0.9333333         0.9666667         0.9415873          
    ##   0.9326431  0.9333333         0.9666667         0.9393651          
    ##   0.8233047  0.8066667         0.9033333         0.8816468          
    ##   0.9463973  0.9466667         0.9733333         0.9511111          
    ##   0.9462626  0.9466667         0.9733333         0.9505556          
    ##   0.9018422  0.9066667         0.9533333         0.9231746          
    ##   0.9459764  0.9466667         0.9733333         0.9526984          
    ##   0.8716835  0.8733333         0.9366667         0.8811111          
    ##   0.9598653  0.9600000         0.9800000         0.9622222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9689899            0.9415873       0.9333333    0.3111111          
    ##   0.9683838            0.9393651       0.9333333    0.3111111          
    ##   0.9268942            0.8816468       0.8066667    0.2688889          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9593784            0.9231746       0.9066667    0.3022222          
    ##   0.9750505            0.9526984       0.9466667    0.3155556          
    ##   0.9391246            0.8811111       0.8733333    0.2911111          
    ##   0.9806061            0.9622222       0.9600000    0.3200000          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.950                 
    ##   0.950                 
    ##   0.855                 
    ##   0.960                 
    ##   0.960                 
    ##   0.930                 
    ##   0.960                 
    ##   0.905                 
    ##   0.970                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 931, max_depth = 7,
    ##  eta = 0.0412746, gamma = 4.43947, colsample_bytree =
    ##  0.6539961, min_child_weight = 1 and subsample = 0.8252415.
    ## 
    ## [[87]]
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.03923191   8         9.6250708  0.4203633          7              
    ##   0.12293551   4         4.2172459  0.5109532         12              
    ##   0.13985444   2         0.5026075  0.6374669         13              
    ##   0.28629005   9         4.3082141  0.5106771         10              
    ##   0.28783528   1         4.1678688  0.6336721         12              
    ##   0.29819855   2         5.7174305  0.4080101          2              
    ##   0.30641575  10         9.1512541  0.5101237         13              
    ##   0.32042545   3         0.2623759  0.6236555         19              
    ##   0.45654171   5         7.1199343  0.3363374         12              
    ##   0.58880982   3         6.1210720  0.4588169         17              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.8390924  938      0.2301019  0.9880000  0.6635851  0.9466667  0.92 
    ##   0.2686116  113      0.3590800  0.9920000  0.6387579  0.9533333  0.93 
    ##   0.5219491  355      0.2204612  0.9873333  0.6150375  0.9400000  0.91 
    ##   0.8058500  243      0.1660118  0.9906667  0.4810455  0.9400000  0.91 
    ##   0.4581204  802      0.2251422  0.9920000  0.5511772  0.9533333  0.93 
    ##   0.5238490  832      0.1931741  0.9893333  0.6162778  0.9400000  0.91 
    ##   0.6402174  271      0.2289511  0.9873333  0.3351825  0.9333333  0.90 
    ##   0.7468125  690      0.2250932  0.9886667  0.5599696  0.9400000  0.91 
    ##   0.8616268  118      0.1920260  0.9913333  0.5499550  0.9333333  0.90 
    ##   0.2700685  477      0.5201090  0.9653333  0.3612400  0.8800000  0.82 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9529966  0.9533333         0.9766667         0.9588889          
    ##   0.9396633  0.9400000         0.9700000         0.9455556          
    ##   0.9392424  0.9400000         0.9700000         0.9471429          
    ##   0.9520202  0.9533333         0.9766667         0.9579365          
    ##   0.9396633  0.9400000         0.9700000         0.9455556          
    ##   0.9326431  0.9333333         0.9666667         0.9393651          
    ##   0.9386869  0.9400000         0.9700000         0.9446032          
    ##   0.9308839  0.9333333         0.9666667         0.9458333          
    ##   0.8749904  0.8800000         0.9400000         0.9013492          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9720202            0.9471429       0.9400000    0.3133333          
    ##   0.9784091            0.9579365       0.9533333    0.3177778          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9683838            0.9393651       0.9333333    0.3111111          
    ##   0.9717424            0.9446032       0.9400000    0.3133333          
    ##   0.9704222            0.9458333       0.9333333    0.3111111          
    ##   0.9470888            0.9013492       0.8800000    0.2933333          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.955                 
    ##   0.965                 
    ##   0.955                 
    ##   0.950                 
    ##   0.955                 
    ##   0.950                 
    ##   0.910                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 243, max_depth = 9,
    ##  eta = 0.2862901, gamma = 4.308214, colsample_bytree =
    ##  0.5106771, min_child_weight = 10 and subsample = 0.80585.
    ## 
    ## [[88]]
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9600000  0.94 
    ##    2    0.9466667  0.92 
    ##    3    0.9533333  0.93 
    ##    4    0.9466667  0.92 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.

Then you would notice that there is no meaningful information about what each model is. We should use the r assing\_model\_names function in the automl packages to give models names based on its names based on method, metric, preProcess and sampling methods.

``` r
iris_list = assign_model_names(iris_list) 
```

Try visualizing the models again.

``` r
ml_bwplot(iris_list)
```

    ## Warning in resamples.default(.): Some performance measures were
    ## not computed for each model: AUC, logLoss, Mean_Balanced_Accuracy,
    ## Mean_Detection_Rate, Mean_F1, Mean_Neg_Pred_Value, Mean_Pos_Pred_Value,
    ## Mean_Precision, Mean_Recall, Mean_Sensitivity, Mean_Specificity, prAUC

![](README_with_results_files/figure-markdown_github/unnamed-chunk-7-1.png)

    ## $`1_LogitBoost_down_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    3     0.3352184  0.9643333  0.2860532  0.9447619  0.9164196  0.9403920
    ##   10     0.2684269  0.9746667  0.4842227  0.9457143  0.9182946  0.9431698
    ##   14     0.2652790  0.9753333  0.5611447  0.9333333  0.9000000  0.9313973
    ##   22     0.3086473  0.9786667  0.6555666  0.9457143  0.9182946  0.9435907
    ##   34     0.5303002  0.9706667  0.6589441  0.9400000  0.9100000  0.9385522
    ##   42     0.7066009  0.9650000  0.6608264  0.9390476  0.9082946  0.9364358
    ##   45     0.6993804  0.9746667  0.6800804  0.9461905  0.9191473  0.9446489
    ##   74     1.0635595  0.9710000  0.6880024  0.9395238  0.9091473  0.9374940
    ##   78     1.1109784  0.9710000  0.6946691  0.9400000  0.9100000  0.9385522
    ##   84     1.1116338  0.9723333  0.7035620  0.9400000  0.9100000  0.9385522
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9718519         0.9587302          
    ##   0.9433333         0.9725926         0.9587302          
    ##   0.9333333         0.9666667         0.9492063          
    ##   0.9433333         0.9725926         0.9571429          
    ##   0.9400000         0.9700000         0.9531746          
    ##   0.9366667         0.9692593         0.9531746          
    ##   0.9450000         0.9729630         0.9571429          
    ##   0.9383333         0.9696296         0.9531746          
    ##   0.9400000         0.9700000         0.9531746          
    ##   0.9400000         0.9700000         0.9531746          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9767677            0.9587302       0.9400000    0.3149206          
    ##   0.9767677            0.9587302       0.9433333    0.3152381          
    ##   0.9712121            0.9492063       0.9333333    0.3111111          
    ##   0.9762626            0.9571429       0.9433333    0.3152381          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.9737374            0.9531746       0.9366667    0.3130159          
    ##   0.9762626            0.9571429       0.9450000    0.3153968          
    ##   0.9737374            0.9531746       0.9383333    0.3131746          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.9559259             
    ##   0.9579630             
    ##   0.9500000             
    ##   0.9579630             
    ##   0.9550000             
    ##   0.9529630             
    ##   0.9589815             
    ##   0.9539815             
    ##   0.9550000             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 14.
    ## 
    ## $`2_LogitBoost_smote_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    2     0.3946975  0.9740000  0.2337500  0.9548718  0.9298148  0.9447811
    ##    8     0.2113433  0.9846667  0.4177937  0.9328571  0.8993130  0.9321212
    ##    9     0.1765634  0.9860000  0.4597116  0.9457143  0.9186260  0.9447811
    ##   12     0.2147832  0.9840000  0.4859550  0.9466667  0.9200000  0.9462626
    ##   17     0.2419652  0.9720000  0.5315124  0.9514286  0.9270875  0.9499832
    ##   36     0.4408927  0.9706667  0.6043034  0.9466667  0.9200000  0.9463973
    ##   52     0.6942436  0.9656667  0.6596402  0.9333333  0.9000000  0.9327946
    ##   54     0.7073603  0.9630000  0.6557228  0.9333333  0.9000000  0.9327946
    ##   64     0.8324383  0.9673333  0.6546778  0.9333333  0.9000000  0.9327946
    ##   90     1.0773647  0.9703333  0.6553510  0.9333333  0.9000000  0.9327946
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9422222         0.9766667         0.9555556          
    ##   0.9333333         0.9666667         0.9383333          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9516667         0.9762963         0.9550000          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9333333         0.9666667         0.9394444          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9800866            0.9555556       0.9422222    0.3182906          
    ##   0.9681145            0.9383333       0.9333333    0.3109524          
    ##   0.9744781            0.9505556       0.9466667    0.3152381          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9772054            0.9550000       0.9516667    0.3171429          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   Mean_Balanced_Accuracy
    ##   0.9594444             
    ##   0.9500000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9639815             
    ##   0.9600000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 9.
    ## 
    ## $`3_LogitBoost_up_center_scale_ignore_Accuracy`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##     6    0.9533333  0.9300000
    ##    20    0.9333333  0.9000000
    ##    21    0.9333333  0.9000000
    ##    30    0.9333333  0.9000000
    ##    33    0.9266667  0.8900000
    ##    44    0.9333333  0.9000000
    ##    52    0.9333333  0.9000000
    ##    57    0.9328571  0.8993130
    ##    77    0.9328571  0.8991473
    ##   100    0.9385714  0.9077745
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## $`4_LogitBoost_down_center_scale_ignore_Accuracy`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    3     0.9384982  0.9072759
    ##   10     0.9466667  0.9200000
    ##   19     0.9466667  0.9200000
    ##   25     0.9466667  0.9200000
    ##   57     0.9466667  0.9200000
    ##   58     0.9466667  0.9200000
    ##   75     0.9400000  0.9100000
    ##   87     0.9400000  0.9100000
    ##   90     0.9400000  0.9100000
    ##   91     0.9400000  0.9100000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 10.
    ## 
    ## $`5_LogitBoost_smote_center_scale_ignore_Accuracy`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##     6    0.9452381  0.9177745
    ##     7    0.9390476  0.9084615
    ##    17    0.9533333  0.9300000
    ##    20    0.9466667  0.9200000
    ##    40    0.9452381  0.9177745
    ##    50    0.9442857  0.9162348
    ##    51    0.9390476  0.9084603
    ##    53    0.9452381  0.9177745
    ##    61    0.9452381  0.9177745
    ##   100    0.9333333  0.9000000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 17.
    ## 
    ## $`6_LogitBoost_up_center_scale_ignore_Kappa`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa   
    ##   12     0.9600000  0.940000
    ##   19     0.9523077  0.927963
    ##   26     0.9457143  0.918125
    ##   32     0.9333333  0.900000
    ##   49     0.9333333  0.900000
    ##   73     0.9333333  0.900000
    ##   81     0.9266667  0.890000
    ##   82     0.9266667  0.890000
    ##   89     0.9333333  0.900000
    ##   96     0.9323810  0.898125
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 12.
    ## 
    ## $`7_LogitBoost_smote_center_scale_ignore_Kappa`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    2     0.9419963  0.9108651
    ##   18     0.9533333  0.9300000
    ##   30     0.9533333  0.9300000
    ##   35     0.9533333  0.9300000
    ##   40     0.9533333  0.9300000
    ##   45     0.9533333  0.9300000
    ##   47     0.9533333  0.9300000
    ##   48     0.9533333  0.9300000
    ##   58     0.9533333  0.9300000
    ##   61     0.9528571  0.9291473
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 18.
    ## 
    ## $`8_LogitBoost_up_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   19     0.2182044  0.9820000  0.6232969  0.9461905  0.9193130  0.9455892
    ##   26     0.2875129  0.9800000  0.6775926  0.9457143  0.9184615  0.9448653
    ##   29     0.3337741  0.9793333  0.6973307  0.9400000  0.9100000  0.9396633
    ##   39     0.4125892  0.9773333  0.7053704  0.9333333  0.9000000  0.9330640
    ##   44     0.5233674  0.9733333  0.7012902  0.9266667  0.8900000  0.9263300
    ##   56     0.6292771  0.9706667  0.7272963  0.9266667  0.8900000  0.9263300
    ##   67     0.7381259  0.9716667  0.7122963  0.9200000  0.8800000  0.9195960
    ##   73     0.7421799  0.9723333  0.7040362  0.9266667  0.8900000  0.9263300
    ##   97     0.9649257  0.9723333  0.6100362  0.9266667  0.8900000  0.9263300
    ##   98     1.0235940  0.9703333  0.6692479  0.9266667  0.8900000  0.9263300
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9494444          
    ##   0.9450000         0.9729630         0.9472222          
    ##   0.9400000         0.9700000         0.9427778          
    ##   0.9333333         0.9666667         0.9350000          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9200000         0.9600000         0.9238889          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9266667         0.9633333         0.9294444          
    ##   0.9266667         0.9633333         0.9294444          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9741751            0.9494444       0.9466667    0.3153968          
    ##   0.9735690            0.9472222       0.9450000    0.3152381          
    ##   0.9708418            0.9427778       0.9400000    0.3133333          
    ##   0.9672054            0.9350000       0.9333333    0.3111111          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9611448            0.9238889       0.9200000    0.3066667          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   0.9641751            0.9294444       0.9266667    0.3088889          
    ##   Mean_Balanced_Accuracy
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9500000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9400000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9450000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 19.
    ## 
    ## $`9_LogitBoost_down_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    7     0.2353778  0.9856667  0.3653439  0.9461905  0.9191473  0.9452044
    ##   21     0.2478021  0.9846667  0.6225852  0.9400000  0.9100000  0.9391077
    ##   24     0.3022456  0.9820000  0.6384450  0.9466667  0.9200000  0.9458418
    ##   27     0.3310015  0.9820000  0.6473828  0.9400000  0.9100000  0.9391077
    ##   30     0.3879973  0.9726667  0.6683508  0.9466667  0.9200000  0.9458418
    ##   35     0.4995667  0.9760000  0.6712019  0.9466667  0.9200000  0.9458418
    ##   63     0.8120911  0.9726667  0.6355481  0.9333333  0.9000000  0.9310186
    ##   75     1.0228167  0.9713333  0.6251754  0.9333333  0.9000000  0.9310186
    ##   88     1.1516888  0.9726667  0.5944016  0.9333333  0.9000000  0.9310186
    ##   98     1.2745900  0.9713333  0.5914677  0.9333333  0.9000000  0.9310186
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9450000         0.9729630         0.9533333          
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9333333         0.9666667         0.9463889          
    ##   0.9333333         0.9666667         0.9463889          
    ##   0.9333333         0.9666667         0.9463889          
    ##   0.9333333         0.9666667         0.9463889          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9450000    0.3153968          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   0.9704895            0.9463889       0.9333333    0.3111111          
    ##   Mean_Balanced_Accuracy
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9600000             
    ##   0.9550000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 7.
    ## 
    ## $`10_LogitBoost_smote_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    7     0.1774257  0.9886667  0.3935952  0.9595238  0.9391473  0.9567618
    ##   13     0.2293104  0.9906667  0.5433016  0.9528571  0.9291473  0.9500278
    ##   16     0.2831730  0.9873333  0.5679661  0.9533333  0.9300000  0.9510860
    ##   51     0.7244054  0.9800000  0.6750275  0.9400000  0.9100000  0.9367762
    ##   54     0.7653373  0.9806667  0.6893011  0.9400000  0.9100000  0.9367762
    ##   70     0.9084932  0.9886667  0.7020728  0.9400000  0.9100000  0.9367762
    ##   72     0.9429589  0.9820000  0.6780969  0.9400000  0.9100000  0.9367762
    ##   76     0.9555947  0.9776667  0.6528263  0.9400000  0.9100000  0.9367762
    ##   90     1.0534377  0.9756667  0.6633801  0.9400000  0.9100000  0.9367762
    ##   94     1.0738390  0.9743333  0.6603588  0.9461905  0.9191473  0.9428729
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9583333         0.9796296         0.9708333          
    ##   0.9516667         0.9762963         0.9652778          
    ##   0.9533333         0.9766667         0.9652778          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9400000         0.9700000         0.9573413          
    ##   0.9450000         0.9729630         0.9613095          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9832168            0.9708333       0.9583333    0.3198413          
    ##   0.9801865            0.9652778       0.9516667    0.3176190          
    ##   0.9801865            0.9652778       0.9533333    0.3177778          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9751360            0.9573413       0.9400000    0.3133333          
    ##   0.9776612            0.9613095       0.9450000    0.3153968          
    ##   Mean_Balanced_Accuracy
    ##   0.9689815             
    ##   0.9639815             
    ##   0.9650000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9589815             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 7.
    ## 
    ## $`11_rf_up_center_scale_ignore_Kappa`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9400000  0.91 
    ##    2    0.9466667  0.92 
    ##    3    0.9333333  0.90 
    ##    4    0.9400000  0.91 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`12_LogitBoost_up_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    5     0.2689410  0.9773333  0.3486349  0.9461905  0.9191473  0.9443627
    ##   20     0.3321563  0.9700000  0.5955455  0.9447619  0.9165891  0.9420298
    ##   22     0.3696460  0.9686667  0.6022360  0.9452381  0.9174419  0.9430880
    ##   50     0.7416837  0.9673333  0.7097756  0.9400000  0.9100000  0.9395286
    ##   60     0.8538661  0.9686667  0.7166194  0.9385714  0.9074419  0.9363540
    ##   65     0.8694841  0.9720000  0.7323920  0.9400000  0.9100000  0.9395286
    ##   80     1.0278368  0.9750000  0.6893108  0.9385714  0.9074419  0.9363540
    ##   91     1.1412967  0.9760000  0.6254405  0.9385714  0.9074419  0.9363540
    ##   92     1.0986420  0.9763333  0.6710886  0.9400000  0.9100000  0.9395286
    ##   94     1.1611194  0.9750000  0.6761442  0.9385714  0.9074419  0.9363540
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9450000         0.9729630         0.9501587          
    ##   0.9416667         0.9722222         0.9477778          
    ##   0.9433333         0.9725926         0.9477778          
    ##   0.9400000         0.9700000         0.9450000          
    ##   0.9366667         0.9692593         0.9422222          
    ##   0.9400000         0.9700000         0.9450000          
    ##   0.9366667         0.9692593         0.9422222          
    ##   0.9366667         0.9692593         0.9422222          
    ##   0.9400000         0.9700000         0.9450000          
    ##   0.9366667         0.9692593         0.9422222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9747727            0.9501587       0.9450000    0.3153968          
    ##   0.9740152            0.9477778       0.9416667    0.3149206          
    ##   0.9740152            0.9477778       0.9433333    0.3150794          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   0.9709848            0.9422222       0.9366667    0.3128571          
    ##   Mean_Balanced_Accuracy
    ##   0.9589815             
    ##   0.9569444             
    ##   0.9579630             
    ##   0.9550000             
    ##   0.9529630             
    ##   0.9550000             
    ##   0.9529630             
    ##   0.9529630             
    ##   0.9550000             
    ##   0.9529630             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 5.
    ## 
    ## $`13_LogitBoost_down_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    9     0.1960401  0.9900000  0.4728690  0.9390476  0.9081250  0.9361953
    ##   19     0.2862639  0.9740000  0.6409881  0.9466667  0.9200000  0.9457071
    ##   37     0.4559892  0.9693333  0.6949567  0.9461905  0.9191473  0.9446489
    ##   42     0.4873048  0.9693333  0.7157900  0.9466667  0.9200000  0.9457071
    ##   51     0.6226899  0.9666667  0.7186074  0.9466667  0.9200000  0.9457071
    ##   55     0.6772778  0.9670000  0.7112759  0.9466667  0.9200000  0.9457071
    ##   56     0.6616503  0.9696667  0.7217658  0.9466667  0.9200000  0.9457071
    ##   59     0.7135012  0.9666667  0.6955393  0.9466667  0.9200000  0.9457071
    ##   76     0.9209786  0.9650000  0.6994643  0.9461905  0.9191473  0.9446489
    ##   93     1.0768694  0.9710000  0.5662133  0.9400000  0.9100000  0.9385522
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9366667         0.9692593         0.9488095          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9450000         0.9729630         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9450000         0.9729630         0.9543651          
    ##   0.9400000         0.9700000         0.9503968          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9725589            0.9488095       0.9366667    0.3130159          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9450000    0.3153968          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9755892            0.9543651       0.9450000    0.3153968          
    ##   0.9730640            0.9503968       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.9529630             
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 9.
    ## 
    ## $`14_LogitBoost_smote_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   10     0.1520599  0.9926667  0.5189074  0.9523810  0.9284603  0.9512650
    ##   17     0.1565226  0.9893333  0.6210622  0.9528571  0.9293130  0.9523232
    ##   26     0.2802461  0.9780000  0.6349497  0.9533333  0.9300000  0.9529966
    ##   35     0.2906773  0.9806667  0.6576513  0.9528571  0.9293130  0.9523232
    ##   52     0.4635829  0.9740000  0.6707561  0.9466667  0.9200000  0.9463973
    ##   54     0.4932399  0.9760000  0.6754008  0.9466667  0.9200000  0.9463973
    ##   58     0.4843326  0.9746667  0.6589227  0.9528571  0.9293130  0.9523232
    ##   68     0.5582325  0.9736667  0.6503976  0.9466667  0.9200000  0.9463973
    ##   72     0.6004874  0.9760000  0.6730952  0.9466667  0.9200000  0.9463973
    ##   78     0.6584321  0.9750000  0.6459884  0.9466667  0.9200000  0.9463973
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9516667         0.9762963         0.9577778          
    ##   0.9533333         0.9766667         0.9577778          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9577778          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9533333         0.9766667         0.9577778          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9466667         0.9733333         0.9511111          
    ##   0.9466667         0.9733333         0.9511111          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9778788            0.9577778       0.9516667    0.3174603          
    ##   0.9778788            0.9577778       0.9533333    0.3176190          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9778788            0.9577778       0.9533333    0.3176190          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9778788            0.9577778       0.9533333    0.3176190          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.9639815             
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9650000             
    ##   0.9600000             
    ##   0.9600000             
    ##   0.9600000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 10.
    ## 
    ## $`15_LogitBoost_up_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa     Mean_F1  
    ##   10     0.2390373  0.9766667  0.5103746  0.9400000  0.910000  0.9385522
    ##   40     0.5151878  0.9736667  0.6986151  0.9400000  0.910000  0.9389731
    ##   46     0.6316926  0.9713333  0.6983558  0.9395238  0.909313  0.9382997
    ##   48     0.6236132  0.9713333  0.6916336  0.9400000  0.910000  0.9389731
    ##   56     0.6984395  0.9720000  0.7030992  0.9466667  0.920000  0.9457071
    ##   58     0.7115657  0.9720000  0.7097659  0.9466667  0.920000  0.9457071
    ##   71     0.9203462  0.9670000  0.6617183  0.9400000  0.910000  0.9389731
    ##   88     1.0849187  0.9656667  0.6569339  0.9466667  0.920000  0.9457071
    ##   90     1.1098588  0.9636667  0.6553122  0.9466667  0.920000  0.9457071
    ##   97     1.1468845  0.9650000  0.5846561  0.9466667  0.920000  0.9457071
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9531746          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9400000         0.9700000         0.9504762          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9466667         0.9733333         0.9571429          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9729293            0.9504762       0.9400000    0.3131746          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.960                 
    ##   0.960                 
    ##   0.955                 
    ##   0.960                 
    ##   0.960                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 10.
    ## 
    ## $`16_LogitBoost_down_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    6     0.2236553  0.9813333  0.4254939  0.9533333  0.9300000  0.9529966
    ##   14     0.2398600  0.9753333  0.5743635  0.9533333  0.9300000  0.9529966
    ##   23     0.3792280  0.9653333  0.6164975  0.9533333  0.9300000  0.9529966
    ##   53     0.8893873  0.9613333  0.6699499  0.9447619  0.9170862  0.9431842
    ##   58     0.9565556  0.9606667  0.6816767  0.9447619  0.9170862  0.9431842
    ##   65     1.0151079  0.9616667  0.6833831  0.9466667  0.9200000  0.9462626
    ##   74     1.1668342  0.9603333  0.6990797  0.9461905  0.9191473  0.9452044
    ##   78     1.1917924  0.9580000  0.6966486  0.9461905  0.9191473  0.9452044
    ##   85     1.2688470  0.9583333  0.6282042  0.9400000  0.9100000  0.9391077
    ##   93     1.3587910  0.9596667  0.6232481  0.9461905  0.9191473  0.9452044
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9561111          
    ##   0.9533333         0.9766667         0.9561111          
    ##   0.9533333         0.9766667         0.9561111          
    ##   0.9433333         0.9725926         0.9483333          
    ##   0.9433333         0.9725926         0.9483333          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9450000         0.9729630         0.9505556          
    ##   0.9450000         0.9729630         0.9505556          
    ##   0.9400000         0.9700000         0.9465873          
    ##   0.9450000         0.9729630         0.9505556          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9738721            0.9483333       0.9433333    0.3149206          
    ##   0.9738721            0.9483333       0.9433333    0.3149206          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9450000    0.3153968          
    ##   0.9744781            0.9505556       0.9450000    0.3153968          
    ##   0.9719529            0.9465873       0.9400000    0.3133333          
    ##   0.9744781            0.9505556       0.9450000    0.3153968          
    ##   Mean_Balanced_Accuracy
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9650000             
    ##   0.9579630             
    ##   0.9579630             
    ##   0.9600000             
    ##   0.9589815             
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9589815             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## $`17_LogitBoost_smote_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   14     0.1813388  0.9886667  0.6065370  0.9533333  0.9300000  0.9528620
    ##   15     0.1824237  0.9900000  0.6223836  0.9590476  0.9384615  0.9580640
    ##   35     0.3433115  0.9833333  0.6838466  0.9400000  0.9100000  0.9395286
    ##   39     0.3650385  0.9806667  0.6711074  0.9457143  0.9184615  0.9447306
    ##   47     0.4312681  0.9780000  0.6678514  0.9457143  0.9184615  0.9447306
    ##   58     0.5685432  0.9813333  0.6627797  0.9395238  0.9091473  0.9384704
    ##   67     0.6897191  0.9783333  0.5917707  0.9333333  0.9000000  0.9323737
    ##   92     0.8564847  0.9736667  0.6276220  0.9333333  0.9000000  0.9323737
    ##   95     0.8787314  0.9730000  0.5404858  0.9333333  0.9000000  0.9323737
    ##   97     0.9386153  0.9723333  0.5417146  0.9333333  0.9000000  0.9323737
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9555556          
    ##   0.9583333         0.9796296         0.9600000          
    ##   0.9400000         0.9700000         0.9422222          
    ##   0.9450000         0.9729630         0.9466667          
    ##   0.9450000         0.9729630         0.9466667          
    ##   0.9383333         0.9696296         0.9422222          
    ##   0.9333333         0.9666667         0.9382540          
    ##   0.9333333         0.9666667         0.9382540          
    ##   0.9333333         0.9666667         0.9382540          
    ##   0.9333333         0.9666667         0.9382540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9774411            0.9555556       0.9533333    0.3177778          
    ##   0.9801684            0.9600000       0.9583333    0.3196825          
    ##   0.9707744            0.9422222       0.9400000    0.3133333          
    ##   0.9735017            0.9466667       0.9450000    0.3152381          
    ##   0.9735017            0.9466667       0.9450000    0.3152381          
    ##   0.9707744            0.9422222       0.9383333    0.3131746          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   0.9682492            0.9382540       0.9333333    0.3111111          
    ##   Mean_Balanced_Accuracy
    ##   0.9650000             
    ##   0.9689815             
    ##   0.9550000             
    ##   0.9589815             
    ##   0.9589815             
    ##   0.9539815             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 14.
    ## 
    ## $`18_rf_down_center_scale_ignore_Kappa`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9600000  0.94 
    ##    4    0.9600000  0.94 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`19_LogitBoost_up_center_scale_ignore_Accuracy`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    5     0.9512821  0.9263558
    ##    9     0.9447619  0.9169129
    ##   29     0.9466667  0.9200000
    ##   38     0.9533333  0.9300000
    ##   40     0.9533333  0.9300000
    ##   44     0.9533333  0.9300000
    ##   51     0.9533333  0.9300000
    ##   64     0.9528571  0.9293130
    ##   90     0.9533333  0.9300000
    ##   96     0.9528571  0.9291473
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 38.
    ## 
    ## $`20_LogitBoost_down_center_scale_ignore_Accuracy`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    6     0.9439744  0.9155502
    ##   14     0.9425641  0.9133604
    ##   16     0.9502564  0.9253748
    ##   17     0.9389744  0.9081818
    ##   28     0.9256410  0.8881818
    ##   44     0.9195238  0.8791473
    ##   47     0.9195238  0.8791473
    ##   80     0.9195238  0.8791473
    ##   86     0.9261905  0.8891473
    ##   91     0.9266667  0.8900000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 16.
    ## 
    ## $`21_LogitBoost_smote_center_scale_ignore_Accuracy`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    5     0.9451648  0.9175401
    ##    6     0.9523077  0.9283929
    ##   19     0.9266667  0.8900000
    ##   23     0.9457143  0.9187879
    ##   27     0.9457143  0.9187879
    ##   30     0.9400000  0.9100000
    ##   40     0.9457143  0.9182946
    ##   45     0.9384982  0.9075401
    ##   58     0.9328571  0.8991473
    ##   95     0.9200000  0.8800000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## $`22_LogitBoost_up_center_scale_ignore_Kappa`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##    3     0.9446886  0.9168531
    ##    7     0.9400000  0.9100000
    ##   11     0.9461905  0.9191473
    ##   29     0.9466667  0.9200000
    ##   31     0.9466667  0.9200000
    ##   69     0.9400000  0.9100000
    ##   82     0.9400000  0.9100000
    ##   84     0.9400000  0.9100000
    ##   94     0.9400000  0.9100000
    ##   97     0.9400000  0.9100000
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 29.
    ## 
    ## $`23_LogitBoost_down_center_scale_ignore_Kappa`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##     2    0.9435897  0.9149675
    ##    10    0.9400000  0.9100000
    ##    11    0.9400000  0.9100000
    ##    27    0.9528571  0.9293130
    ##    28    0.9461905  0.9193130
    ##    31    0.9461905  0.9193130
    ##    66    0.9333333  0.9000000
    ##    74    0.9400000  0.9100000
    ##    92    0.9461905  0.9193130
    ##   100    0.9333333  0.9000000
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 27.
    ## 
    ## $`24_LogitBoost_smote_center_scale_ignore_Kappa`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  Accuracy   Kappa    
    ##   10     0.9461905  0.9193130
    ##   15     0.9461905  0.9191473
    ##   33     0.9466667  0.9200000
    ##   42     0.9395238  0.9093130
    ##   53     0.9333333  0.9000000
    ##   59     0.9333333  0.9000000
    ##   60     0.9328571  0.8991473
    ##   68     0.9333333  0.9000000
    ##   85     0.9333333  0.9000000
    ##   93     0.9333333  0.9000000
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was nIter = 33.
    ## 
    ## $`25_LogitBoost_up_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    6     0.2287970  0.9793333  0.4158290  0.9528571  0.9293130  0.9517677
    ##    9     0.1875224  0.9873333  0.4814199  0.9461905  0.9191473  0.9446489
    ##   14     0.2065621  0.9826667  0.5948366  0.9333333  0.9000000  0.9323737
    ##   22     0.2536365  0.9806667  0.6446341  0.9395238  0.9093130  0.9382997
    ##   50     0.5737994  0.9766667  0.6743968  0.9333333  0.9000000  0.9323737
    ##   51     0.6382952  0.9730000  0.6646524  0.9333333  0.9000000  0.9323737
    ##   65     0.7420538  0.9730000  0.6706720  0.9333333  0.9000000  0.9323737
    ##   75     0.8318287  0.9690000  0.6079934  0.9328571  0.8991473  0.9313155
    ##   87     0.8894616  0.9726667  0.5634008  0.9400000  0.9100000  0.9391077
    ##   99     0.8887503  0.9720000  0.5155574  0.9400000  0.9100000  0.9391077
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9615873          
    ##   0.9450000         0.9729630         0.9571429          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9400000         0.9700000         0.9504762          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9316667         0.9662963         0.9438095          
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9400000         0.9700000         0.9493651          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9789899            0.9615873       0.9533333    0.3176190          
    ##   0.9762626            0.9571429       0.9450000    0.3153968          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9729293            0.9504762       0.9400000    0.3131746          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9695960            0.9438095       0.9316667    0.3109524          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.9650000             
    ##   0.9589815             
    ##   0.9500000             
    ##   0.9550000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9500000             
    ##   0.9489815             
    ##   0.9550000             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 9.
    ## 
    ## $`26_LogitBoost_down_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    6     0.2272908  0.9820000  0.4290212  0.9523077  0.9281818  0.9528620
    ##   30     0.3631492  0.9740000  0.7098645  0.9261905  0.8893130  0.9259981
    ##   51     0.6673798  0.9706667  0.7197658  0.9195238  0.8793130  0.9192641
    ##   57     0.7988438  0.9673333  0.7102204  0.9133333  0.8700000  0.9133381
    ##   59     0.7988933  0.9693333  0.7040090  0.9133333  0.8700000  0.9133381
    ##   63     0.8879738  0.9660000  0.6796584  0.9133333  0.8700000  0.9133381
    ##   66     0.9312421  0.9690000  0.7102655  0.9133333  0.8700000  0.9133381
    ##   90     1.2914023  0.9590000  0.6824066  0.9266667  0.8900000  0.9256397
    ##   91     1.2672117  0.9596667  0.6582796  0.9266667  0.8900000  0.9256397
    ##   99     1.4473887  0.9603333  0.6266129  0.9266667  0.8900000  0.9256397
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9758333         0.9611111          
    ##   0.9266667         0.9633333         0.9451852          
    ##   0.9200000         0.9600000         0.9396296          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9133333         0.9566667         0.9329630          
    ##   0.9266667         0.9633333         0.9382540          
    ##   0.9266667         0.9633333         0.9382540          
    ##   0.9266667         0.9633333         0.9382540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781145            0.9611111       0.9533333    0.3174359          
    ##   0.9673737            0.9451852       0.9266667    0.3087302          
    ##   0.9643434            0.9396296       0.9200000    0.3065079          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9610101            0.9329630       0.9133333    0.3044444          
    ##   0.9665657            0.9382540       0.9266667    0.3088889          
    ##   0.9665657            0.9382540       0.9266667    0.3088889          
    ##   0.9665657            0.9382540       0.9266667    0.3088889          
    ##   Mean_Balanced_Accuracy
    ##   0.9645833             
    ##   0.9450000             
    ##   0.9400000             
    ##   0.9350000             
    ##   0.9350000             
    ##   0.9350000             
    ##   0.9350000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9450000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 6.
    ## 
    ## $`27_LogitBoost_smote_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa     Mean_F1  
    ##   13     0.2043910  0.9800000  0.5162116  0.9533333  0.930000  0.9529966
    ##   14     0.2075586  0.9813333  0.5307222  0.9533333  0.930000  0.9529966
    ##   22     0.2926234  0.9860000  0.6249471  0.9461905  0.919313  0.9455892
    ##   26     0.3221863  0.9820000  0.6576365  0.9533333  0.930000  0.9529966
    ##   28     0.4027806  0.9786667  0.6459357  0.9400000  0.910000  0.9396633
    ##   30     0.4313569  0.9753333  0.6440971  0.9400000  0.910000  0.9396633
    ##   55     0.6932177  0.9673333  0.6865605  0.9400000  0.910000  0.9396633
    ##   57     0.7675104  0.9626667  0.6865759  0.9400000  0.910000  0.9396633
    ##   89     0.9842565  0.9690000  0.6133566  0.9466667  0.920000  0.9462626
    ##   94     1.0575754  0.9700000  0.6328011  0.9466667  0.920000  0.9462626
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9466667         0.9733333         0.9522222          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9400000         0.9700000         0.9455556          
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9466667         0.9733333         0.9533333          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9748485            0.9522222       0.9466667    0.3153968          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.955                 
    ##   0.960                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 13.
    ## 
    ## $`28_LogitBoost_up_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##   20     0.3279714  0.9786667  0.6166331  0.9528571  0.9291473  0.9513829
    ##   21     0.3112965  0.9813333  0.6175241  0.9528571  0.9291473  0.9513829
    ##   30     0.4423963  0.9746667  0.6730891  0.9533333  0.9300000  0.9524411
    ##   36     0.5130059  0.9746667  0.7063704  0.9461905  0.9193130  0.9450337
    ##   43     0.5941090  0.9733333  0.7118675  0.9333333  0.9000000  0.9323737
    ##   60     0.8463338  0.9676667  0.7131492  0.9395238  0.9093130  0.9384343
    ##   71     0.9685520  0.9656667  0.6807823  0.9266667  0.8900000  0.9257744
    ##   94     1.1963412  0.9673333  0.7078783  0.9266667  0.8900000  0.9257744
    ##   95     1.1823810  0.9666667  0.6224815  0.9266667  0.8900000  0.9257744
    ##   99     1.2639822  0.9666667  0.6358148  0.9395238  0.9093130  0.9384343
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9516667         0.9762963         0.9626984          
    ##   0.9516667         0.9762963         0.9626984          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9466667         0.9733333         0.9560317          
    ##   0.9333333         0.9666667         0.9438095          
    ##   0.9400000         0.9700000         0.9482540          
    ##   0.9266667         0.9633333         0.9360317          
    ##   0.9266667         0.9633333         0.9360317          
    ##   0.9266667         0.9633333         0.9360317          
    ##   0.9400000         0.9700000         0.9482540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9792929            0.9626984       0.9516667    0.3176190          
    ##   0.9792929            0.9626984       0.9516667    0.3176190          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9759596            0.9560317       0.9466667    0.3153968          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9723232            0.9482540       0.9400000    0.3131746          
    ##   0.9659596            0.9360317       0.9266667    0.3088889          
    ##   0.9659596            0.9360317       0.9266667    0.3088889          
    ##   0.9659596            0.9360317       0.9266667    0.3088889          
    ##   0.9723232            0.9482540       0.9400000    0.3131746          
    ##   Mean_Balanced_Accuracy
    ##   0.9639815             
    ##   0.9639815             
    ##   0.9650000             
    ##   0.9600000             
    ##   0.9500000             
    ##   0.9550000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9450000             
    ##   0.9550000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 21.
    ## 
    ## $`29_LogitBoost_down_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    5     0.2702916  0.9713333  0.3615129  0.9528571  0.9291473  0.9509620
    ##   21     0.3752966  0.9753333  0.6008470  0.9400000  0.9100000  0.9381313
    ##   33     0.4786156  0.9693333  0.6531764  0.9461905  0.9191473  0.9442280
    ##   39     0.6055244  0.9686667  0.6553386  0.9400000  0.9100000  0.9381313
    ##   42     0.6132065  0.9686667  0.6552275  0.9400000  0.9100000  0.9381313
    ##   49     0.7282757  0.9680000  0.6666720  0.9400000  0.9100000  0.9381313
    ##   53     0.7936043  0.9670000  0.6615860  0.9400000  0.9100000  0.9381313
    ##   81     1.0907266  0.9656667  0.5564127  0.9400000  0.9100000  0.9381313
    ##   95     1.2189188  0.9643333  0.5282341  0.9466667  0.9200000  0.9452862
    ##   99     1.2135210  0.9630000  0.5249497  0.9466667  0.9200000  0.9452862
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9516667         0.9762963         0.9642857          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9450000         0.9729630         0.9587302          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9466667         0.9733333         0.9587302          
    ##   0.9466667         0.9733333         0.9587302          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9797980            0.9642857       0.9516667    0.3176190          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9767677            0.9587302       0.9450000    0.3153968          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.9639815             
    ##   0.9550000             
    ##   0.9589815             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9550000             
    ##   0.9600000             
    ##   0.9600000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 5.
    ## 
    ## $`30_LogitBoost_smote_center_scale_ignore_logLoss`
    ## Boosted Logistic Regression 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   nIter  logLoss    AUC        prAUC      Accuracy   Kappa      Mean_F1  
    ##    1     0.6116584  0.9380000  0.2242209  0.9397863  0.9036713  0.9320400
    ##   25     0.4532285  0.9693333  0.5912082  0.9319048  0.8977745  0.9300337
    ##   28     0.4856553  0.9720000  0.5898867  0.9261905  0.8893130  0.9248316
    ##   67     1.0170263  0.9756667  0.5871507  0.9200000  0.8800000  0.9189057
    ##   85     1.2140226  0.9730000  0.5184423  0.9195238  0.8791473  0.9178475
    ##   86     1.2077461  0.9706667  0.5828127  0.9133333  0.8700000  0.9117508
    ##   90     1.2188038  0.9753333  0.6032857  0.9195238  0.8791473  0.9178475
    ##   94     1.2231541  0.9753333  0.6035534  0.9200000  0.8800000  0.9189057
    ##   98     1.2456689  0.9753333  0.5835534  0.9195238  0.8791473  0.9178475
    ##   99     1.2694722  0.9756667  0.4661746  0.9133333  0.8700000  0.9117508
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9155556         0.9710185         0.9358025          
    ##   0.9316667         0.9662963         0.9410317          
    ##   0.9266667         0.9633333         0.9365873          
    ##   0.9200000         0.9600000         0.9299206          
    ##   0.9183333         0.9596296         0.9299206          
    ##   0.9133333         0.9566667         0.9259524          
    ##   0.9183333         0.9596296         0.9299206          
    ##   0.9200000         0.9600000         0.9299206          
    ##   0.9183333         0.9596296         0.9299206          
    ##   0.9133333         0.9566667         0.9259524          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9736640            0.9358025       0.9155556    0.3132621          
    ##   0.9689226            0.9410317       0.9316667    0.3106349          
    ##   0.9661953            0.9365873       0.9266667    0.3087302          
    ##   0.9628620            0.9299206       0.9200000    0.3066667          
    ##   0.9628620            0.9299206       0.9183333    0.3065079          
    ##   0.9603367            0.9259524       0.9133333    0.3044444          
    ##   0.9628620            0.9299206       0.9183333    0.3065079          
    ##   0.9628620            0.9299206       0.9200000    0.3066667          
    ##   0.9628620            0.9299206       0.9183333    0.3065079          
    ##   0.9603367            0.9259524       0.9133333    0.3044444          
    ##   Mean_Balanced_Accuracy
    ##   0.9432870             
    ##   0.9489815             
    ##   0.9450000             
    ##   0.9400000             
    ##   0.9389815             
    ##   0.9350000             
    ##   0.9389815             
    ##   0.9400000             
    ##   0.9389815             
    ##   0.9350000             
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was nIter = 25.
    ## 
    ## $`31_rf_smote_center_scale_ignore_Kappa`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9533333  0.93 
    ##    2    0.9400000  0.91 
    ##    3    0.9466667  0.92 
    ##    4    0.9333333  0.90 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.
    ## 
    ## $`32_rf_up_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1325623  0.9940000  0.7228175  0.9466667  0.92   0.9458418
    ##    2    0.1196242  0.9946667  0.4303254  0.9466667  0.92   0.9458418
    ##    3    0.1275468  0.9926667  0.3135198  0.9533333  0.93   0.9525758
    ##    4    0.1282826  0.9946667  0.2503254  0.9533333  0.93   0.9525758
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9533333         0.9766667         0.9604762          
    ##   0.9533333         0.9766667         0.9604762          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`33_rf_down_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1259582  0.9960000  0.6927698  0.9466667  0.92   0.9457071
    ##    2    0.1183532  0.9966667  0.4942698  0.9600000  0.94   0.9591751
    ##    3    0.1181455  0.9973333  0.3151111  0.9533333  0.93   0.9524411
    ##    4    0.1157227  0.9986667  0.2908889  0.9533333  0.93   0.9524411
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9600000         0.9800000         0.9682540          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9533333         0.9766667         0.9626984          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 4.
    ## 
    ## $`34_rf_smote_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy  Kappa  Mean_F1  
    ##    1    0.1218002  0.9940000  0.6297619  0.96      0.94   0.9591751
    ##    2    0.1102341  0.9960000  0.4062063  0.94      0.91   0.9393939
    ##    3    0.3480561  0.9896667  0.2287619  0.96      0.94   0.9591751
    ##    4    0.3771713  0.9896667  0.1887619  0.94      0.91   0.9393939
    ##   NA          NaN  0.5000000        NaN   NaN       NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.96              0.98              0.9682540          
    ##   0.94              0.97              0.9472222          
    ##   0.96              0.98              0.9682540          
    ##   0.94              0.97              0.9472222          
    ##    NaN               NaN                    NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9823232            0.9682540       0.96         0.3200000          
    ##   0.9720539            0.9472222       0.94         0.3133333          
    ##   0.9823232            0.9682540       0.96         0.3200000          
    ##   0.9720539            0.9472222       0.94         0.3133333          
    ##         NaN                  NaN        NaN               NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.970                 
    ##   0.955                 
    ##   0.970                 
    ##   0.955                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`35_rf_up_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1340707  0.9960000  0.6926667  0.9400000  0.91   0.9391077
    ##    2    0.1129814  0.9973333  0.5017778  0.9600000  0.94   0.9597306
    ##    3    0.1146355  0.9960000  0.2993333  0.9533333  0.93   0.9529966
    ##    4    0.1152305  0.9960000  0.2926667  0.9533333  0.93   0.9529966
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9493651          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9588889          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`36_rf_up_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1293391  0.9953333  0.7181587  0.9400000  0.91   0.9381313
    ##    2    0.1084996  0.9960000  0.5261032  0.9533333  0.93   0.9524411
    ##    3    0.1092443  0.9960000  0.2861032  0.9600000  0.94   0.9595960
    ##    4    0.1081212  0.9953333  0.3050397  0.9600000  0.94   0.9595960
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9547619          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9600000         0.9800000         0.9666667          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.965                 
    ##   0.970                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 4.
    ## 
    ## $`37_rf_down_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC    prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1282627  0.994  0.7361508  0.9466667  0.92   0.9457071
    ##    2    0.1038169  0.996  0.4727698  0.9600000  0.94   0.9587542
    ##    3    0.1056095  0.996  0.3194365  0.9600000  0.94   0.9587542
    ##    4    0.1129823  0.996  0.2727698  0.9600000  0.94   0.9587542
    ##   NA          NaN  0.500        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9543651          
    ##   0.9600000         0.9800000         0.9698413          
    ##   0.9600000         0.9800000         0.9698413          
    ##   0.9600000         0.9800000         0.9698413          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9828283            0.9698413       0.9600000    0.3200000          
    ##   0.9828283            0.9698413       0.9600000    0.3200000          
    ##   0.9828283            0.9698413       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.96                  
    ##   0.97                  
    ##   0.97                  
    ##   0.97                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`38_rf_smote_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1397263  0.9906667  0.6229802  0.9466667  0.92   0.9459764
    ##    2    0.1159716  0.9960000  0.4194365  0.9533333  0.93   0.9527104
    ##    3    0.1354053  0.9966667  0.1940476  0.9533333  0.93   0.9527104
    ##    4    0.3411941  0.9916667  0.1718254  0.9600000  0.94   0.9593098
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9526984          
    ##   0.9533333         0.9766667         0.9582540          
    ##   0.9533333         0.9766667         0.9582540          
    ##   0.9600000         0.9800000         0.9660317          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9750505            0.9526984       0.9466667    0.3155556          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`39_rf_up_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1268246  0.9973333  0.7152143  0.9466667  0.92   0.9462626
    ##    2    0.1099272  0.9986667  0.5308889  0.9600000  0.94   0.9597306
    ##    3    0.1168412  0.9986667  0.3308889  0.9600000  0.94   0.9597306
    ##    4    0.1110455  0.9986667  0.2842222  0.9600000  0.94   0.9597306
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9600000         0.9800000         0.9644444          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.96                  
    ##   0.97                  
    ##   0.97                  
    ##   0.97                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`40_rf_down_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1324381  0.9933333  0.6813175  0.9466667  0.92   0.9458418
    ##    2    0.1155678  0.9946667  0.5104286  0.9533333  0.93   0.9525758
    ##    3    0.1154441  0.9946667  0.3370952  0.9600000  0.94   0.9593098
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9533333         0.9766667         0.9604762          
    ##   0.9600000         0.9800000         0.9660317          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## $`41_rf_smote_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1133918  0.9960000  0.6726548  0.9400000  0.91   0.9385522
    ##    2    0.1006643  0.9960000  0.3993214  0.9600000  0.94   0.9578200
    ##    3    0.1136024  0.9960000  0.2461032  0.9466667  0.92   0.9425759
    ##    4    0.1055672  0.9953333  0.1983056  0.9466667  0.92   0.9443519
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9468254          
    ##   0.9600000         0.9800000         0.9708333          
    ##   0.9466667         0.9733333         0.9638889          
    ##   0.9466667         0.9733333         0.9569444          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9723485            0.9468254       0.9400000    0.3133333          
    ##   0.9832168            0.9708333       0.9600000    0.3200000          
    ##   0.9785548            0.9638889       0.9466667    0.3155556          
    ##   0.9764828            0.9569444       0.9466667    0.3155556          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.970                 
    ##   0.960                 
    ##   0.960                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`42_rf_down_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1297650  0.9960000  0.6860000  0.9466667  0.92   0.9452862
    ##    2    0.1144485  0.9950000  0.4641032  0.9533333  0.93   0.9524411
    ##    3    0.1182448  0.9946667  0.3169921  0.9533333  0.93   0.9529966
    ##    4    0.1190760  0.9960000  0.2527698  0.9533333  0.93   0.9529966
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9587302          
    ##   0.9533333         0.9766667         0.9626984          
    ##   0.9533333         0.9766667         0.9588889          
    ##   0.9533333         0.9766667         0.9588889          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`43_rf_up_center_scale_ignore_Accuracy`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9533333  0.93 
    ##    3    0.9466667  0.92 
    ##    4    0.9466667  0.92 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`44_rf_down_center_scale_ignore_Accuracy`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9533333  0.93 
    ##    2    0.9533333  0.93 
    ##    3    0.9600000  0.94 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## $`45_rf_smote_center_scale_ignore_Accuracy`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9533333  0.93 
    ##    2    0.9600000  0.94 
    ##    3    0.9666667  0.95 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## $`46_rf_up_center_scale_ignore_Kappa`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9533333  0.93 
    ##    3    0.9533333  0.93 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`47_rf_down_center_scale_ignore_Kappa`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9466667  0.92 
    ##    3    0.9400000  0.91 
    ##    4    0.9333333  0.90 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.
    ## 
    ## $`48_rf_smote_center_scale_ignore_Kappa`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    3    0.9466667  0.92 
    ##    4    0.9466667  0.92 
    ##   NA          NaN   NaN 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.
    ## 
    ## $`49_rf_up_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1296743  0.9973333  0.6951111  0.9400000  0.91   0.9389731
    ##    2    0.1153589  0.9973333  0.4684444  0.9533333  0.93   0.9528620
    ##    3    0.1131822  0.9973333  0.3151111  0.9600000  0.94   0.9595960
    ##    4    0.1120445  0.9973333  0.2951111  0.9600000  0.94   0.9595960
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9533333         0.9766667         0.9611111          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9600000         0.9800000         0.9666667          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.965                 
    ##   0.970                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 4.
    ## 
    ## $`50_rf_down_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1335013  0.9893333  0.6538690  0.9333333  0.90   0.9327946
    ##    2    0.1175270  0.9906667  0.4562103  0.9466667  0.92   0.9462626
    ##    3    0.1247644  0.9920000  0.3119881  0.9466667  0.92   0.9462626
    ##    4    0.1208986  0.9906667  0.2762103  0.9466667  0.92   0.9462626
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9333333         0.9666667         0.9394444          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9466667         0.9733333         0.9505556          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9684175            0.9394444       0.9333333    0.3111111          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.95                  
    ##   0.96                  
    ##   0.96                  
    ##   0.96                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`51_rf_smote_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1476016  0.9910000  0.6570741  0.9466667  0.92   0.9462626
    ##    2    0.1178078  0.9973333  0.4151111  0.9600000  0.94   0.9595960
    ##    3    0.3181564  0.9930000  0.2467778  0.9533333  0.93   0.9528620
    ##    4    0.5576547  0.9886667  0.1597778  0.9466667  0.92   0.9461279
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9533333         0.9766667         0.9611111          
    ##   0.9466667         0.9733333         0.9555556          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9757576            0.9555556       0.9466667    0.3155556          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.970                 
    ##   0.965                 
    ##   0.960                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`52_rf_up_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1253117  0.9973333  0.7152143  0.9466667  0.92   0.9458418
    ##    2    0.1089687  0.9986667  0.4775556  0.9466667  0.92   0.9458418
    ##    3    0.1097700  0.9986667  0.3242222  0.9466667  0.92   0.9458418
    ##    4    0.1179319  0.9986667  0.2908889  0.9400000  0.91   0.9386869
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9466667         0.9733333         0.9549206          
    ##   0.9400000         0.9700000         0.9509524          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9731313            0.9509524       0.9400000    0.3133333          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.960                 
    ##   0.955                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`53_rf_down_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss     AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.12170909  0.9946667  0.7170952  0.9466667  0.92   0.9462626
    ##    2    0.10057619  0.9940000  0.5292619  0.9600000  0.94   0.9597306
    ##    3    0.09434603  0.9960000  0.3263810  0.9600000  0.94   0.9597306
    ##   NA           NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9505556          
    ##   0.9600000         0.9800000         0.9644444          
    ##   0.9600000         0.9800000         0.9644444          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.96                  
    ##   0.97                  
    ##   0.97                  
    ##    NaN                  
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 3.
    ## 
    ## $`54_rf_smote_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1223409  0.9946667  0.6436587  0.9466667  0.92   0.9462626
    ##    2    0.1136952  0.9973333  0.4017778  0.9466667  0.92   0.9457071
    ##    3    0.3207548  0.9916667  0.2310000  0.9600000  0.94   0.9595960
    ##    4    0.3134296  0.9923333  0.1395556  0.9533333  0.93   0.9524411
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9466667         0.9733333         0.9533333          
    ##   0.9466667         0.9733333         0.9571429          
    ##   0.9600000         0.9800000         0.9666667          
    ##   0.9533333         0.9766667         0.9626984          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.970                 
    ##   0.965                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`55_rf_smote_center_scale_ignore_logLoss`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  logLoss    AUC        prAUC      Accuracy   Kappa  Mean_F1  
    ##    1    0.1439495  0.9940000  0.6620556  0.9533333  0.93   0.9528620
    ##    2    0.1110781  1.0000000  0.4066667  0.9466667  0.92   0.9461279
    ##    3    0.1523813  1.0000000  0.2333333  0.9400000  0.91   0.9389731
    ##    4    0.3500835  0.9923333  0.2062222  0.9600000  0.94   0.9595960
    ##   NA          NaN  0.5000000        NaN        NaN   NaN         NaN
    ##   Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9533333         0.9766667         0.9611111          
    ##   0.9466667         0.9733333         0.9555556          
    ##   0.9400000         0.9700000         0.9515873          
    ##   0.9600000         0.9800000         0.9666667          
    ##         NaN               NaN               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9757576            0.9555556       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##         NaN                  NaN             NaN          NaN          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.960                 
    ##   0.955                 
    ##   0.970                 
    ##     NaN                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`56_xgbTree_up_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02689873   9         1.1186604  0.5017006         18              
    ##   0.10339048   2         4.7965515  0.4114670          8              
    ##   0.12819800   9         4.0864885  0.4380444         13              
    ##   0.14737488   5         7.4903001  0.6127656          3              
    ##   0.16628441   9         0.8456683  0.5064936         18              
    ##   0.30552451   5         2.2512556  0.4552914          3              
    ##   0.47242653  10         4.9995205  0.5576734          6              
    ##   0.50074173  10         5.0396129  0.6057206          8              
    ##   0.55760167   8         0.6192581  0.6240394          8              
    ##   0.58070184   3         6.6124660  0.6642262          1              
    ##   subsample  nrounds  logLoss    AUC        prAUC       Accuracy   Kappa
    ##   0.4582901  231      1.0962507  0.5733333  0.02049735  0.3933333  0.09 
    ##   0.2770308  664      0.5246996  0.9893333  0.59461772  0.9266667  0.89 
    ##   0.4799113  576      0.5333395  0.9806667  0.58737831  0.9066667  0.86 
    ##   0.3218215  231      0.4647924  0.9960000  0.24675000  0.9400000  0.91 
    ##   0.4858883   27      1.0941660  0.5366667  0.01884921  0.3733333  0.06 
    ##   0.7615572  873      0.1768818  0.9900000  0.65887512  0.9533333  0.93 
    ##   0.8824130  967      0.2127645  0.9880000  0.23070370  0.9533333  0.93 
    ##   0.5433916  727      0.2713770  0.9893333  0.29067388  0.9400000  0.91 
    ##   0.8506968   69      0.2202289  0.9893333  0.45171958  0.9333333  0.90 
    ##   0.7160807   20      0.2806223  0.9913333  0.21908466  0.9600000  0.94 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##         NaN  0.3933333         0.6966667               NaN          
    ##   0.9242424  0.9266667         0.9633333         0.9452381          
    ##   0.9022476  0.9066667         0.9533333         0.9284524          
    ##   0.9385522  0.9400000         0.9700000         0.9531746          
    ##         NaN  0.3733333         0.6866667               NaN          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   0.9520202  0.9533333         0.9766667         0.9642857          
    ##   0.9381313  0.9400000         0.9700000         0.9547619          
    ##   0.9313973  0.9333333         0.9666667         0.9492063          
    ##   0.9591751  0.9600000         0.9800000         0.9682540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.8064815                  NaN       0.3933333    0.1311111          
    ##   0.9686869            0.9452381       0.9266667    0.3088889          
    ##   0.9601865            0.9284524       0.9066667    0.3022222          
    ##   0.9737374            0.9531746       0.9400000    0.3133333          
    ##   0.8125000                  NaN       0.3733333    0.1244444          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9797980            0.9642857       0.9533333    0.3177778          
    ##   0.9742424            0.9547619       0.9400000    0.3133333          
    ##   0.9712121            0.9492063       0.9333333    0.3111111          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   Mean_Balanced_Accuracy
    ##   0.545                 
    ##   0.945                 
    ##   0.930                 
    ##   0.955                 
    ##   0.530                 
    ##   0.965                 
    ##   0.965                 
    ##   0.955                 
    ##   0.950                 
    ##   0.970                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 873, max_depth = 5,
    ##  eta = 0.3055245, gamma = 2.251256, colsample_bytree =
    ##  0.4552914, min_child_weight = 3 and subsample = 0.7615572.
    ## 
    ## $`57_xgbTree_down_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta          max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.007009399  10         2.7677041  0.4400230         19              
    ##   0.093442796   3         7.6039832  0.3720594         20              
    ##   0.112231655   5         6.7528272  0.3499339          0              
    ##   0.150267192   2         3.8199943  0.4380470         11              
    ##   0.220545686   9         5.0419176  0.6847606         14              
    ##   0.263886317   4         7.6075398  0.3560588         20              
    ##   0.379351866   2         0.8739472  0.6774875          6              
    ##   0.388127434   6         8.8303013  0.4505690         12              
    ##   0.437113916   2         9.5706032  0.4429705          9              
    ##   0.445374085   3         3.2304913  0.5855829          6              
    ##   subsample  nrounds  logLoss    AUC        prAUC       Accuracy   Kappa
    ##   0.5574600  662      1.0728689  0.8440000  0.27994243  0.6933333  0.54 
    ##   0.5802884   71      1.0776776  0.6733333  0.04870503  0.4800000  0.22 
    ##   0.6661648  392      0.3003087  0.9900000  0.56954425  0.9466667  0.92 
    ##   0.3097329  792      0.7397086  0.9500000  0.43419096  0.8133333  0.72 
    ##   0.5595999  471      0.4756692  0.9833333  0.52042641  0.9266667  0.89 
    ##   0.8796389  603      0.5092331  0.9720000  0.45118251  0.9000000  0.85 
    ##   0.8108775   83      0.1817846  0.9866667  0.47131349  0.9600000  0.94 
    ##   0.4118080  593      0.5497505  0.9753333  0.33417857  0.8800000  0.82 
    ##   0.9054366  155      0.3030860  0.9880000  0.33207143  0.9333333  0.90 
    ##   0.4138556  548      0.2714938  0.9833333  0.29545238  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.7068302  0.6933333         0.8466667         0.8368607          
    ##   0.6666667  0.4800000         0.7400000         0.8095238          
    ##   0.9461279  0.9466667         0.9733333         0.9527778          
    ##   0.8178050  0.8133333         0.9066667         0.8587302          
    ##   0.9228355  0.9266667         0.9633333         0.9420635          
    ##   0.9231949  0.9000000         0.9500000         0.9370370          
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.8703212  0.8800000         0.9400000         0.8975000          
    ##   0.9326599  0.9333333         0.9666667         0.9416667          
    ##   0.9393939  0.9400000         0.9700000         0.9472222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.8954823            0.8368607       0.6933333    0.2311111          
    ##   0.8057067            0.8095238       0.4800000    0.1600000          
    ##   0.9750842            0.9527778       0.9466667    0.3155556          
    ##   0.9236053            0.8587302       0.8133333    0.2711111          
    ##   0.9685703            0.9420635       0.9266667    0.3088889          
    ##   0.9592929            0.9370370       0.9000000    0.3000000          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9480856            0.8975000       0.8800000    0.2933333          
    ##   0.9690236            0.9416667       0.9333333    0.3111111          
    ##   0.9720539            0.9472222       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.770                 
    ##   0.610                 
    ##   0.960                 
    ##   0.860                 
    ##   0.945                 
    ##   0.925                 
    ##   0.970                 
    ##   0.910                 
    ##   0.950                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 83, max_depth = 2,
    ##  eta = 0.3793519, gamma = 0.8739472, colsample_bytree =
    ##  0.6774875, min_child_weight = 6 and subsample = 0.8108775.
    ## 
    ## $`58_xgbTree_smote_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02482192  10         5.6046046  0.4198726          3              
    ##   0.10125112   1         5.4964911  0.3921863         17              
    ##   0.16247706   6         5.4695929  0.3489723         14              
    ##   0.18142687   2         0.7119628  0.5302325         20              
    ##   0.27393603   1         1.0493663  0.6168994          2              
    ##   0.33377902   5         4.8530878  0.3885611         15              
    ##   0.34202738   4         6.6258888  0.5202839          6              
    ##   0.37514510   2         7.6329697  0.4347916         10              
    ##   0.50028465   2         1.3784108  0.4992919          7              
    ##   0.58456637   4         5.6502746  0.4193118          3              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.7217292  165      0.1976310  0.9906667  0.7163810  0.9666667  0.95 
    ##   0.9944178   22      0.4041025  0.9886667  0.6061508  0.9400000  0.91 
    ##   0.6102231   28      0.2432559  0.9873333  0.6435952  0.9533333  0.93 
    ##   0.2520694   56      0.8411575  0.8280000  0.1826335  0.6200000  0.43 
    ##   0.6846460  828      0.1775707  0.9833333  0.6331958  0.9600000  0.94 
    ##   0.5901326  878      0.2318023  0.9886667  0.5642341  0.9466667  0.92 
    ##   0.2561292  964      0.2519359  0.9913333  0.2824517  0.9600000  0.94 
    ##   0.2590266  191      0.3232451  0.9893333  0.3813069  0.9666667  0.95 
    ##   0.4251053  151      0.1764686  0.9866667  0.6084735  0.9533333  0.93 
    ##   0.8898684  461      0.1792750  0.9893333  0.5300026  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9659091  0.9666667         0.9833333         0.9738095          
    ##   0.9393939  0.9400000         0.9700000         0.9472222          
    ##   0.9529966  0.9533333         0.9766667         0.9588889          
    ##         NaN  0.6200000         0.8100000               NaN          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9461279  0.9466667         0.9733333         0.9527778          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9654040  0.9666667         0.9833333         0.9722222          
    ##   0.9528620  0.9533333         0.9766667         0.9583333          
    ##   0.9395286  0.9400000         0.9700000         0.9450000          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9853535            0.9738095       0.9666667    0.3222222          
    ##   0.9720539            0.9472222       0.9400000    0.3133333          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.8541667                  NaN       0.6200000    0.2066667          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9750842            0.9527778       0.9466667    0.3155556          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9853535            0.9722222       0.9666667    0.3222222          
    ##   0.9781145            0.9583333       0.9533333    0.3177778          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.975                 
    ##   0.955                 
    ##   0.965                 
    ##   0.715                 
    ##   0.970                 
    ##   0.960                 
    ##   0.970                 
    ##   0.975                 
    ##   0.965                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 151, max_depth = 2,
    ##  eta = 0.5002847, gamma = 1.378411, colsample_bytree =
    ##  0.4992919, min_child_weight = 7 and subsample = 0.4251053.
    ## 
    ## $`59_xgbTree_up_center_scale_ignore_Accuracy`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.01977332  2          3.3573311  0.6979748          8              
    ##   0.08047022  4          6.8644814  0.4510254         11              
    ##   0.09793596  5          0.5646297  0.5920370          7              
    ##   0.17537836  1          3.3400530  0.3681707         13              
    ##   0.20658901  1          8.0403692  0.3429109          9              
    ##   0.21967130  1          4.3154496  0.6160907          6              
    ##   0.32929840  8          3.4895337  0.3907191         10              
    ##   0.41496457  8          9.0741395  0.6129662          2              
    ##   0.52666394  9          6.2630533  0.4037165         20              
    ##   0.54152655  2          2.8150365  0.4553991         12              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.6683340  444      0.9466667  0.92 
    ##   0.3662362  833      0.9000000  0.85 
    ##   0.4059783  886      0.9400000  0.91 
    ##   0.9627660  792      0.9666667  0.95 
    ##   0.6073181  835      0.9666667  0.95 
    ##   0.7204077  744      0.9466667  0.92 
    ##   0.2659633  876      0.8133333  0.72 
    ##   0.3672318  660      0.9466667  0.92 
    ##   0.7104291  605      0.8200000  0.73 
    ##   0.6960119   89      0.9733333  0.96 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 89, max_depth = 2,
    ##  eta = 0.5415266, gamma = 2.815037, colsample_bytree =
    ##  0.4553991, min_child_weight = 12 and subsample = 0.6960119.
    ## 
    ## $`60_xgbTree_down_center_scale_ignore_Accuracy`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02318672  1          6.6260729  0.5815881         11              
    ##   0.08687563  6          6.0329815  0.4359725          4              
    ##   0.20391038  6          5.1927123  0.5018903         15              
    ##   0.23665068  2          2.0533045  0.5086049          8              
    ##   0.24325575  7          9.9848415  0.4521114          3              
    ##   0.35206828  2          5.6586415  0.5269467         14              
    ##   0.35939171  7          0.2255089  0.5546268          0              
    ##   0.39103786  4          1.9574009  0.3283340          9              
    ##   0.43306637  8          9.5658514  0.4624780         12              
    ##   0.44222726  8          4.7402270  0.5420659          7              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.9933011  958      0.9466667  0.92 
    ##   0.4333983  630      0.9333333  0.90 
    ##   0.4129211  219      0.6733333  0.51 
    ##   0.5046931  510      0.9600000  0.94 
    ##   0.5608606  927      0.9400000  0.91 
    ##   0.4276024  624      0.8200000  0.73 
    ##   0.4703984  259      0.9533333  0.93 
    ##   0.6297550   75      0.9333333  0.90 
    ##   0.6271674  392      0.9266667  0.89 
    ##   0.9146645  547      0.9400000  0.91 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 510, max_depth = 2,
    ##  eta = 0.2366507, gamma = 2.053305, colsample_bytree =
    ##  0.5086049, min_child_weight = 8 and subsample = 0.5046931.
    ## 
    ## $`61_xgbTree_smote_center_scale_ignore_Accuracy`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma       colsample_bytree  min_child_weight
    ##   0.1080750  10         5.37394968  0.5305338          3              
    ##   0.2489482   8         0.58480117  0.6467686         18              
    ##   0.2570017   4         6.72625465  0.3114495          7              
    ##   0.2597606   8         0.93837458  0.5015596          7              
    ##   0.3575489   2         4.99665681  0.5696957         15              
    ##   0.4166273   2         4.19643659  0.4223256         10              
    ##   0.4649823   3         4.48532129  0.5847111         20              
    ##   0.5259216   1         0.04008689  0.5201734         20              
    ##   0.5494047   4         9.06886730  0.3724348         12              
    ##   0.5528741   7         2.95927692  0.3156917          7              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.4205846  153      0.9666667  0.95 
    ##   0.2894986  400      0.9133333  0.87 
    ##   0.6822852  500      0.9466667  0.92 
    ##   0.5367836  161      0.9466667  0.92 
    ##   0.4595061  220      0.9533333  0.93 
    ##   0.3566936  197      0.9600000  0.94 
    ##   0.3995012  250      0.9066667  0.86 
    ##   0.8252749  945      0.9400000  0.91 
    ##   0.5237051  823      0.9533333  0.93 
    ##   0.4957036  680      0.9733333  0.96 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 680, max_depth = 7,
    ##  eta = 0.5528741, gamma = 2.959277, colsample_bytree =
    ##  0.3156917, min_child_weight = 7 and subsample = 0.4957036.
    ## 
    ## $`62_xgbTree_up_center_scale_ignore_Kappa`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.02291041   2         7.133687  0.3421018          7              
    ##   0.07356543  10         8.447265  0.4634668         17              
    ##   0.16197901   8         2.279581  0.6690080         15              
    ##   0.18937065   9         8.090003  0.5840178          0              
    ##   0.19188911   6         3.698359  0.5295794         14              
    ##   0.37928599   9         8.432454  0.5722331         17              
    ##   0.38652469   8         5.185679  0.3597529          7              
    ##   0.41088674   8         3.270287  0.5892394          9              
    ##   0.45242852   5         7.656328  0.4181568          6              
    ##   0.54075096   2         7.496749  0.4693078         15              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.7614307  176      0.9466667  0.92 
    ##   0.9493706  987      0.9400000  0.91 
    ##   0.9204220  359      0.9400000  0.91 
    ##   0.9648236  800      0.9400000  0.91 
    ##   0.3774765  482      0.7133333  0.57 
    ##   0.5208409  969      0.7800000  0.67 
    ##   0.6005883  734      0.9466667  0.92 
    ##   0.7192471  154      0.9466667  0.92 
    ##   0.9749795    1      0.8733333  0.81 
    ##   0.4903544  359      0.8400000  0.76 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 154, max_depth = 8,
    ##  eta = 0.4108867, gamma = 3.270287, colsample_bytree =
    ##  0.5892394, min_child_weight = 9 and subsample = 0.7192471.
    ## 
    ## $`63_xgbTree_down_center_scale_ignore_Kappa`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.05113976  2          1.558226  0.6613067         16              
    ##   0.12128559  9          5.249478  0.4272196          9              
    ##   0.15112052  2          6.684581  0.3158779         20              
    ##   0.18766465  9          1.476779  0.3380189          9              
    ##   0.20684344  1          3.102837  0.6547995          7              
    ##   0.21163345  6          6.513298  0.5386669          9              
    ##   0.24744339  8          9.742273  0.6543338         14              
    ##   0.53940502  2          2.248686  0.5324960         16              
    ##   0.54818649  4          9.999923  0.6888182          2              
    ##   0.55692288  8          7.392499  0.4576498          9              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.8584007  430      0.9400000  0.91 
    ##   0.3849967    6      0.8266667  0.74 
    ##   0.7468637  693      0.8666667  0.80 
    ##   0.9341637  566      0.9533333  0.93 
    ##   0.7795796  883      0.9466667  0.92 
    ##   0.6124696  696      0.9400000  0.91 
    ##   0.6671114  513      0.9600000  0.94 
    ##   0.2633479  960      0.3333333  0.00 
    ##   0.6649752  991      0.9400000  0.91 
    ##   0.7677560  323      0.9466667  0.92 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 513, max_depth = 8,
    ##  eta = 0.2474434, gamma = 9.742273, colsample_bytree =
    ##  0.6543338, min_child_weight = 14 and subsample = 0.6671114.
    ## 
    ## $`64_xgbTree_smote_center_scale_ignore_Kappa`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.01566790   9         3.7994296  0.6214079         12              
    ##   0.07772007  10         9.2624978  0.4492375          2              
    ##   0.10680302   1         0.3526196  0.6584419         18              
    ##   0.16497726   3         8.8607822  0.5261489         14              
    ##   0.31896298   5         9.5529211  0.3957696          4              
    ##   0.36515785  10         2.8899243  0.4522077         13              
    ##   0.37010109   4         4.4303998  0.3094816          6              
    ##   0.45748265   2         6.0934960  0.6734609         12              
    ##   0.46060447   5         4.9750261  0.4437970          3              
    ##   0.56419203   1         8.6560237  0.5230141          2              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.4559758  891      0.9466667  0.92 
    ##   0.5492621  452      0.9600000  0.94 
    ##   0.3442853  364      0.9200000  0.88 
    ##   0.9594428  612      0.9400000  0.91 
    ##   0.5913660  841      0.9600000  0.94 
    ##   0.4503320   10      0.9600000  0.94 
    ##   0.6562713  248      0.9400000  0.91 
    ##   0.5056584  218      0.9600000  0.94 
    ##   0.2656208  550      0.9666667  0.95 
    ##   0.5600102  932      0.9600000  0.94 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 550, max_depth = 5,
    ##  eta = 0.4606045, gamma = 4.975026, colsample_bytree =
    ##  0.443797, min_child_weight = 3 and subsample = 0.2656208.
    ## 
    ## $`65_xgbTree_up_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.1711763   7         4.0201309  0.4792185          4              
    ##   0.2123928   3         3.7996952  0.6314419         16              
    ##   0.2233327  10         8.1886254  0.6388212         19              
    ##   0.3114193   3         0.6204786  0.4332426          6              
    ##   0.3167788  10         5.6649142  0.3200350         20              
    ##   0.3934875   3         7.1117361  0.3864775         16              
    ##   0.4039595   7         4.0780334  0.6618091         20              
    ##   0.5164765   6         8.8833465  0.5347621         11              
    ##   0.5472755   2         7.8088403  0.4082921         10              
    ##   0.5818291   6         7.8141741  0.6959499         15              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.5134995  591      0.2400123  0.9880000  0.6009783  0.9466667  0.92 
    ##   0.5031642  567      0.6912813  0.9540000  0.4795521  0.8133333  0.72 
    ##   0.4081254   43      1.0992611  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.9508625  303      0.1745498  0.9880000  0.7300733  0.9533333  0.93 
    ##   0.9308598  797      0.4695414  0.9806667  0.4783942  0.9200000  0.88 
    ##   0.8519089   24      0.3855669  0.9840000  0.3857763  0.9400000  0.91 
    ##   0.4494396  665      1.1002218  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.4124411  494      0.4625657  0.9806667  0.2505238  0.9400000  0.91 
    ##   0.7391800  342      0.3003213  0.9873333  0.3786987  0.9466667  0.92 
    ##   0.7497127  972      0.3343389  0.9880000  0.2010100  0.9600000  0.94 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9457071  0.9466667         0.9733333         0.9543651          
    ##   0.7931099  0.8133333         0.9066667         0.8380159          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9175589  0.9200000         0.9600000         0.9342857          
    ##   0.9383165  0.9400000         0.9700000         0.9471429          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9363035  0.9400000         0.9700000         0.9531746          
    ##   0.9448653  0.9466667         0.9733333         0.9603175          
    ##   0.9591751  0.9600000         0.9800000         0.9682540          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9755892            0.9543651       0.9466667    0.3155556          
    ##   0.9222931            0.8380159       0.8133333    0.2711111          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9645455            0.9342857       0.9200000    0.3066667          
    ##   0.9725253            0.9471429       0.9400000    0.3133333          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9746309            0.9531746       0.9400000    0.3133333          
    ##   0.9772727            0.9603175       0.9466667    0.3155556          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.860                 
    ##   0.500                 
    ##   0.965                 
    ##   0.940                 
    ##   0.955                 
    ##   0.500                 
    ##   0.955                 
    ##   0.960                 
    ##   0.970                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 303, max_depth = 3,
    ##  eta = 0.3114193, gamma = 0.6204786, colsample_bytree =
    ##  0.4332426, min_child_weight = 6 and subsample = 0.9508625.
    ## 
    ## $`66_xgbTree_down_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta          max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.007667202  3          9.679453  0.5085298          2              
    ##   0.144041742  3          1.122959  0.3852799          0              
    ##   0.217176709  2          2.484552  0.3601234          7              
    ##   0.354994566  2          2.533954  0.6333314          9              
    ##   0.365698881  8          1.935811  0.4914190          1              
    ##   0.366906612  5          6.360774  0.4654635          9              
    ##   0.422495611  8          4.381504  0.4138440         14              
    ##   0.461129683  3          1.422534  0.5790226         11              
    ##   0.513000411  9          9.469561  0.4551831         12              
    ##   0.555684358  2          2.306238  0.3848269         17              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6358158    8      1.0357675  0.9993333  0.3587778  0.9400000  0.91 
    ##   0.4774259   89      0.1556786  1.0000000  0.7200000  0.9533333  0.93 
    ##   0.6281727  101      0.2306922  0.9986667  0.6175556  0.9466667  0.92 
    ##   0.8878387  323      0.2032836  0.9880000  0.4316667  0.9533333  0.93 
    ##   0.9918338  550      0.1808321  0.9866667  0.5976154  0.9466667  0.92 
    ##   0.5227873  142      0.3342754  0.9933333  0.4048889  0.9400000  0.91 
    ##   0.4429405  997      0.6088149  0.9633333  0.4502274  0.8800000  0.82 
    ##   0.9873013  557      0.2352406  0.9860000  0.3773704  0.9533333  0.93 
    ##   0.3898151  522      0.6289586  0.9226667  0.2121824  0.8400000  0.76 
    ##   0.2549660  618      1.1022069  0.5000000  0.0000000  0.3333333  0.00 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9389731  0.9400000         0.9700000         0.9515873          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.9457071  0.9466667         0.9733333         0.9571429          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.9462626  0.9466667         0.9733333         0.9533333          
    ##   0.9389731  0.9400000         0.9700000         0.9515873          
    ##   0.8770034  0.8800000         0.9400000         0.8980952          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.8237124  0.8400000         0.9200000         0.8811508          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9751515            0.9533333       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9456566            0.8980952       0.8800000    0.2933333          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9355811            0.8811508       0.8400000    0.2800000          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ##   0.960                 
    ##   0.955                 
    ##   0.910                 
    ##   0.965                 
    ##   0.880                 
    ##   0.500                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 89, max_depth = 3,
    ##  eta = 0.1440417, gamma = 1.122959, colsample_bytree =
    ##  0.3852799, min_child_weight = 0 and subsample = 0.4774259.
    ## 
    ## $`67_xgbTree_smote_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.03786024  1          2.6394359  0.6606319         17              
    ##   0.09544453  8          9.4563443  0.5381277         13              
    ##   0.15934164  4          5.3182797  0.4526872          3              
    ##   0.23062235  3          2.2042970  0.3091873          4              
    ##   0.30861361  5          4.3452149  0.5621675         20              
    ##   0.52052732  7          3.6358938  0.6228069          9              
    ##   0.52310614  1          1.6044475  0.3675567         13              
    ##   0.53085493  9          2.2080442  0.3403656          3              
    ##   0.55692464  1          6.4181113  0.5699536          6              
    ##   0.56878986  8          0.5043435  0.5427443         13              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.5147065  822      0.2870434  0.9840000  0.6654689  0.9533333  0.93 
    ##   0.6985028  510      0.2219314  0.9860000  0.4758968  0.9600000  0.94 
    ##   0.4122969  567      0.2040386  0.9860000  0.6114656  0.9600000  0.94 
    ##   0.7363155   66      0.1601561  0.9846667  0.7313523  0.9600000  0.94 
    ##   0.4145206  479      0.3877680  0.9880000  0.5384444  0.9333333  0.90 
    ##   0.3749733   96      0.2016621  0.9906667  0.3016852  0.9600000  0.94 
    ##   0.7369557  777      0.2055362  0.9846667  0.6036368  0.9533333  0.93 
    ##   0.6415972   44      0.1519773  0.9866667  0.6236667  0.9533333  0.93 
    ##   0.5423490  508      0.1993021  0.9866667  0.3447579  0.9466667  0.92 
    ##   0.9426138  105      0.1797367  0.9860000  0.5612143  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9593098  0.9600000         0.9800000         0.9660317          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9305977  0.9333333         0.9666667         0.9479762          
    ##   0.9593098  0.9600000         0.9800000         0.9660317          
    ##   0.9531313  0.9533333         0.9766667         0.9566667          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9709946            0.9479762       0.9333333    0.3111111          
    ##   0.9817172            0.9660317       0.9600000    0.3200000          
    ##   0.9775758            0.9566667       0.9533333    0.3177778          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.970                 
    ##   0.970                 
    ##   0.970                 
    ##   0.950                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 44, max_depth = 9,
    ##  eta = 0.5308549, gamma = 2.208044, colsample_bytree =
    ##  0.3403656, min_child_weight = 3 and subsample = 0.6415972.
    ## 
    ## $`68_rf_up_center_scale_ignore_Accuracy`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9466667  0.92 
    ##    2    0.9600000  0.94 
    ##    3    0.9533333  0.93 
    ##    4    0.9533333  0.93 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`69_xgbTree_up_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma       colsample_bytree  min_child_weight
    ##   0.07679714   6         3.45905008  0.6990506         17              
    ##   0.09879551  10         2.84835280  0.3438217         12              
    ##   0.16281988   6         0.62415557  0.6397767          5              
    ##   0.16626407   9         1.57437163  0.4609147         12              
    ##   0.18653167   7         3.86278281  0.4130433         13              
    ##   0.21543600   5         9.35232525  0.3107740         15              
    ##   0.26902121   3         8.00661121  0.5112715          2              
    ##   0.29361136  10         4.52793301  0.6978550         19              
    ##   0.43984604  10         0.08058162  0.6451435         15              
    ##   0.45541263   6         1.47998299  0.4737206         12              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6045450  282      0.6136444  0.9686667  0.5133466  0.8733333  0.81 
    ##   0.7755132  345      0.2955228  0.9913333  0.6696349  0.9466667  0.92 
    ##   0.7837174  410      0.1738284  0.9893333  0.6271111  0.9466667  0.92 
    ##   0.3163578  653      0.8475860  0.9153333  0.3385421  0.7666667  0.65 
    ##   0.2625426  762      1.0992872  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.5740249  717      0.5320947  0.9813333  0.4120093  0.9066667  0.86 
    ##   0.9004434  421      0.2853867  0.9900000  0.2817850  0.9533333  0.93 
    ##   0.3196867  316      1.0991560  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.5968259  689      0.4837012  0.9553333  0.4832219  0.9000000  0.85 
    ##   0.4203703  582      0.5104745  0.9546667  0.4535203  0.8533333  0.78 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.8665477  0.8733333         0.9366667         0.9016270          
    ##   0.9454209  0.9466667         0.9733333         0.9565079          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.7635404  0.7666667         0.8833333         0.8293981          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9013540  0.9066667         0.9533333         0.9258730          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.8968013  0.9000000         0.9500000         0.9123016          
    ##   0.8498329  0.8533333         0.9266667         0.8635317          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9458275            0.9016270       0.8733333    0.2911111          
    ##   0.9761616            0.9565079       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9097956            0.8293981       0.7666667    0.2555556          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9601865            0.9258730       0.9066667    0.3022222          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9545034            0.9123016       0.9000000    0.3000000          
    ##   0.9316667            0.8635317       0.8533333    0.2844444          
    ##   Mean_Balanced_Accuracy
    ##   0.905                 
    ##   0.960                 
    ##   0.960                 
    ##   0.825                 
    ##   0.500                 
    ##   0.930                 
    ##   0.965                 
    ##   0.500                 
    ##   0.925                 
    ##   0.890                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 410, max_depth = 6,
    ##  eta = 0.1628199, gamma = 0.6241556, colsample_bytree =
    ##  0.6397767, min_child_weight = 5 and subsample = 0.7837174.
    ## 
    ## $`70_xgbTree_down_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma         colsample_bytree  min_child_weight
    ##   0.08809242  10         8.2056751801  0.4641190          6              
    ##   0.10319878   2         0.2100015339  0.3481472          8              
    ##   0.16700377   4         9.4669227628  0.6852647          9              
    ##   0.17013891  10         0.3038071212  0.6818806          3              
    ##   0.31062089   3         0.8240623795  0.6157133          2              
    ##   0.43803344   6         0.0001099613  0.3620442         14              
    ##   0.46331258   3         1.2930661393  0.4596024         10              
    ##   0.50955328   9         1.8497421104  0.4467608         17              
    ##   0.57799926   9         8.1801533536  0.4934722          5              
    ##   0.58628698   4         7.9319810541  0.5179946          4              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.9900371  740      0.2967533  0.9906667  0.5533333  0.9466667  0.92 
    ##   0.5356134  748      0.2503429  0.9940000  0.7099881  0.9466667  0.92 
    ##   0.9236924  935      0.3126787  0.9900000  0.2078148  0.9400000  0.91 
    ##   0.8580117  353      0.1617054  0.9940000  0.6862294  0.9600000  0.94 
    ##   0.8856134  155      0.1611613  0.9966667  0.6009365  0.9533333  0.93 
    ##   0.3098723  139      1.0997898  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.4880862   75      0.3674466  0.9866667  0.5284630  0.9400000  0.91 
    ##   0.7476076  331      0.4671074  0.9666667  0.4845833  0.8466667  0.77 
    ##   0.2927765  296      0.4673023  0.9880000  0.1874444  0.9533333  0.93 
    ##   0.4887616  259      0.3227356  0.9920000  0.1401111  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9457071  0.9466667         0.9733333         0.9571429          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9389731  0.9400000         0.9700000         0.9515873          
    ##   0.9591751  0.9600000         0.9800000         0.9682540          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9391077  0.9400000         0.9700000         0.9493651          
    ##   0.8381663  0.8466667         0.9233333         0.8657540          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9762626            0.9571429       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9732323            0.9515873       0.9400000    0.3133333          
    ##   0.9823232            0.9682540       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9307456            0.8657540       0.8466667    0.2822222          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.955                 
    ##   0.970                 
    ##   0.965                 
    ##   0.500                 
    ##   0.955                 
    ##   0.885                 
    ##   0.965                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 155, max_depth = 3,
    ##  eta = 0.3106209, gamma = 0.8240624, colsample_bytree =
    ##  0.6157133, min_child_weight = 2 and subsample = 0.8856134.
    ## 
    ## $`71_xgbTree_smote_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.1044003  3          1.0827506  0.6973693          3              
    ##   0.1401327  1          5.4470214  0.5948446         18              
    ##   0.1962707  6          9.3391737  0.4175283          8              
    ##   0.2207797  4          7.9396321  0.6645086          4              
    ##   0.2335025  9          2.7477346  0.4404394         16              
    ##   0.2718008  9          0.8106173  0.6541888          7              
    ##   0.2827898  3          0.3877643  0.3048975          6              
    ##   0.3385495  8          7.9925519  0.5336980         12              
    ##   0.5684560  5          1.5458878  0.5799034          0              
    ##   0.5889252  7          1.7633113  0.5789626         12              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.4498778  330      0.1385510  0.9906667  0.7143788  0.9533333  0.93 
    ##   0.4441995   13      0.4178851  0.9826667  0.4574392  0.9533333  0.93 
    ##   0.6853471  519      0.2226369  0.9940000  0.5964167  0.9400000  0.91 
    ##   0.3407840   31      0.2956315  0.9926667  0.3363889  0.9466667  0.92 
    ##   0.3360731  704      0.3744480  0.9800000  0.5805608  0.9400000  0.91 
    ##   0.2593646  323      0.2227795  0.9873333  0.5873961  0.9600000  0.94 
    ##   0.4716272  455      0.1579903  0.9840000  0.7105783  0.9533333  0.93 
    ##   0.5472981  283      0.2158978  0.9893333  0.2702024  0.9533333  0.93 
    ##   0.8629546  732      0.1554581  0.9906667  0.5243399  0.9466667  0.92 
    ##   0.6231147  232      0.1887364  0.9893333  0.4308995  0.9466667  0.92 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9529966  0.9533333         0.9766667         0.9588889          
    ##   0.9520202  0.9533333         0.9766667         0.9642857          
    ##   0.9391077  0.9400000         0.9700000         0.9493651          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9392424  0.9400000         0.9700000         0.9471429          
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9797980            0.9642857       0.9533333    0.3177778          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9720202            0.9471429       0.9400000    0.3133333          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.965                 
    ##   0.955                 
    ##   0.960                 
    ##   0.955                 
    ##   0.970                 
    ##   0.965                 
    ##   0.965                 
    ##   0.960                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 330, max_depth = 3,
    ##  eta = 0.1044003, gamma = 1.082751, colsample_bytree =
    ##  0.6973693, min_child_weight = 3 and subsample = 0.4498778.
    ## 
    ## $`72_xgbTree_up_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.06118835  10         8.010300  0.6447350          5              
    ##   0.13366803  10         9.444070  0.4466298         13              
    ##   0.14130938   3         3.411456  0.6460579          5              
    ##   0.24060975  10         1.626389  0.5003619         19              
    ##   0.25305518   6         3.255874  0.4842713         10              
    ##   0.28231763   9         9.390287  0.6058024         19              
    ##   0.36147542   7         8.172109  0.3848698          3              
    ##   0.45881386   8         7.249477  0.5115489          9              
    ##   0.48283169   8         7.100266  0.6588138          2              
    ##   0.53491707   9         1.193591  0.3282547          3              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6463226   97      0.3459818  0.9940000  0.3534040  0.9533333  0.93 
    ##   0.4429549  479      0.6146870  0.9860000  0.4564471  0.8666667  0.80 
    ##   0.8449205  600      0.1975113  0.9893333  0.4481667  0.9466667  0.92 
    ##   0.7603895  998      0.5343303  0.9560000  0.4602848  0.8800000  0.82 
    ##   0.7415224  117      0.2715794  0.9853333  0.5630339  0.9333333  0.90 
    ##   0.6473647  166      0.6803745  0.9433333  0.3220847  0.8066667  0.71 
    ##   0.7667083  780      0.2943370  0.9846667  0.3881089  0.9266667  0.89 
    ##   0.4691874  416      0.3484014  0.9866667  0.2575000  0.9400000  0.91 
    ##   0.7566718  946      0.2629864  0.9886667  0.1741389  0.9400000  0.91 
    ##   0.8573895  748      0.1703316  0.9880000  0.6758333  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.8527371  0.8666667         0.9333333         0.8932540          
    ##   0.9452862  0.9466667         0.9733333         0.9587302          
    ##   0.8713277  0.8800000         0.9400000         0.9173280          
    ##   0.9323737  0.9333333         0.9666667         0.9410317          
    ##   0.7828838  0.8066667         0.9033333         0.8485450          
    ##   0.9256397  0.9266667         0.9633333         0.9354762          
    ##   0.9388215  0.9400000         0.9700000         0.9487302          
    ##   0.9389731  0.9400000         0.9700000         0.9488095          
    ##   0.9524411  0.9533333         0.9766667         0.9626984          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9456627            0.8932540       0.8666667    0.2888889          
    ##   0.9767677            0.9587302       0.9466667    0.3155556          
    ##   0.9509657            0.9173280       0.8800000    0.2933333          
    ##   0.9689226            0.9410317       0.9333333    0.3111111          
    ##   0.9230723            0.8485450       0.8066667    0.2688889          
    ##   0.9658923            0.9354762       0.9266667    0.3088889          
    ##   0.9725253            0.9487302       0.9400000    0.3133333          
    ##   0.9725589            0.9488095       0.9400000    0.3133333          
    ##   0.9792929            0.9626984       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.900                 
    ##   0.960                 
    ##   0.910                 
    ##   0.950                 
    ##   0.855                 
    ##   0.945                 
    ##   0.955                 
    ##   0.955                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 748, max_depth = 9,
    ##  eta = 0.5349171, gamma = 1.193591, colsample_bytree =
    ##  0.3282547, min_child_weight = 3 and subsample = 0.8573895.
    ## 
    ## $`73_xgbTree_down_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma       colsample_bytree  min_child_weight
    ##   0.08061082   5         2.58494277  0.5649485         13              
    ##   0.08092330  10         6.32256319  0.6636697         20              
    ##   0.14194862   9         0.04869052  0.4127050         12              
    ##   0.16090168   5         6.52716701  0.6972769         11              
    ##   0.16558239   5         0.31172497  0.3102848         10              
    ##   0.20233384   7         5.19521673  0.4428835         16              
    ##   0.23645137   6         4.88584352  0.3080061          4              
    ##   0.39156295   6         0.82946260  0.6306322          3              
    ##   0.46927568   6         1.26465500  0.4769778         12              
    ##   0.47355036  10         2.25558818  0.3539293          1              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.8498066   15      0.4342546  0.9900000  0.5181587  0.9400000  0.91 
    ##   0.4927142   54      1.0987481  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.3973226  232      0.6220150  0.9660000  0.5321771  0.8733333  0.81 
    ##   0.7984823   40      0.2850815  0.9873333  0.3845375  0.9533333  0.93 
    ##   0.5247511  199      0.3379564  0.9793333  0.6209862  0.9466667  0.92 
    ##   0.9579428  768      0.3253810  0.9913333  0.5769709  0.9533333  0.93 
    ##   0.2989947  329      0.3561690  0.9873333  0.4505079  0.9400000  0.91 
    ##   0.6832081  558      0.1532308  0.9900000  0.5931248  0.9400000  0.91 
    ##   0.4531894  643      0.4877043  0.9540000  0.4689481  0.8733333  0.81 
    ##   0.7589756  239      0.1608662  0.9933333  0.5898889  0.9466667  0.92 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9395286  0.9400000         0.9700000         0.9450000          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.8659753  0.8733333         0.9366667         0.8983730          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##   0.9463973  0.9466667         0.9733333         0.9483333          
    ##   0.9525758  0.9533333         0.9766667         0.9604762          
    ##   0.9392424  0.9400000         0.9700000         0.9471429          
    ##   0.9388215  0.9400000         0.9700000         0.9487302          
    ##   0.8675806  0.8733333         0.9366667         0.8903439          
    ##   0.9465320  0.9466667         0.9733333         0.9488889          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9454571            0.8983730       0.8733333    0.2911111          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9738721            0.9483333       0.9466667    0.3155556          
    ##   0.9786869            0.9604762       0.9533333    0.3177778          
    ##   0.9720202            0.9471429       0.9400000    0.3133333          
    ##   0.9725253            0.9487302       0.9400000    0.3133333          
    ##   0.9418651            0.8903439       0.8733333    0.2911111          
    ##   0.9739394            0.9488889       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.955                 
    ##   0.500                 
    ##   0.905                 
    ##   0.965                 
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.955                 
    ##   0.905                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 558, max_depth = 6,
    ##  eta = 0.391563, gamma = 0.8294626, colsample_bytree =
    ##  0.6306322, min_child_weight = 3 and subsample = 0.6832081.
    ## 
    ## $`74_xgbTree_smote_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.08392365   2         4.0885515  0.5530213         18              
    ##   0.10627085   5         9.7664267  0.3042507          3              
    ##   0.16774697   5         8.2877220  0.4999599          5              
    ##   0.18311111   2         0.7325850  0.4252894          4              
    ##   0.21701939   1         0.1437945  0.3606564          7              
    ##   0.38328808   2         2.2652616  0.3392443         15              
    ##   0.44986129   9         2.6610265  0.6533824         17              
    ##   0.48758133  10         2.5214148  0.4774016          4              
    ##   0.50254068   4         5.4124344  0.6592041          6              
    ##   0.58164617   9         6.0980736  0.5181328         12              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.2725230  580      0.6013855  0.9680000  0.5894643  0.8733333  0.81 
    ##   0.5994505  816      0.2448766  0.9913333  0.5777698  0.9533333  0.93 
    ##   0.8199521  442      0.2227926  0.9866667  0.5757381  0.9400000  0.91 
    ##   0.8003048  987      0.1483827  0.9880000  0.7552186  0.9600000  0.94 
    ##   0.8410956  800      0.1773160  0.9860000  0.7403161  0.9466667  0.92 
    ##   0.4889788  826      0.2516554  0.9820000  0.5829108  0.9400000  0.91 
    ##   0.8820809  133      0.1972530  0.9926667  0.4867778  0.9400000  0.91 
    ##   0.9326889  670      0.1431900  0.9866667  0.6836035  0.9466667  0.92 
    ##   0.7538141  707      0.1612311  0.9906667  0.2116746  0.9533333  0.93 
    ##   0.9141440  346      0.1688718  0.9900000  0.3753254  0.9533333  0.93 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.8937149  0.8733333         0.9366667         0.9084656          
    ##   0.9527104  0.9533333         0.9766667         0.9582540          
    ##   0.9393771  0.9400000         0.9700000         0.9449206          
    ##   0.9598653  0.9600000         0.9800000         0.9622222          
    ##   0.9462626  0.9466667         0.9733333         0.9477778          
    ##   0.9396633  0.9400000         0.9700000         0.9427778          
    ##   0.9396633  0.9400000         0.9700000         0.9455556          
    ##   0.9462626  0.9466667         0.9733333         0.9505556          
    ##   0.9532660  0.9533333         0.9766667         0.9544444          
    ##   0.9524411  0.9533333         0.9766667         0.9599206          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9461953            0.9084656       0.8733333    0.2911111          
    ##   0.9780808            0.9582540       0.9533333    0.3177778          
    ##   0.9714141            0.9449206       0.9400000    0.3133333          
    ##   0.9806061            0.9622222       0.9600000    0.3200000          
    ##   0.9738047            0.9477778       0.9466667    0.3155556          
    ##   0.9708418            0.9427778       0.9400000    0.3133333          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9769697            0.9544444       0.9533333    0.3177778          
    ##   0.9786195            0.9599206       0.9533333    0.3177778          
    ##   Mean_Balanced_Accuracy
    ##   0.905                 
    ##   0.965                 
    ##   0.955                 
    ##   0.970                 
    ##   0.960                 
    ##   0.955                 
    ##   0.955                 
    ##   0.960                 
    ##   0.965                 
    ##   0.965                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 670, max_depth =
    ##  10, eta = 0.4875813, gamma = 2.521415, colsample_bytree =
    ##  0.4774016, min_child_weight = 4 and subsample = 0.9326889.
    ## 
    ## $`75_rf_down_center_scale_ignore_Accuracy`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9333333  0.90 
    ##    2    0.9400000  0.91 
    ##    3    0.9400000  0.91 
    ##    4    0.9400000  0.91 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`76_xgbTree_up_center_scale_ignore_Accuracy`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta          max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.007197151  1          0.7537243  0.3249564          7              
    ##   0.051918530  8          3.6714157  0.6729646          7              
    ##   0.116556008  7          2.3301342  0.5203881         10              
    ##   0.151592050  6          3.0171335  0.4157416         16              
    ##   0.236554432  5          3.2798069  0.6345319         20              
    ##   0.298182203  9          6.1629241  0.5261419         15              
    ##   0.299564148  9          1.6686567  0.3244383         19              
    ##   0.431651242  3          3.5050640  0.6735275         14              
    ##   0.478822647  3          7.6112002  0.6374092          5              
    ##   0.521503184  5          7.2127554  0.4900766          3              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.3120868   87      0.9200000  0.88 
    ##   0.8294789  758      0.9533333  0.93 
    ##   0.7433008  143      0.9333333  0.90 
    ##   0.4790736  991      0.8333333  0.75 
    ##   0.8111834  548      0.9000000  0.85 
    ##   0.5462849  888      0.8866667  0.83 
    ##   0.2644786  559      0.3333333  0.00 
    ##   0.3828410   74      0.6466667  0.47 
    ##   0.5456732  680      0.9466667  0.92 
    ##   0.7164638  309      0.9466667  0.92 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 758, max_depth = 8,
    ##  eta = 0.05191853, gamma = 3.671416, colsample_bytree =
    ##  0.6729646, min_child_weight = 7 and subsample = 0.8294789.
    ## 
    ## $`77_xgbTree_down_center_scale_ignore_Accuracy`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.0910314   1         3.628095  0.4720691         15              
    ##   0.1258026   3         7.567689  0.6220617         17              
    ##   0.1487173   2         7.057589  0.4530419          4              
    ##   0.1594589   5         2.796545  0.6412727          4              
    ##   0.1958673   3         5.782795  0.5285112          7              
    ##   0.2267639  10         2.360814  0.5072708          3              
    ##   0.2487977   1         2.297137  0.3246502         16              
    ##   0.3910595  10         4.026326  0.5647506          1              
    ##   0.4544462   8         1.405832  0.6188143         14              
    ##   0.5179775  10         9.293311  0.4928403         13              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.7416362  928      0.9533333  0.93 
    ##   0.7935345  352      0.9266667  0.89 
    ##   0.2765360  936      0.9533333  0.93 
    ##   0.8316447  378      0.9533333  0.93 
    ##   0.9979966  454      0.9466667  0.92 
    ##   0.8467192  644      0.9533333  0.93 
    ##   0.7088739  201      0.9200000  0.88 
    ##   0.7810665  717      0.9466667  0.92 
    ##   0.9666887  866      0.9200000  0.88 
    ##   0.6922868  975      0.9466667  0.92 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 378, max_depth = 5,
    ##  eta = 0.1594589, gamma = 2.796545, colsample_bytree =
    ##  0.6412727, min_child_weight = 4 and subsample = 0.8316447.
    ## 
    ## $`78_xgbTree_smote_center_scale_ignore_Accuracy`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.01046016   3         6.475696  0.5673195         14              
    ##   0.03457191   9         7.626895  0.3236170          4              
    ##   0.03467552   8         1.704382  0.5920545          2              
    ##   0.11132244  10         5.761194  0.4976062         20              
    ##   0.13225047   9         1.567260  0.5762311          5              
    ##   0.13522966   8         9.279105  0.4622737         11              
    ##   0.25087908   7         6.669634  0.4350663          4              
    ##   0.39797412   2         5.270653  0.5508534         20              
    ##   0.51411112   6         4.550411  0.5637687         19              
    ##   0.55362912   5         6.156018  0.5836972         10              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.5506944  587      0.9466667  0.92 
    ##   0.4995951  353      0.9600000  0.94 
    ##   0.8452255  213      0.9666667  0.95 
    ##   0.3848943  101      0.9266667  0.89 
    ##   0.4190964  836      0.9400000  0.91 
    ##   0.7478293  107      0.9533333  0.93 
    ##   0.8527888  984      0.9600000  0.94 
    ##   0.8727175  428      0.9600000  0.94 
    ##   0.8589031  428      0.9533333  0.93 
    ##   0.3812043  935      0.9533333  0.93 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 213, max_depth = 8,
    ##  eta = 0.03467552, gamma = 1.704382, colsample_bytree =
    ##  0.5920545, min_child_weight = 2 and subsample = 0.8452255.
    ## 
    ## $`79_xgbTree_up_center_scale_ignore_Kappa`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.0846476  7          3.4749771  0.3004973          9              
    ##   0.1765531  4          3.3045303  0.5103993          9              
    ##   0.2147205  9          1.0499941  0.3783441          4              
    ##   0.2210476  1          0.1196085  0.6988883          0              
    ##   0.2543210  6          3.1299276  0.5634506          9              
    ##   0.3194816  9          1.7552308  0.3105342          4              
    ##   0.3385963  3          9.8176875  0.4649259         17              
    ##   0.5560383  4          8.0694684  0.3721173         14              
    ##   0.5565639  5          8.2755434  0.3288977          2              
    ##   0.5869358  9          0.8287797  0.4133708         20              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.6800086  652      0.9600000  0.94 
    ##   0.9528743  689      0.9333333  0.90 
    ##   0.9721741  699      0.9466667  0.92 
    ##   0.6400155  922      0.9400000  0.91 
    ##   0.4461656  120      0.9533333  0.93 
    ##   0.8500604  192      0.9600000  0.94 
    ##   0.5944375  633      0.8800000  0.82 
    ##   0.3815287   24      0.4533333  0.18 
    ##   0.8950544  826      0.9400000  0.91 
    ##   0.6389890  743      0.8066667  0.71 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 192, max_depth = 9,
    ##  eta = 0.3194816, gamma = 1.755231, colsample_bytree =
    ##  0.3105342, min_child_weight = 4 and subsample = 0.8500604.
    ## 
    ## $`80_xgbTree_down_center_scale_ignore_Kappa`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.03830604   1         2.7315305  0.4114250          9              
    ##   0.16075994   7         0.1691309  0.5665999         15              
    ##   0.21063282   2         6.2429227  0.6768615         12              
    ##   0.28131594   4         0.2732952  0.3825514         20              
    ##   0.29220087   3         6.8745560  0.4278071         14              
    ##   0.30718079   6         3.6310421  0.6277714          0              
    ##   0.31569402   1         4.4926747  0.6951173          5              
    ##   0.31877368  10         6.6607938  0.4395008          1              
    ##   0.48063072   8         8.3109185  0.4716291          3              
    ##   0.50305939   6         5.1374075  0.4666909          8              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.9327957  300      0.9400000  0.91 
    ##   0.6478413  520      0.9066667  0.86 
    ##   0.6535730  213      0.9600000  0.94 
    ##   0.5436269  267      0.3866667  0.08 
    ##   0.7700209  892      0.9600000  0.94 
    ##   0.8251955  442      0.9466667  0.92 
    ##   0.5550232  805      0.9466667  0.92 
    ##   0.5742196  141      0.9600000  0.94 
    ##   0.4509303  138      0.9533333  0.93 
    ##   0.6375803  607      0.9533333  0.93 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 141, max_depth =
    ##  10, eta = 0.3187737, gamma = 6.660794, colsample_bytree =
    ##  0.4395008, min_child_weight = 1 and subsample = 0.5742196.
    ## 
    ## $`81_xgbTree_smote_center_scale_ignore_Kappa`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.01577306   6         5.146963  0.6463264         15              
    ##   0.06080005   6         4.679627  0.5224421         18              
    ##   0.19734906   1         8.125592  0.4499746          0              
    ##   0.22171691   5         5.709033  0.5148860         16              
    ##   0.27245948   8         2.515852  0.5449236         20              
    ##   0.28202071   1         4.944401  0.6361081          1              
    ##   0.38481254   2         5.753888  0.6367432          9              
    ##   0.39407208  10         7.450093  0.3359475         10              
    ##   0.42093056   4         6.841863  0.4603674          9              
    ##   0.49707879   2         2.566466  0.4433417          8              
    ##   subsample  nrounds  Accuracy   Kappa
    ##   0.5387405  668      0.9600000  0.94 
    ##   0.5933934  406      0.9533333  0.93 
    ##   0.5404422  211      0.9400000  0.91 
    ##   0.6086528  842      0.9533333  0.93 
    ##   0.9878323  481      0.9466667  0.92 
    ##   0.8828356   29      0.9600000  0.94 
    ##   0.8097595  556      0.9533333  0.93 
    ##   0.6797143  226      0.9533333  0.93 
    ##   0.5119351  605      0.9466667  0.92 
    ##   0.3395818  708      0.9400000  0.91 
    ## 
    ## Kappa was used to select the optimal model using the largest value.
    ## The final values used for the model were nrounds = 29, max_depth = 1,
    ##  eta = 0.2820207, gamma = 4.944401, colsample_bytree =
    ##  0.6361081, min_child_weight = 1 and subsample = 0.8828356.
    ## 
    ## $`82_xgbTree_up_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.1388809   3         5.955362  0.5849898          5              
    ##   0.1537872   9         4.347723  0.3193375         17              
    ##   0.1728224   5         1.911082  0.5838075         13              
    ##   0.2186833  10         8.551929  0.5605444          5              
    ##   0.2480394   6         7.878192  0.6334121         12              
    ##   0.2550822   8         9.761854  0.3810816          0              
    ##   0.2871994   7         5.960339  0.4810414          1              
    ##   0.3969319  10         7.480943  0.5230883          6              
    ##   0.5556354   4         5.340683  0.4521864          4              
    ##   0.5854146   5         8.076015  0.3296669          5              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6026610  893      0.2744858  0.9906667  0.3311402  0.9533333  0.93 
    ##   0.3467158  134      1.0990439  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.2519020  132      1.0992815  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.4490877  380      0.3861478  0.9940000  0.1803810  0.9666667  0.95 
    ##   0.4852002  382      0.4569275  0.9840000  0.4141281  0.9266667  0.89 
    ##   0.3065502  891      0.5290423  0.9913333  0.1431944  0.9666667  0.95 
    ##   0.9241088   65      0.2590403  0.9893333  0.5430926  0.9466667  0.92 
    ##   0.4094943  287      0.3855502  0.9820000  0.2005527  0.9533333  0.93 
    ##   0.7922793  856      0.2419286  0.9853333  0.3990569  0.9400000  0.91 
    ##   0.8578919  250      0.2646927  0.9900000  0.3036323  0.9466667  0.92 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9528620  0.9533333         0.9766667         0.9583333          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9659091  0.9666667         0.9833333         0.9738095          
    ##   0.9242256  0.9266667         0.9633333         0.9409524          
    ##   0.9659091  0.9666667         0.9833333         0.9738095          
    ##   0.9452862  0.9466667         0.9733333         0.9559524          
    ##   0.9524411  0.9533333         0.9766667         0.9599206          
    ##   0.9393939  0.9400000         0.9700000         0.9472222          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9781145            0.9583333       0.9533333    0.3177778          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9853535            0.9738095       0.9666667    0.3222222          
    ##   0.9678788            0.9409524       0.9266667    0.3088889          
    ##   0.9853535            0.9738095       0.9666667    0.3222222          
    ##   0.9760943            0.9559524       0.9466667    0.3155556          
    ##   0.9786195            0.9599206       0.9533333    0.3177778          
    ##   0.9720539            0.9472222       0.9400000    0.3133333          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.500                 
    ##   0.500                 
    ##   0.975                 
    ##   0.945                 
    ##   0.975                 
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.960                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 856, max_depth = 4,
    ##  eta = 0.5556354, gamma = 5.340683, colsample_bytree =
    ##  0.4521864, min_child_weight = 4 and subsample = 0.7922793.
    ## 
    ## $`83_xgbTree_down_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.09206976  10         4.2243853  0.4541813          3              
    ##   0.11198851  10         4.4147238  0.4796879          2              
    ##   0.20282569   7         4.4395848  0.6471912          3              
    ##   0.21034721   1         4.9783199  0.5400968          5              
    ##   0.24533764   4         0.5581937  0.5272064         19              
    ##   0.29121150   6         4.3115777  0.3473085         10              
    ##   0.31908264   5         9.0054663  0.3335191         16              
    ##   0.52322057   2         3.4882961  0.5428025          0              
    ##   0.55675865   7         7.5989179  0.4613484         20              
    ##   0.57996485  10         3.8030698  0.6126855          6              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.6935554  471      0.2229986  0.9893333  0.6397328  0.9600000  0.94 
    ##   0.5942913  163      0.2448730  0.9906667  0.6371818  0.9600000  0.94 
    ##   0.4732522  451      0.2507792  0.9926667  0.3133135  0.9466667  0.92 
    ##   0.2611940  185      0.4300671  0.9893333  0.2948995  0.9333333  0.90 
    ##   0.9542316  578      0.4058171  0.9786667  0.4880984  0.9333333  0.90 
    ##   0.9316949  839      0.2310023  0.9840000  0.5452267  0.9600000  0.94 
    ##   0.7397966  681      0.4305628  0.9920000  0.3581389  0.9200000  0.88 
    ##   0.3472747  177      0.2347356  0.9926667  0.3674550  0.9466667  0.92 
    ##   0.3446509  664      1.1021564  0.5000000  0.0000000  0.3333333  0.00 
    ##   0.8190706  391      0.2049596  0.9920000  0.3920913  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9462626  0.9466667         0.9733333         0.9505556          
    ##   0.9329293  0.9333333         0.9666667         0.9400000          
    ##   0.9329293  0.9333333         0.9666667         0.9400000          
    ##   0.9597306  0.9600000         0.9800000         0.9644444          
    ##   0.9168687  0.9200000         0.9600000         0.9272222          
    ##   0.9463973  0.9466667         0.9733333         0.9511111          
    ##         NaN  0.3333333         0.6666667               NaN          
    ##   0.9395286  0.9400000         0.9700000         0.9450000          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9684848            0.9400000       0.9333333    0.3111111          
    ##   0.9684848            0.9400000       0.9333333    0.3111111          
    ##   0.9812121            0.9644444       0.9600000    0.3200000          
    ##   0.9637374            0.9272222       0.9200000    0.3066667          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##         NaN                  NaN       0.3333333    0.1111111          
    ##   0.9714478            0.9450000       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.970                 
    ##   0.970                 
    ##   0.960                 
    ##   0.950                 
    ##   0.950                 
    ##   0.970                 
    ##   0.940                 
    ##   0.960                 
    ##   0.500                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 391, max_depth =
    ##  10, eta = 0.5799649, gamma = 3.80307, colsample_bytree =
    ##  0.6126855, min_child_weight = 6 and subsample = 0.8190706.
    ## 
    ## $`84_xgbTree_smote_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.02911890   6         7.2396037  0.3928444         19              
    ##   0.04134276   7         0.7513917  0.4451775          1              
    ##   0.06710741   1         6.8279234  0.3754771          0              
    ##   0.11688696   2         4.3346785  0.5488866         20              
    ##   0.14731836   7         3.1083080  0.4070282         13              
    ##   0.23566345   6         7.9694088  0.4572697         11              
    ##   0.37041689   1         9.1038026  0.6393726         14              
    ##   0.37411380  10         6.5937772  0.4868668          8              
    ##   0.37476209   1         0.2522892  0.3215667         17              
    ##   0.52685771   3         2.9123280  0.4692544          5              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.5931709  771      0.2870067  0.9860000  0.7120622  0.9466667  0.92 
    ##   0.7333770  711      0.1838492  0.9860000  0.7731235  0.9466667  0.92 
    ##   0.4229686  937      0.2685509  0.9840000  0.6208439  0.9333333  0.90 
    ##   0.9208558  622      0.2098668  0.9906667  0.4647037  0.9400000  0.91 
    ##   0.4731179  278      0.2497016  0.9926667  0.6748148  0.9333333  0.90 
    ##   0.7666814  514      0.2141175  0.9880000  0.5674696  0.9466667  0.92 
    ##   0.6277230  367      0.2449858  0.9906667  0.2916190  0.9400000  0.91 
    ##   0.2816010  344      0.2630022  0.9886667  0.3706481  0.9533333  0.93 
    ##   0.7984903   19      0.2333134  0.9866667  0.6600741  0.9466667  0.92 
    ##   0.7992996  903      0.1675125  0.9886667  0.6671746  0.9400000  0.91 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9444866  0.9466667         0.9733333         0.9575000          
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9311533  0.9333333         0.9666667         0.9441667          
    ##   0.9378873  0.9400000         0.9700000         0.9497222          
    ##   0.9311533  0.9333333         0.9666667         0.9441667          
    ##   0.9459764  0.9466667         0.9733333         0.9526984          
    ##   0.9378873  0.9400000         0.9700000         0.9497222          
    ##   0.9512206  0.9533333         0.9766667         0.9630556          
    ##   0.9444866  0.9466667         0.9733333         0.9575000          
    ##   0.9391077  0.9400000         0.9700000         0.9493651          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9765501            0.9575000       0.9466667    0.3155556          
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9698834            0.9441667       0.9333333    0.3111111          
    ##   0.9729138            0.9497222       0.9400000    0.3133333          
    ##   0.9698834            0.9441667       0.9333333    0.3111111          
    ##   0.9750505            0.9526984       0.9466667    0.3155556          
    ##   0.9729138            0.9497222       0.9400000    0.3133333          
    ##   0.9795804            0.9630556       0.9533333    0.3177778          
    ##   0.9765501            0.9575000       0.9466667    0.3155556          
    ##   0.9726263            0.9493651       0.9400000    0.3133333          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.960                 
    ##   0.950                 
    ##   0.955                 
    ##   0.950                 
    ##   0.960                 
    ##   0.955                 
    ##   0.965                 
    ##   0.960                 
    ##   0.955                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 903, max_depth = 3,
    ##  eta = 0.5268577, gamma = 2.912328, colsample_bytree =
    ##  0.4692544, min_child_weight = 5 and subsample = 0.7992996.
    ## 
    ## $`85_xgbTree_up_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using up-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta        max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.0898580   8         4.2481557  0.6433436         11              
    ##   0.1166365   2         2.7533052  0.5964268         14              
    ##   0.2011355   7         9.0182556  0.3947872         16              
    ##   0.2896607   8         1.9663227  0.6157423         13              
    ##   0.3208312   9         2.7031741  0.3334794          7              
    ##   0.3419759   8         1.5981913  0.3588715          7              
    ##   0.3529619   4         0.8863992  0.6286353          2              
    ##   0.3616790   9         3.7397052  0.4716542         15              
    ##   0.3692793   6         5.4284910  0.6234242         16              
    ##   0.5340401  10         1.2666568  0.3056820          0              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.7666666  538      0.2705920  0.9893333  0.4872222  0.9600000  0.94 
    ##   0.7624970  498      0.3460625  0.9886667  0.5260000  0.9533333  0.93 
    ##   0.6493999  734      0.5110511  0.9786667  0.4648214  0.9000000  0.85 
    ##   0.3319070  968      0.8567986  0.8820000  0.2989531  0.7466667  0.62 
    ##   0.9400817  859      0.2071644  0.9893333  0.6265613  0.9600000  0.94 
    ##   0.9121103  788      0.2087577  0.9860000  0.6214921  0.9466667  0.92 
    ##   0.7008902  261      0.1716478  0.9906667  0.5540598  0.9533333  0.93 
    ##   0.9972253  985      0.3060328  0.9846667  0.5336619  0.9333333  0.90 
    ##   0.6742486  284      0.4750298  0.9686667  0.4732976  0.9133333  0.87 
    ##   0.8129723  497      0.1660508  0.9900000  0.6751111  0.9666667  0.95 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.8951756  0.9000000         0.9500000         0.9165079          
    ##   0.7353644  0.7466667         0.8733333         0.8149636          
    ##   0.9595960  0.9600000         0.9800000         0.9666667          
    ##   0.9461279  0.9466667         0.9733333         0.9555556          
    ##   0.9528620  0.9533333         0.9766667         0.9611111          
    ##   0.9323737  0.9333333         0.9666667         0.9438095          
    ##   0.9107407  0.9133333         0.9566667         0.9255556          
    ##   0.9663300  0.9666667         0.9833333         0.9722222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9560451            0.9165079       0.9000000    0.3000000          
    ##   0.9034776            0.8149636       0.7466667    0.2488889          
    ##   0.9818182            0.9666667       0.9600000    0.3200000          
    ##   0.9757576            0.9555556       0.9466667    0.3155556          
    ##   0.9787879            0.9611111       0.9533333    0.3177778          
    ##   0.9695960            0.9438095       0.9333333    0.3111111          
    ##   0.9610101            0.9255556       0.9133333    0.3044444          
    ##   0.9848485            0.9722222       0.9666667    0.3222222          
    ##   Mean_Balanced_Accuracy
    ##   0.970                 
    ##   0.965                 
    ##   0.925                 
    ##   0.810                 
    ##   0.970                 
    ##   0.960                 
    ##   0.965                 
    ##   0.950                 
    ##   0.935                 
    ##   0.975                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 497, max_depth =
    ##  10, eta = 0.5340401, gamma = 1.266657, colsample_bytree =
    ##  0.305682, min_child_weight = 0 and subsample = 0.8129723.
    ## 
    ## $`86_xgbTree_down_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using down-sampling prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma     colsample_bytree  min_child_weight
    ##   0.04127460   7         4.439470  0.6539961          1              
    ##   0.07036760   2         3.466033  0.4360968         14              
    ##   0.07522631   5         1.777239  0.4482443         15              
    ##   0.08756956   9         8.762193  0.6132994         17              
    ##   0.09345269   3         4.684225  0.3181939          7              
    ##   0.11511415   5         5.480428  0.5371404          7              
    ##   0.14617628   7         3.410177  0.5981696         18              
    ##   0.16705043   3         5.373987  0.4661775         12              
    ##   0.27234896  10         1.012380  0.3871026         17              
    ##   0.36236869   1         3.235187  0.3956206         13              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.8252415  931      0.2196169  0.9880000  0.5773936  0.9533333  0.93 
    ##   0.8789530  913      0.3090693  0.9893333  0.6356474  0.9333333  0.90 
    ##   0.9339287  639      0.3279687  0.9833333  0.6066714  0.9333333  0.90 
    ##   0.5008285  987      0.8205034  0.9353333  0.3377302  0.8066667  0.71 
    ##   0.8651732  291      0.2299387  0.9880000  0.6467328  0.9466667  0.92 
    ##   0.8680104  564      0.2389894  0.9900000  0.3672884  0.9466667  0.92 
    ##   0.7702796  357      0.4821382  0.9820000  0.5214761  0.9066667  0.86 
    ##   0.9992501  370      0.2709127  0.9886667  0.5647665  0.9466667  0.92 
    ##   0.6648086  384      0.5328704  0.9413333  0.4737769  0.8733333  0.81 
    ##   0.9701819  111      0.2836838  0.9846667  0.5578730  0.9600000  0.94 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9529966  0.9533333         0.9766667         0.9561111          
    ##   0.9325084  0.9333333         0.9666667         0.9415873          
    ##   0.9326431  0.9333333         0.9666667         0.9393651          
    ##   0.8233047  0.8066667         0.9033333         0.8816468          
    ##   0.9463973  0.9466667         0.9733333         0.9511111          
    ##   0.9462626  0.9466667         0.9733333         0.9505556          
    ##   0.9018422  0.9066667         0.9533333         0.9231746          
    ##   0.9459764  0.9466667         0.9733333         0.9526984          
    ##   0.8716835  0.8733333         0.9366667         0.8811111          
    ##   0.9598653  0.9600000         0.9800000         0.9622222          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9775084            0.9561111       0.9533333    0.3177778          
    ##   0.9689899            0.9415873       0.9333333    0.3111111          
    ##   0.9683838            0.9393651       0.9333333    0.3111111          
    ##   0.9268942            0.8816468       0.8066667    0.2688889          
    ##   0.9745455            0.9511111       0.9466667    0.3155556          
    ##   0.9744781            0.9505556       0.9466667    0.3155556          
    ##   0.9593784            0.9231746       0.9066667    0.3022222          
    ##   0.9750505            0.9526984       0.9466667    0.3155556          
    ##   0.9391246            0.8811111       0.8733333    0.2911111          
    ##   0.9806061            0.9622222       0.9600000    0.3200000          
    ##   Mean_Balanced_Accuracy
    ##   0.965                 
    ##   0.950                 
    ##   0.950                 
    ##   0.855                 
    ##   0.960                 
    ##   0.960                 
    ##   0.930                 
    ##   0.960                 
    ##   0.905                 
    ##   0.970                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 931, max_depth = 7,
    ##  eta = 0.0412746, gamma = 4.43947, colsample_bytree =
    ##  0.6539961, min_child_weight = 1 and subsample = 0.8252415.
    ## 
    ## $`87_xgbTree_smote_center_scale_ignore_logLoss`
    ## eXtreme Gradient Boosting 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   eta         max_depth  gamma      colsample_bytree  min_child_weight
    ##   0.03923191   8         9.6250708  0.4203633          7              
    ##   0.12293551   4         4.2172459  0.5109532         12              
    ##   0.13985444   2         0.5026075  0.6374669         13              
    ##   0.28629005   9         4.3082141  0.5106771         10              
    ##   0.28783528   1         4.1678688  0.6336721         12              
    ##   0.29819855   2         5.7174305  0.4080101          2              
    ##   0.30641575  10         9.1512541  0.5101237         13              
    ##   0.32042545   3         0.2623759  0.6236555         19              
    ##   0.45654171   5         7.1199343  0.3363374         12              
    ##   0.58880982   3         6.1210720  0.4588169         17              
    ##   subsample  nrounds  logLoss    AUC        prAUC      Accuracy   Kappa
    ##   0.8390924  938      0.2301019  0.9880000  0.6635851  0.9466667  0.92 
    ##   0.2686116  113      0.3590800  0.9920000  0.6387579  0.9533333  0.93 
    ##   0.5219491  355      0.2204612  0.9873333  0.6150375  0.9400000  0.91 
    ##   0.8058500  243      0.1660118  0.9906667  0.4810455  0.9400000  0.91 
    ##   0.4581204  802      0.2251422  0.9920000  0.5511772  0.9533333  0.93 
    ##   0.5238490  832      0.1931741  0.9893333  0.6162778  0.9400000  0.91 
    ##   0.6402174  271      0.2289511  0.9873333  0.3351825  0.9333333  0.90 
    ##   0.7468125  690      0.2250932  0.9886667  0.5599696  0.9400000  0.91 
    ##   0.8616268  118      0.1920260  0.9913333  0.5499550  0.9333333  0.90 
    ##   0.2700685  477      0.5201090  0.9653333  0.3612400  0.8800000  0.82 
    ##   Mean_F1    Mean_Sensitivity  Mean_Specificity  Mean_Pos_Pred_Value
    ##   0.9458418  0.9466667         0.9733333         0.9549206          
    ##   0.9529966  0.9533333         0.9766667         0.9588889          
    ##   0.9396633  0.9400000         0.9700000         0.9455556          
    ##   0.9392424  0.9400000         0.9700000         0.9471429          
    ##   0.9520202  0.9533333         0.9766667         0.9579365          
    ##   0.9396633  0.9400000         0.9700000         0.9455556          
    ##   0.9326431  0.9333333         0.9666667         0.9393651          
    ##   0.9386869  0.9400000         0.9700000         0.9446032          
    ##   0.9308839  0.9333333         0.9666667         0.9458333          
    ##   0.8749904  0.8800000         0.9400000         0.9013492          
    ##   Mean_Neg_Pred_Value  Mean_Precision  Mean_Recall  Mean_Detection_Rate
    ##   0.9756566            0.9549206       0.9466667    0.3155556          
    ##   0.9781818            0.9588889       0.9533333    0.3177778          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9720202            0.9471429       0.9400000    0.3133333          
    ##   0.9784091            0.9579365       0.9533333    0.3177778          
    ##   0.9715152            0.9455556       0.9400000    0.3133333          
    ##   0.9683838            0.9393651       0.9333333    0.3111111          
    ##   0.9717424            0.9446032       0.9400000    0.3133333          
    ##   0.9704222            0.9458333       0.9333333    0.3111111          
    ##   0.9470888            0.9013492       0.8800000    0.2933333          
    ##   Mean_Balanced_Accuracy
    ##   0.960                 
    ##   0.965                 
    ##   0.955                 
    ##   0.955                 
    ##   0.965                 
    ##   0.955                 
    ##   0.950                 
    ##   0.955                 
    ##   0.950                 
    ##   0.910                 
    ## 
    ## logLoss was used to select the optimal model using the smallest value.
    ## The final values used for the model were nrounds = 243, max_depth = 9,
    ##  eta = 0.2862901, gamma = 4.308214, colsample_bytree =
    ##  0.5106771, min_child_weight = 10 and subsample = 0.80585.
    ## 
    ## $`88_rf_smote_center_scale_ignore_Accuracy`
    ## Random Forest 
    ## 
    ## 150 samples
    ##   4 predictors
    ##   3 classes: 'setosa', 'versicolor', 'virginica' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 1 times) 
    ## Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
    ## Addtional sampling using SMOTE prior to pre-processing
    ## 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa
    ##    1    0.9600000  0.94 
    ##    2    0.9466667  0.92 
    ##    3    0.9533333  0.93 
    ##    4    0.9466667  0.92 
    ##   NA          NaN   NaN 
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 1.

Then, we want to choose models with a median Kappa value in cross-validation bigger than 0.85 and visualize the end results.

``` r
library(magrittr)
iris_list = iris_list %>% ml_cv_filter(metric = "Kappa",min = 0.85,FUN = median) %>% ml_bwplot()
```

    ## [1] "using mini"
    ##     3_LogitBoost_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##   4_LogitBoost_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##  5_LogitBoost_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##        6_LogitBoost_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##     7_LogitBoost_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##               11_rf_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##             18_rf_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##    19_LogitBoost_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##  20_LogitBoost_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ## 21_LogitBoost_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##       22_LogitBoost_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##     23_LogitBoost_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##    24_LogitBoost_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            31_rf_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            43_rf_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          44_rf_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##         45_rf_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##               46_rf_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##             47_rf_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            48_rf_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##       59_xgbTree_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##     60_xgbTree_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##    61_xgbTree_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          62_xgbTree_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##        63_xgbTree_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##       64_xgbTree_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            68_rf_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          75_rf_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##       76_xgbTree_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##     77_xgbTree_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##    78_xgbTree_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          79_xgbTree_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##        80_xgbTree_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##       81_xgbTree_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##         88_rf_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE

![](README_with_results_files/figure-markdown_github/unnamed-chunk-8-1.png)

This function also prints out whether each model satisfies the condition or not.

Then, we want to choose models with a minimum of Accuracy in cross-validation bigger than 0.87 and visualize the end results.

``` r
iris_list = iris_list %>% ml_cv_filter(metric = "Accuracy",min = 0.87,FUN = min) %>% ml_bwplot()
```

    ## [1] "using mini"
    ##     3_LogitBoost_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##   4_LogitBoost_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##  5_LogitBoost_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##        6_LogitBoost_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##     7_LogitBoost_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##               11_rf_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##             18_rf_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##    19_LogitBoost_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##  20_LogitBoost_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ## 21_LogitBoost_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##       22_LogitBoost_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##     23_LogitBoost_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##    24_LogitBoost_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##            31_rf_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##            43_rf_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##          44_rf_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##         45_rf_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##               46_rf_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##             47_rf_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##            48_rf_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##       59_xgbTree_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##     60_xgbTree_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##    61_xgbTree_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##          62_xgbTree_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##        63_xgbTree_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##       64_xgbTree_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##            68_rf_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##          75_rf_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##       76_xgbTree_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##     77_xgbTree_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##    78_xgbTree_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##          79_xgbTree_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##        80_xgbTree_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##       81_xgbTree_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##         88_rf_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE

![](README_with_results_files/figure-markdown_github/unnamed-chunk-9-1.png)

Last but not the least, we want to select models with a small correlation between models. Let us assume that we want all out models to have correlation no bigger than 0.75.

This could be easily done using the r ml\_cor\_filter function in the automl package.

``` r
iris_list = iris_list %>% ml_cor_filter(cor_level=0.75)
```

    ## Number of NA model(s) removed: 0

    ## Number of high correlation model(s) removed: 0

To summarize all the operations above into a line. Always assign model names after loading the models into R console.

``` r
iris_list = model_list_load(path="./iris_models") %>% assign_model_names %>% ml_bwplot %>%
  ml_cv_filter(metric = "Kappa",min=0.85,FUN=median) %>% ml_bwplot %>%
  ml_cv_filter(metric = "Accuracy",min=0.85,FUN=min)%>%ml_bwplot() %>% ml_cor_filter(cor_level = 0.75)
```

    ## Loading 88 models.

    ## Finished loading model: 102_LogitBoost_down_zv_nzv_center_scale_ROC.rds 
    ##  1 / 88

    ## Finished loading model: 104_LogitBoost_smote_zv_nzv_center_scale_ROC.rds 
    ##  2 / 88

    ## Finished loading model: 106_LogitBoost_up_zv_nzv_center_scale_Accuracy.rds 
    ##  3 / 88

    ## Finished loading model: 107_LogitBoost_down_zv_nzv_center_scale_Accuracy.rds 
    ##  4 / 88

    ## Finished loading model: 109_LogitBoost_smote_zv_nzv_center_scale_Accuracy.rds 
    ##  5 / 88

    ## Finished loading model: 111_LogitBoost_up_zv_nzv_center_scale_Kappa.rds 
    ##  6 / 88

    ## Finished loading model: 114_LogitBoost_smote_zv_nzv_center_scale_Kappa.rds 
    ##  7 / 88

    ## Finished loading model: 116_LogitBoost_up_zv_nzv_center_scale_Sens.rds 
    ##  8 / 88

    ## Finished loading model: 117_LogitBoost_down_zv_nzv_center_scale_Sens.rds 
    ##  9 / 88

    ## Finished loading model: 119_LogitBoost_smote_zv_nzv_center_scale_Sens.rds 
    ##  10 / 88

    ## Finished loading model: 11_rf_up_zv_nzv_center_scale_Kappa.rds 
    ##  11 / 88

    ## Finished loading model: 121_LogitBoost_up_zv_nzv_center_scale_Spec.rds 
    ##  12 / 88

    ## Finished loading model: 122_LogitBoost_down_zv_nzv_center_scale_Spec.rds 
    ##  13 / 88

    ## Finished loading model: 124_LogitBoost_smote_zv_nzv_center_scale_Spec.rds 
    ##  14 / 88

    ## Finished loading model: 126_LogitBoost_up_center_scale_ROC.rds 
    ##  15 / 88

    ## Finished loading model: 127_LogitBoost_down_center_scale_ROC.rds 
    ##  16 / 88

    ## Finished loading model: 129_LogitBoost_smote_center_scale_ROC.rds 
    ##  17 / 88

    ## Finished loading model: 12_rf_down_zv_nzv_center_scale_Kappa.rds 
    ##  18 / 88

    ## Finished loading model: 131_LogitBoost_up_center_scale_Accuracy.rds 
    ##  19 / 88

    ## Finished loading model: 132_LogitBoost_down_center_scale_Accuracy.rds 
    ##  20 / 88

    ## Finished loading model: 134_LogitBoost_smote_center_scale_Accuracy.rds 
    ##  21 / 88

    ## Finished loading model: 136_LogitBoost_up_center_scale_Kappa.rds 
    ##  22 / 88

    ## Finished loading model: 137_LogitBoost_down_center_scale_Kappa.rds 
    ##  23 / 88

    ## Finished loading model: 139_LogitBoost_smote_center_scale_Kappa.rds 
    ##  24 / 88

    ## Finished loading model: 141_LogitBoost_up_center_scale_Sens.rds 
    ##  25 / 88

    ## Finished loading model: 142_LogitBoost_down_center_scale_Sens.rds 
    ##  26 / 88

    ## Finished loading model: 144_LogitBoost_smote_center_scale_Sens.rds 
    ##  27 / 88

    ## Finished loading model: 146_LogitBoost_up_center_scale_Spec.rds 
    ##  28 / 88

    ## Finished loading model: 147_LogitBoost_down_center_scale_Spec.rds 
    ##  29 / 88

    ## Finished loading model: 149_LogitBoost_smote_center_scale_Spec.rds 
    ##  30 / 88

    ## Finished loading model: 14_rf_smote_zv_nzv_center_scale_Kappa.rds 
    ##  31 / 88

    ## Finished loading model: 16_rf_up_zv_nzv_center_scale_Sens.rds 
    ##  32 / 88

    ## Finished loading model: 17_rf_down_zv_nzv_center_scale_Sens.rds 
    ##  33 / 88

    ## Finished loading model: 19_rf_smote_zv_nzv_center_scale_Sens.rds 
    ##  34 / 88

    ## Finished loading model: 1_rf_up_zv_nzv_center_scale_ROC.rds 
    ##  35 / 88

    ## Finished loading model: 21_rf_up_zv_nzv_center_scale_Spec.rds 
    ##  36 / 88

    ## Finished loading model: 22_rf_down_zv_nzv_center_scale_Spec.rds 
    ##  37 / 88

    ## Finished loading model: 24_rf_smote_zv_nzv_center_scale_Spec.rds 
    ##  38 / 88

    ## Finished loading model: 26_rf_up_center_scale_ROC.rds 
    ##  39 / 88

    ## Finished loading model: 27_rf_down_center_scale_ROC.rds 
    ##  40 / 88

    ## Finished loading model: 29_rf_smote_center_scale_ROC.rds 
    ##  41 / 88

    ## Finished loading model: 2_rf_down_zv_nzv_center_scale_ROC.rds 
    ##  42 / 88

    ## Finished loading model: 31_rf_up_center_scale_Accuracy.rds 
    ##  43 / 88

    ## Finished loading model: 32_rf_down_center_scale_Accuracy.rds 
    ##  44 / 88

    ## Finished loading model: 34_rf_smote_center_scale_Accuracy.rds 
    ##  45 / 88

    ## Finished loading model: 36_rf_up_center_scale_Kappa.rds 
    ##  46 / 88

    ## Finished loading model: 37_rf_down_center_scale_Kappa.rds 
    ##  47 / 88

    ## Finished loading model: 39_rf_smote_center_scale_Kappa.rds 
    ##  48 / 88

    ## Finished loading model: 41_rf_up_center_scale_Sens.rds 
    ##  49 / 88

    ## Finished loading model: 42_rf_down_center_scale_Sens.rds 
    ##  50 / 88

    ## Finished loading model: 44_rf_smote_center_scale_Sens.rds 
    ##  51 / 88

    ## Finished loading model: 46_rf_up_center_scale_Spec.rds 
    ##  52 / 88

    ## Finished loading model: 47_rf_down_center_scale_Spec.rds 
    ##  53 / 88

    ## Finished loading model: 49_rf_smote_center_scale_Spec.rds 
    ##  54 / 88

    ## Finished loading model: 4_rf_smote_zv_nzv_center_scale_ROC.rds 
    ##  55 / 88

    ## Finished loading model: 51_xgbTree_up_zv_nzv_center_scale_ROC.rds 
    ##  56 / 88

    ## Finished loading model: 52_xgbTree_down_zv_nzv_center_scale_ROC.rds 
    ##  57 / 88

    ## Finished loading model: 54_xgbTree_smote_zv_nzv_center_scale_ROC.rds 
    ##  58 / 88

    ## Finished loading model: 56_xgbTree_up_zv_nzv_center_scale_Accuracy.rds 
    ##  59 / 88

    ## Finished loading model: 57_xgbTree_down_zv_nzv_center_scale_Accuracy.rds 
    ##  60 / 88

    ## Finished loading model: 59_xgbTree_smote_zv_nzv_center_scale_Accuracy.rds 
    ##  61 / 88

    ## Finished loading model: 61_xgbTree_up_zv_nzv_center_scale_Kappa.rds 
    ##  62 / 88

    ## Finished loading model: 62_xgbTree_down_zv_nzv_center_scale_Kappa.rds 
    ##  63 / 88

    ## Finished loading model: 64_xgbTree_smote_zv_nzv_center_scale_Kappa.rds 
    ##  64 / 88

    ## Finished loading model: 66_xgbTree_up_zv_nzv_center_scale_Sens.rds 
    ##  65 / 88

    ## Finished loading model: 67_xgbTree_down_zv_nzv_center_scale_Sens.rds 
    ##  66 / 88

    ## Finished loading model: 69_xgbTree_smote_zv_nzv_center_scale_Sens.rds 
    ##  67 / 88

    ## Finished loading model: 6_rf_up_zv_nzv_center_scale_Accuracy.rds 
    ##  68 / 88

    ## Finished loading model: 71_xgbTree_up_zv_nzv_center_scale_Spec.rds 
    ##  69 / 88

    ## Finished loading model: 72_xgbTree_down_zv_nzv_center_scale_Spec.rds 
    ##  70 / 88

    ## Finished loading model: 74_xgbTree_smote_zv_nzv_center_scale_Spec.rds 
    ##  71 / 88

    ## Finished loading model: 76_xgbTree_up_center_scale_ROC.rds 
    ##  72 / 88

    ## Finished loading model: 77_xgbTree_down_center_scale_ROC.rds 
    ##  73 / 88

    ## Finished loading model: 79_xgbTree_smote_center_scale_ROC.rds 
    ##  74 / 88

    ## Finished loading model: 7_rf_down_zv_nzv_center_scale_Accuracy.rds 
    ##  75 / 88

    ## Finished loading model: 81_xgbTree_up_center_scale_Accuracy.rds 
    ##  76 / 88

    ## Finished loading model: 82_xgbTree_down_center_scale_Accuracy.rds 
    ##  77 / 88

    ## Finished loading model: 84_xgbTree_smote_center_scale_Accuracy.rds 
    ##  78 / 88

    ## Finished loading model: 86_xgbTree_up_center_scale_Kappa.rds 
    ##  79 / 88

    ## Finished loading model: 87_xgbTree_down_center_scale_Kappa.rds 
    ##  80 / 88

    ## Finished loading model: 89_xgbTree_smote_center_scale_Kappa.rds 
    ##  81 / 88

    ## Finished loading model: 91_xgbTree_up_center_scale_Sens.rds 
    ##  82 / 88

    ## Finished loading model: 92_xgbTree_down_center_scale_Sens.rds 
    ##  83 / 88

    ## Finished loading model: 94_xgbTree_smote_center_scale_Sens.rds 
    ##  84 / 88

    ## Finished loading model: 96_xgbTree_up_center_scale_Spec.rds 
    ##  85 / 88

    ## Finished loading model: 97_xgbTree_down_center_scale_Spec.rds 
    ##  86 / 88

    ## Finished loading model: 99_xgbTree_smote_center_scale_Spec.rds 
    ##  87 / 88

    ## Finished loading model: 9_rf_smote_zv_nzv_center_scale_Accuracy.rds 
    ##  88 / 88

    ## Warning in resamples.default(.): Some performance measures were
    ## not computed for each model: AUC, logLoss, Mean_Balanced_Accuracy,
    ## Mean_Detection_Rate, Mean_F1, Mean_Neg_Pred_Value, Mean_Pos_Pred_Value,
    ## Mean_Precision, Mean_Recall, Mean_Sensitivity, Mean_Specificity, prAUC

![](README_with_results_files/figure-markdown_github/unnamed-chunk-11-1.png)

    ## [1] "using mini"
    ##     3_LogitBoost_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##   4_LogitBoost_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##  5_LogitBoost_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##        6_LogitBoost_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##     7_LogitBoost_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##               11_rf_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##             18_rf_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##    19_LogitBoost_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##  20_LogitBoost_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ## 21_LogitBoost_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##       22_LogitBoost_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##     23_LogitBoost_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##    24_LogitBoost_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            31_rf_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            43_rf_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          44_rf_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##         45_rf_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##               46_rf_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##             47_rf_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            48_rf_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##       59_xgbTree_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##     60_xgbTree_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##    61_xgbTree_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          62_xgbTree_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##        63_xgbTree_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##       64_xgbTree_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##            68_rf_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          75_rf_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##       76_xgbTree_up_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##     77_xgbTree_down_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##    78_xgbTree_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE 
    ##          79_xgbTree_up_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##        80_xgbTree_down_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##       81_xgbTree_smote_center_scale_ignore_Kappa~Kappa 
    ##                                                   TRUE 
    ##         88_rf_smote_center_scale_ignore_Accuracy~Kappa 
    ##                                                   TRUE

![](README_with_results_files/figure-markdown_github/unnamed-chunk-11-2.png)

    ## [1] "using mini"
    ##     3_LogitBoost_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##   4_LogitBoost_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##  5_LogitBoost_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##        6_LogitBoost_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##     7_LogitBoost_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                     FALSE 
    ##               11_rf_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##             18_rf_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##    19_LogitBoost_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##  20_LogitBoost_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ## 21_LogitBoost_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##       22_LogitBoost_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##     23_LogitBoost_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##    24_LogitBoost_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##            31_rf_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##            43_rf_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##          44_rf_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##         45_rf_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##               46_rf_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##             47_rf_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##            48_rf_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##       59_xgbTree_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##     60_xgbTree_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##    61_xgbTree_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##          62_xgbTree_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##        63_xgbTree_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##       64_xgbTree_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##            68_rf_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##          75_rf_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                     FALSE 
    ##       76_xgbTree_up_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##     77_xgbTree_down_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##    78_xgbTree_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE 
    ##          79_xgbTree_up_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##        80_xgbTree_down_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##       81_xgbTree_smote_center_scale_ignore_Kappa~Accuracy 
    ##                                                      TRUE 
    ##         88_rf_smote_center_scale_ignore_Accuracy~Accuracy 
    ##                                                      TRUE

    ## Number of NA model(s) removed: 0

    ## Number of high correlation model(s) removed: 4

![](README_with_results_files/figure-markdown_github/unnamed-chunk-11-3.png)

Session information.

``` r
sessionInfo()
```

    ## R version 3.4.4 (2018-03-15)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 16.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS: /usr/lib/libblas/libblas.so.3.6.0
    ## LAPACK: /usr/lib/lapack/liblapack.so.3.6.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] magrittr_1.5    caret_6.0-79    ggplot2_2.2.1   lattice_0.20-35
    ## [5] automl_0.0.9000
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] nlme_3.1-137        bitops_1.0-6        xts_0.10-1         
    ##   [4] lubridate_1.7.1     devtools_1.13.5     dimRed_0.1.0       
    ##   [7] doParallel_1.0.11   httr_1.3.1          rprojroot_1.3-2    
    ##  [10] tools_3.4.4         backports_1.1.2     R6_2.2.2           
    ##  [13] KernSmooth_2.23-15  rpart_4.1-13        lazyeval_0.2.1     
    ##  [16] colorspace_1.3-2    nnet_7.3-12         DMwR_0.4.1         
    ##  [19] withr_2.1.2         tidyselect_0.2.3    mnormt_1.5-5       
    ##  [22] curl_3.1            compiler_3.4.4      git2r_0.21.0       
    ##  [25] caTools_1.17.1      scales_0.5.0        sfsmisc_1.1-1      
    ##  [28] DEoptimR_1.0-8      psych_1.7.8         robustbase_0.92-8  
    ##  [31] randomForest_4.6-12 stringr_1.2.0       digest_0.6.14      
    ##  [34] foreign_0.8-69      dbscan_1.1-1        rmarkdown_1.8      
    ##  [37] pkgconfig_2.0.1     htmltools_0.3.6     rlang_0.1.6        
    ##  [40] TTR_0.23-3          ddalpha_1.3.1       quantmod_0.4-12    
    ##  [43] MLmetrics_1.1.1     FNN_1.1             bindr_0.1          
    ##  [46] zoo_1.8-1           jsonlite_1.5        gtools_3.5.0       
    ##  [49] dplyr_0.7.4         ModelMetrics_1.1.0  RCurl_1.95-4.10    
    ##  [52] ROSE_0.0-3          Matrix_1.2-14       Rcpp_0.12.15       
    ##  [55] munsell_0.4.3       abind_1.4-5         stringi_1.1.6      
    ##  [58] yaml_2.1.16         MASS_7.3-49         gplots_3.0.1       
    ##  [61] plyr_1.8.4          recipes_0.1.2       grid_3.4.4         
    ##  [64] gdata_2.18.0        parallel_3.4.4      splines_3.4.4      
    ##  [67] knitr_1.20          pillar_1.1.0        xgboost_0.6.4.1    
    ##  [70] reshape2_1.4.3      codetools_0.2-15    stats4_3.4.4       
    ##  [73] CVST_0.2-1          glue_1.2.0          evaluate_0.10.1    
    ##  [76] data.table_1.10.4-3 foreach_1.4.4       gtable_0.2.0       
    ##  [79] purrr_0.2.4         tidyr_0.7.2         kernlab_0.9-25     
    ##  [82] assertthat_0.2.0    DRR_0.0.3           gower_0.1.2        
    ##  [85] prodlim_1.6.1       h2o_3.16.0.2        broom_0.4.3        
    ##  [88] e1071_1.6-8         class_7.3-14        survival_2.42-3    
    ##  [91] timeDate_3042.101   smotefamily_1.2     RcppRoll_0.2.2     
    ##  [94] tibble_1.4.2        iterators_1.0.9     memoise_1.1.0      
    ##  [97] bindrcpp_0.2        lava_1.6            ROCR_1.0-7         
    ## [100] ipred_0.9-6
