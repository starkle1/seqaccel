#' Plot raw and processed acceleration data
#'
#' @description
#' A wrapper around ggplot2 that plots:
#'  * the raw Euclidean acceleration
#'  * and optionally the mean, binary, and thresholded signals
#'
#' @param data Data frame containing time, accel, and processed columns.
#' @param time_col Name of the time column.
#' @param accel_col Name of the raw acceleration column.
#' @param show_mean Logical; if TRUE and "mean" exists, plot it.
#' @param show_binary Logical; if TRUE and "binary" exists, plot it.
#' @param show_threshold Logical; if TRUE and "thresholded" exists, plot it.
#'
#' @return A ggplot object
#'
#' @examples
#' \dontrun{
#' df <- load_accel_csv("Example_window.csv")
#' df <- sliding_apply(df, "accel", 1000, window_mean, "mean")
#' accel_plot(df, show_mean = TRUE)
#' }
#'
#' @export
accel_plot <- function(data,
                       time_col = "time",
                       accel_col = "accel",
                       show_mean = FALSE,
                       show_binary = FALSE,
                       show_threshold = FALSE) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required but not installed.")
  }

  p <- ggplot2::ggplot(data, ggplot2::aes_string(x = time_col, y = accel_col)) +
    ggplot2::geom_line(color = "black") +
    ggplot2::labs(title = "Acceleration Time Series",
                  y = "Acceleration",
                  x = "Time")

  if (show_mean && "mean" %in% names(data)) {
    p <- p + ggplot2::geom_line(ggplot2::aes(y = mean), color = "blue")
  }

  if (show_binary && "binary" %in% names(data)) {
    p <- p + ggplot2::geom_line(ggplot2::aes(y = binary), color = "red")
  }

  if (show_threshold && "thresholded" %in% names(data)) {
    p <- p + ggplot2::geom_line(ggplot2::aes(y = thresholded), color = "purple")
  }

  return(p)
}
