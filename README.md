
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Kvalseth.R2

<!-- badges: start -->

<!-- badges: end -->

The determination coefficient for linear or power regression models is
based on the determination coefficients according to Kvalseth’s nine
classifications (eight classifications of existing methods and one
proposed method).

Kvalseth’s classification is based on Tarald O. Kvalseth (1985)
Cautionary Note about R 2 , The American Statistician, 39:4, 279-285,
DOI: 10.1080/00031305.1985.10479448.

This package is not intended for detailed verification of the
coefficient of determination. It is an educational package designed to
confirm that the coefficient of determination may differ depending on
the specific definition formula used, as classified by Kvalseth (1985).

## Installation

You can install the development version of Kvalseth.R2 like so:

``` r
remotes::install_github("indenkun/Kvalseth.R2")
```

## Example

The `R2()` function can calculate nine types of determination
coefficients all at once.

``` r
library(Kvalseth.R2)
# Example data set 1. Kvalseth (1985).
df1 <- data.frame(x = c(1:6),
                  y = c(15,37,52,59,83,92))
# Linear regression model with intercept
model_intercept1 <- lm(y ~ x, df1)
# Linear regression model without intercept
model_without1 <- lm(y ~ x - 1, df1)
# Power regression model
model_power1 <- lm(log(y) ~ log(x), df1)
r2(model_intercept1)
#> R2_1 :  0.9808 
#> R2_2 :  0.9808 
#> R2_3 :  0.9808 
#> R2_4 :  0.9808 
#> R2_5 :  0.9808 
#> R2_6 :  0.9808 
#> R2_7 :  0.9966 
#> R2_8 :  0.9966 
#> R2_9 :  0.9778
r2(model_without1)
#> R2_1 :  0.9777 
#> R2_2 :  1.0836 
#> R2_3 :  1.0830 
#> R2_4 :  0.9783 
#> R2_5 :  0.9808 
#> R2_6 :  0.9808 
#> R2_7 :  0.9961 
#> R2_8 :  0.9961 
#> R2_9 :  0.9717
r2(model_power1)
#> R2_1 :  0.9777 
#> R2_2 :  1.0984 
#> R2_3 :  1.0983 
#> R2_4 :  0.9778 
#> R2_5 :  0.9811 
#> R2_6 :  0.9811 
#> R2_7 :  0.9961 
#> R2_8 :  1.0232 
#> R2_9 :  0.9706
```

The `comparison_measure()` function to calculate comparison metrics for
regression models, such as RMSE, MAE, and MSE.

``` r
comparison_measure(model_intercept1)
#> RMES :  3.6165 
#> MAE :  3.5238 
#> MSE :  19.6190
comparison_measure(model_without1)
#> RMES :  3.9008 
#> MAE :  3.6520 
#> MSE :  18.2593
comparison_measure(model_power1)
#> RMES :  3.8982 
#> MAE :  3.6334 
#> MSE :  22.7938
```

For details, refer to the documentation for each function.

## References

Tarald O. Kvalseth (1985) Cautionary Note about R 2 , The American
Statistician, 39:4, 279-285, DOI: 10.1080/00031305.1985.10479448

Box, George E. P., Hunter, William G., Hunter, J. Stuart. (1978)
Statistics for experimenters: an introduction to design, data analysis,
and model building. New York, United States, J. Wiley, p. 462-473,
<ISBN:9780471093152>.
