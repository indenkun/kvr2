# The Pitfalls of R-squared: Understanding Mathematical Sensitivity

## Introduction: Why $R^{2}$ is Not Unique

In many statistical software packages, the coefficient of determination
($R^{2}$) is presented as a singular, definitive value. However, as
Tarald O. Kvalseth pointed out in his seminal 1985 paper, “Cautionary
Note about $R^{2}$”, there are multiple ways to define and calculate
this metric.

While these definitions converge in standard linear regression with an
intercept, they can diverge dramatically in other contexts, such as
models without an intercept or power regression models. The `kvr2`
package is designed as an educational tool to explore this
**mathematical sensitivity**.

## The Eight + One Definitions

Kvalseth (1985) classified eight existing formulas and proposed one
robust alternative. Here are the core definitions used in this package:

### Standard Definitions

- $R_{1}^{2}$: The most common form, measuring the proportion of
  variance explained. Kvalseth strongly recommends this for consistency.

$$R_{1}^{2} = 1 - \frac{\sum\left( y - \widehat{y} \right)^{2}}{\sum\left( y - \bar{y} \right)^{2}}$$

- $R_{2}^{2}$: Often used in some contexts, but can exceed 1.0 in
  no-intercept models.

$$R_{2}^{2} = \frac{\sum\left( \widehat{y} - \bar{y} \right)^{2}}{\sum\left( y - \bar{y} \right)^{2}}$$

- $R_{6}^{2}$: The square of Pearson’s correlation coefficient between
  observed and predicted values.

$$R_{6}^{2} = \frac{\left( \sum\left( y - \bar{y} \right)\left( \widehat{y} - \bar{\widehat{y}} \right) \right)^{2}}{\sum\left( y - \bar{y} \right)^{2}\sum\left( \widehat{y} - \bar{\widehat{y}} \right)^{2}}$$

### Definitions for No-Intercept Models

- $R_{7}^{2}$: Specifically designed for models passing through the
  origin.

$$R_{7}^{2} = 1 - \frac{\sum\left( y - \widehat{y} \right)^{2}}{\sum y^{2}}$$

### Robust Definition

- $R_{9}^{2}$: Proposed by Kvalseth to resist the influence of outliers
  by using medians ($M$).

$$R_{9}^{2} = 1 - \left( \frac{M\{\left| y_{i} - {\widehat{y}}_{i} \right|\}}{M\{\left| y_{i} - \bar{y} \right|\}} \right)^{2}$$

------------------------------------------------------------------------

## Case Study: The Danger of No-Intercept Models

Let’s use the example data from Kvalseth (1985) to see how these values
diverge when we remove the intercept.

``` r
library(kvr2)
df1 <- data.frame(x = 1:6, y = c(15, 37, 52, 59, 83, 92))

# Model without an intercept
model_no_int <- lm(y ~ x - 1, data = df1)

# Calculate all 9 types
results <- r2(model_no_int)
results
#> R2_1 :  0.9777 
#> R2_2 :  1.0836 
#> R2_3 :  1.0830 
#> R2_4 :  0.9783 
#> R2_5 :  0.9808 
#> R2_6 :  0.9808 
#> R2_7 :  0.9961 
#> R2_8 :  0.9961 
#> R2_9 :  0.9717
```

### The Trap

Notice that $R_{2}^{2}$ and $R_{3}^{2}$ are greater than 1.0. This
happens because, without an intercept, the standard sum of squares
relationship ($SS_{tot} = SS_{reg} + SS_{res}$) no longer holds. If a
researcher blindly reports $R_{2}^{2}$, the result is mathematically
nonsensical.

Kvalseth argues that $R_{1}^{2}$ is generally preferable because it
remains bounded by 1.0 and maintains a clear interpretation of “error
reduction.”

------------------------------------------------------------------------

## The Transformation Trap (Power Models)

In power regression models (typically fitted via log-log
transformation), the definition of the “mean” and “residuals” becomes
ambiguous. Does the $R^{2}$ refer to the transformed space or the
original space?

``` r
# Power model via log-transformation
model_power <- lm(log(y) ~ log(x), data = df1)
r2(model_power)
#> R2_1 :  0.9777 
#> R2_2 :  1.0984 
#> R2_3 :  1.0983 
#> R2_4 :  0.9778 
#> R2_5 :  0.9816 
#> R2_6 :  0.9811 
#> R2_7 :  0.9961 
#> R2_8 :  1.0232 
#> R2_9 :  0.9706
```

In this case, `kvr2` automatically detects the transformation (if
`type = "auto"`) and helps you evaluate if the reported fit is
consistent with your research goals.

------------------------------------------------------------------------

## Conclusion

The `kvr2` package demonstrates that $R^{2}$ is not a “plug-and-play”
statistic. By comparing these nine definitions, users can:

1.  Identify when a model fit is being over- or under-represented by a
    specific formula.
2.  Understand why Kvalseth recommended $R_{1}^{2}$ for its consistency
    and $R_{9}^{2}$ for its robustness.
3.  Be more critical of $R^{2}$ values reported in scientific
    literature.

## References

Kvalseth, T. O. (1985). Cautionary Note about $R^{2}$. The American
Statistician, 39(4), 279-285. [DOI:
10.1080/00031305.1985.10479448](https://doi.org/10.1080/00031305.1985.10479448)
