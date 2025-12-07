#' Load 3D time series and compute Euclidean norm
#'
#' Reads a CSV file with an index column, a time column,
#' and three coordinate columns (x, y, z). Converts the
#' time column to POSIXct and adds a new column `accel`
#' with the Euclidean norm sqrt(x^2 + y^2 + z^2).
#'
#' @param file Path to the CSV file.
#' @param x Name or column index of the x-axis.
#' @param y Name or column index of the y-axis.
#' @param z Name or column index of the z-axis.
#' @param time Name or column index of the time variable.
#' @param time_origin Origin used if time is numeric
#'   (passed to [as.POSIXct()]'s `origin` argument).
#'
#' @return A data.frame with an extra column `accel`.
#' @examples
#' \dontrun{
#' df <- load_accel_csv("Example_window.csv", x = 3, y = 4, z = 5, time = 2)
#' head(df)
#' }
#'
#' @export
load_accel_csv <- function(file,
                           x = 3,
                           y = 4,
                           z = 5,
                           time = 2,
                           time_origin = "1970-01-01") {
  data <- utils::read.csv(file, stringsAsFactors = FALSE)

  # Convert column spec (name or index) to names
  col_names <- names(data)
  x_col <- if (is.numeric(x)) col_names[x] else x
  y_col <- if (is.numeric(y)) col_names[y] else y
  z_col <- if (is.numeric(z)) col_names[z] else z
  t_col <- if (is.numeric(time)) col_names[time] else time

  # Convert time to POSIXct (assumes numeric seconds)
  data[[t_col]] <- as.POSIXct(
    data[[t_col]],
    origin = time_origin,
    tz = "UTC"
  )

  # Euclidean norm
  data$accel <- sqrt(
    data[[x_col]]^2 +
      data[[y_col]]^2 +
      data[[z_col]]^2
  )

  return(data)
}

