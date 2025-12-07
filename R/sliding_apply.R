#' Apply a window function across a time series
#'
#' @param data A data.frame containing the time series.
#' @param column Name of the column to apply the window function to.
#' @param window_size Integer window size (=size of the sliding window->number of points).
#' @param fun The window function to apply (e.g., window_mean).
#' @param output_name Name of the new column to store results (output column to create).
#' @param ... Additional arguments to pass to the window function.
#'
#' @return The same data frame with a new column containing results.
#'
#' @examples
#' \dontrun{
#' df <- load_accel_csv("Example_window.csv")
#' df <- sliding_apply(df, "accel", 1000, window_mean, "mean")
#' }
#'
#' @export
sliding_apply <- function(data,
                          column = "accel",
                          window_size = 1000,
                          fun,
                          output_name = "result",
                          ...) {

  # check column exists
  if (!column %in% names(data)) {
    stop("Column '", column, "' not found in the data frame.")
  }

  n <- nrow(data)
  values <- data[[column]]

  # prepare output column filled with NA
  out <- rep(NA_real_, n)

  # last valid starting index
  last_start <- n - window_size + 1
  if (last_start < 1) {
    stop("Window size is larger than the data.")
  }

  # sliding window loop
  for (i in 1:last_start) {
    window <- values[i:(i + window_size - 1)]
    result <- fun(window, ...)

    # store result at the END of the window
    out[i + window_size - 1] <- result
  }

  # add new column
  data[[output_name]] <- out
  return(data)
}
