#' Coefficient of Determination According to Kvalseth's Classification
#' @description
#' Function for calculating the coefficient of determination according to Tarald O. Kvalseth's (1985) classification.
#' See note.
#' @param model A linear regression model or power regression model of the lm class created by the `lm()` function.
#' @param type Selects whether the regression model is a linear regression model or a power regression model.
#' When set to auto, it determines whether the dependent variable contains a log transformation and selects accordingly.
#' See note.
#' @param adjusted Logical value. Whether to calculate the adjusted coefficient of determination.
#' If TRUE, the adjusted coefficient of determination is calculated. See details.
#' See details.
#' @examples
#' # Example data set 1. Kvalseth (1985).
#' df1 <- data.frame(x = c(1:6),
#'                  y = c(15,37,52,59,83,92))
#' # Linear regression model with intercept
#' model_intercept1 <- lm(y ~ x, df1)
#' # Linear regression model without intercept
#' model_without1 <- lm(y ~ x - 1, df1)
#' # Power regression model
#' model_power1 <- lm(log(y) ~ log(x), df1)
#' r2(model_intercept1)
#' r2(model_without1)
#' r2(model_power1)
#' # Example data set 2. Kvalseth (1985).
#' df2 <- data.frame(x = 6:13,
#'                   y = c(3882, 1266, 733, 450, 410, 305, 185, 112))
#' power_model2 <- lm(log((y/7343)) ~ log(x), data = df2)
#' r2(power_model2)
#' # Example of a Multiple Regression Analysis Model.
#' # The data for two independent variables given by Box et al. (1978, p. 462)
#' # as used in Kvalseth (1985).
#' df3 <- data.frame(x1 = c(0.34, 0.34, 0.58, 1.26, 1.26, 1.82),
#'                   x2 = c(0.73, 0.73, 0.69, 0.97, 0.97, 0.46),
#'                   y = c(5.75, 4.79, 5.44, 9.09, 8.59, 5.09))
#' # Multiple regression analysis model with intercept
#' model_intercept3 <- lm(y ~ x1 + x2, df3)
#' # Multiple regression analysis model without intercept
#' model_without3 <- lm(y ~ x1 + x2 - 1, df3)
#' # Multiple power regression analysis model
#' model_power3 <- lm(log(y) ~ log(x1) + log(x2), df3)
#' r2(model_intercept3)
#' r2(model_without3)
#' r2(model_power3)
#' @details
#' The nine coefficient equations from \eqn{R^2_1} to \eqn{R^2_9} are based on Kvalseth (1985) and are as follows:
#' \eqn{R^2_1}: Proportion of total variance explained (most common form).
#' \deqn{R_1^2 = 1 - \frac{\sum(y - \hat{y})^2}{\sum(y - \bar{y})^2}}
#' \eqn{R^2_2}: Form based on fluctuations in predicted values.
#' \deqn{R^2_2 = \frac{\sum(\hat{y} - \bar{y})^2}{\sum(y - \bar{y})^2}}
#' \eqn{R^2_3}: Ratio of variation using the mean of the predicted values.
#' \deqn{R_3^2 = \frac{\sum(\hat{y} - \bar{\hat{y}})^2}{\sum(y - \bar{y})^2}}
#' \eqn{R^2_4}: Formula incorporating the mean residual.
#' \deqn{R_4^2 = 1 - \frac{\sum(e - \bar{e})^2}{\sum(y - \bar{y})^2}, \quad e = y - \hat{y}}
#' \eqn{R^2_5}: The square of the multiple correlation coefficient between the dependent variable and the independent variable (a comprehensive indicator in linearized models).
#' \deqn{R_5^2 = \text{squared multiple correlation coefficient between the regressand and the regressors}}
#' \eqn{R^2_6}: The square of the correlation coefficient between the observed value \eqn{y} and the predicted value \eqn{\hat{y}} (the square of Pearson's correlation coefficient).
#' \deqn{R_6^2 = \frac{\left( \sum(y - \bar{y})(\hat{y} - \bar{\hat{y}}) \right)^2}{\sum(y - \bar{y})^2 \sum(\hat{y} - \bar{\hat{y}})^2}}
#' \eqn{R^2_7}: Recommended format for models without slices.
#' \deqn{R_7^2 = 1 - \frac{\sum(y - \hat{y})^2}{\sum y^2}}
#' \eqn{R^2_8}: Another format for models without slices
#' \deqn{R_8^2 = \frac{\sum \hat{y}^2}{\sum y^2}}
#' \eqn{R^2_9}: An equation proposed as an outlier-resistant indicator (Coefficient of determination of persistence).
#' \deqn{R_9^2 = 1 - \left( \frac{M\{|y_i - \hat{y}_i|\}}{M\{|y_i - \bar{y}|\}} \right)^2}
#' \eqn{M} represents the median of the sample.
#'
#' For details on degree of freedom adjustment, refer to [r2_adjusted].
#'
#' @note
#' The power regression model must be based on a logarithmic transformation.
#'
#' The auto-selection between linear regression and power regression models is determined by whether the dependent variable's name contains “log”.
#' If the name “log” is intentionally used for a linear regression model, the selection cannot be made correctly.
#'
#' @references
#' Tarald O. Kvalseth (1985) Cautionary Note about R 2 , The American Statistician, 39:4, 279-285, \doi{10.1080/00031305.1985.10479448}
#' Box, George E. P., Hunter, William G., Hunter, J. Stuart. (1978) Statistics for experimenters: an introduction to design, data analysis, and model building. New York, United States, J. Wiley, p. 462-473, ISBN:9780471093152.
#' @rdname r2
#' @export
r2 <- function(model, type = c("auto", "liner", "power"), adjusted = FALSE){
  type <- match.arg(type)

  ans <- list()

  ans <- c(r2_1(model, type),
           r2_2(model, type),
           r2_3(model, type),
           r2_4(model, type),
           r2_5(model, type),
           r2_6(model, type),
           r2_7(model, type),
           r2_8(model, type),
           r2_9(model, type))

  if(adjusted){
    ans <- c(r2_adjusted(model, ans$r2_1),
             r2_adjusted(model, ans$r2_2),
             r2_adjusted(model, ans$r2_3),
             r2_adjusted(model, ans$r2_4),
             r2_adjusted(model, ans$r2_5),
             r2_adjusted(model, ans$r2_6),
             r2_adjusted(model, ans$r2_7),
             r2_adjusted(model, ans$r2_8),
             r2_adjusted(model, ans$r2_9))
  }

  class(ans) <- "r2"

  ans
}

