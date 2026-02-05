#' Print Methods for r2 and comparison_measure calculation Objects
#' @description
#' Printing objects of class "`r2`" or "`comparison_measure`", respectively, by simple print methods.
#' @param x description object of class "`r2`" or "`comparison_measure`".
#' @param digits number of significant digits to be used.
#' @param ... further arguments passed to or from other methods.
#' @seealso [r2] [comparison_measure] [r2_adjusted]
#' @rdname print.r2
#' @export
print.r2 <- function(x, ..., digits = 4){
  stopifnot(class(x) == "r2")

  # if(!is.null(x$r2_1)) cat(chartr("r", "R", names(x$r2_1)), ": ", format(round(x$r2_1, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_2)) cat(chartr("r", "R", names(x$r2_2)), ": ", format(round(x$r2_2, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_3)) cat(chartr("r", "R", names(x$r2_3)), ": ", format(round(x$r2_3, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_4)) cat(chartr("r", "R", names(x$r2_4)), ": ", format(round(x$r2_4, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_5)) cat(chartr("r", "R", names(x$r2_5)), ": ", format(round(x$r2_5, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_6)) cat(chartr("r", "R", names(x$r2_6)), ": ", format(round(x$r2_6, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_7)) cat(chartr("r", "R", names(x$r2_7)), ": ", format(round(x$r2_7, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_8)) cat(chartr("r", "R", names(x$r2_8)), ": ", format(round(x$r2_8, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$r2_9)) cat(chartr("r", "R", names(x$r2_9)), ": ", format(round(x$r2_9, digits = digits), nsmall = digits), "\n")
  sapply(x, function(x){
    cat(chartr("r", "R", names(x)), ": ", format(round(x, digits = digits), nsmall = digits), "\n")
  })
}

#' @rdname print.r2
#' @export
print.comparison_measure <- function(x, ..., digits = 4){
  stopifnot(class(x) == "comparison_measure")


  # if(x$rmse) cat("RMSE: ", format(round(x$rmse, digits = digits), nsmall = digits), "\n")
  # if(!is.null(x$rmse) cat(" ")
  # if(x$mae) cat("MAE: ",  format(round(x$mae,  digits = digits), nsmall = digits), "\n")
  # if(x$mse) cat("MSE: ",  format(round(x$mse,  digits = digits), nsmall = digits), "\n")

  sapply(x, function(x){
    cat(names(x), ": ", format(round(x,  digits = digits), nsmall = digits), "\n")
  })
}
