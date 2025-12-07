#' Mean value of a window
#'
#' @param x Numeric vector (a window from the time series)
#' @return Mean of x
#' @examples
#' window_mean(1:5)
#' @export
window_mean <- function(x) {
  mean(x, na.rm = TRUE)
}

#' Threshold change within a window
#'
#' @description
#' Checks how much the values increase or decrease in the window.
#' Returns:
#'  * largest positive change (if above threshold),
#'  * or largest negative change (if above threshold),
#'  * or 0 if no change exceeds threshold.
#'
#' @param x Numeric vector (representing a window)
#' @param threshold Numeric threshold value
#'
#' @return A numeric value (positive, negative (Change value), or 0)
#'
#'  @examples
#' window_threshold_change(c(1, 1.8, 1.4), threshold = 0.5)
#'
#' @export
#'
window_threshold_change <- function(x, threshold) {
  if (length(x) < 2) return(0)

  start <- x[1]
  pos_change <- max(x) - start
  neg_change <- min(x) - start

  above_pos <- abs(pos_change) >= threshold
  above_neg <- abs(neg_change) >= threshold

  if (!above_pos && !above_neg) return(0)

  if (abs(pos_change) >= abs(neg_change)) {
    return(pos_change)
  } else {
    return(neg_change)
  }
}

#' Binary trend in a window
#'
#' @description
#' Returns:
#'  * +1 if the value increases over the window
#'  * -1 if it decreases
#'  * 0 if no change
#'
#' @param x Numeric vector (representing a window)
#'
#' @return +1, -1, or 0
#'
#'@examples
#' window_binary_trend(c(1,2,3))
#' window_binary_trend(c(3,2,1))
#'
#' @export
#'
window_binary_trend <- function(x) {
  if (length(x) < 2) return(0)
  diff <- x[length(x)] - x[1]
  if (diff > 0) return(1)
  if (diff < 0) return(-1)
  return(0)
}
