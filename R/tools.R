# internal tools
check_lm <- function(model) stopifnot(class(model) == "lm")

values_lm <- function(model, type = c("auto", "liner", "power")){
  type <- match.arg(type)
  check_lm(model)

  if(type == "auto"){
    if(check_power(model)) type <- "power"
    else type <- "liner"
  }

  ans <- NULL

  ans$p <- model$rank
  ans$rdf <- model$df.residual
  ans$r <- model$residuals
  ans$f <- model$fitted.values
  ans$y <- model$model[[1]]
  ans$n <- length(ans$y)
  ans$k <- length(model$model)

  if(type == "power"){
    ans$r <- exp(ans$r)
    ans$f <- exp(ans$f)
    ans$y <- exp(ans$y)
  }

  ans$e <- ans$y - ans$f

  ans$df_int <- attr(model$terms, "intercept")
  ans$a <- (ans$n - ans$df_int) / ans$rdf

  ans
}

check_power <- function(model){
  "log" %in% as.character(model$call$formula[[2]])
}
