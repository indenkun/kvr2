#' Comparative Measures for Regression Models
#' @description
#' A function to calculate comparison metrics for regression models, such as RMSE, MAE, and MSE.
#' `comparison_measure` displays all three metrics together.
#' Each value can be calculated using its respective function.
#' Each definition is based on Tarald O. Kvalseth's (1985) work.
#' Particular attention should be paid to MSE. See details.
#' @inheritParams r2
#' @examples
#' # example data set 1. Kvålseth (1985).
#' df1 <- data.frame(x = c(1:6),
#'                  y = c(15,37,52,59,83,92))
#' model_intercept <- lm(y ~ x, df1)
#' model_without <- lm(y ~ x - 1, df1)
#' model_power <- lm(log(y) ~ log(x), df1)
#' comparison_measure(model_intercept)
#' comparison_measure(model_without)
#' comparison_measure(model_power)
#' @details
#' The root mean squared residual or error (RMSE), mean absolute residual (MAE), and the mean squared residual (MSE) defined as based on Kvålseth (1985).
#' \deqn{\text{RMSE} = [{\frac{\sum (y - \hat{y})^2}{n}}]^{1/2}}
#' \deqn{\text{MAE} = \frac{\sum |y - \hat{y}|}{n}}
#' \deqn{\text{MSE} = \frac{\sum (y - \hat{y})^2}{n - p}}
#' where \eqn{p} denotes the number of model parameters.
#' Note that the MSE generally used today is not adjusted for the number of parameters, whereas Kvalseth's (1985) MSE is adjusted for the number of parameters.
#' @references
#' Tarald O. Kvalseth (1985) Cautionary Note about R 2 , The American Statistician, 39:4, 279-285, \doi{DOI: 10.1080/00031305.1985.10479448}
#' @inherit r2 note
#' @rdname comparison_measure
#' @export
comparison_measure <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  ans <- list()

  ans <- c(RMSE(model, type), MAE(model, type), MSE(model, type))

  class(ans) <- "comparison_measure"

  ans
}

#' @rdname comparison_measure
#' @export
RMSE <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  rmse <- sqrt(sum((v$y - v$f)^2) / v$n)
  names(rmse) <- "RMES"

  ans$rmse <- rmse
  class(ans) <- "comparison_measure"
  ans
}

#' @rdname comparison_measure
#' @export
MAE <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  mae <- sum(abs(v$y - v$f)) / v$n
  names(mae) <- "MAE"

  ans$mae <- mae
  class(ans) <- "comparison_measure"
  ans
}

#' @rdname comparison_measure
#' @export
MSE <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)

  v <- values_lm(model, type)
  ans <- list()

  mse <- sum((v$y - v$f)^2) / (v$n - v$p)
  names(mse) <- "MSE"

  ans$mse <- mse
  class(ans) <- "comparison_measure"
  ans
}