#' @rdname r2
#' @export
r2_1 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- 1 - sum((v$y - v$f)^2) / sum((v$y - mean(v$y))^2)
  names(r2) <- "r2_1"

  ans$r2_1 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_2 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- sum((v$f - mean(v$y))^2) / sum((v$y - mean(v$y))^2)
  names(r2) <- "r2_2"

  ans$r2_2 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_3 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- sum((v$f - mean(v$f))^2) / sum((v$y - mean(v$y))^2)
  names(r2) <- "r2_3"

  ans$r2_3 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_4 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- 1 - sum((v$e - mean(v$e))^2) / sum((v$y - mean(v$y))^2)
  names(r2) <- "r2_4"

  ans$r2_4 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_5 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  # if(v$k == 2) r2 <- stats::cor(v$y, v$f)^2
  # else{
  model <- stats::update(model, . ~ . + 1)
  r2 <- stats::summary.lm(model)$r.squared
  # }
  names(r2) <- "r2_5"

  ans$r2_5 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_6 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- stats::cor(v$y, v$f)^2
  names(r2) <- "r2_6"

  ans$r2_6 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_7 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- 1 - sum((v$y - v$f)^2) / sum(v$y^2)
  names(r2) <- "r2_7"

  ans$r2_7 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_8 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- sum(v$f^2) / sum(v$y^2)
  names(r2) <- "r2_8"

  ans$r2_8 <- r2
  class(ans) <- "r2"
  ans
}

#' @rdname r2
#' @export
r2_9 <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  r2 <- 1 - (stats::median(abs(v$y - v$f)) / stats::median(abs(v$y - mean(v$y))))^2
  names(r2) <- "r2_9"

  ans$r2_9 <- r2
  class(ans) <- "r2"
  ans
}
