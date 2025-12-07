**seqaccel**

Tools for loading 3D accelerometer data, computing the Euclidean norm,
and applying sliding window algorithms (mean, binary trend, threshold).
Includes a ggplot2 wrapper for visualization.

_Installation_

You need devtools to install packages from GitHub:

install.packages("devtools")


Install the package from GitHub:

devtools::install_github("starkle1/seqaccel")


Load the package:

library(seqaccel)

Example
# Load Example Window CSV
df <- load_accel_csv(
  "Example_window.csv",
  x = 3, y = 4, z = 5, time = 2
)

# Apply sliding window mean
df <- sliding_apply(df, "accel", 1000, window_mean, "mean")

# Plot raw + mean signal
accel_plot(df, show_mean = TRUE)

Other sliding window functions

Binary trend:

df <- sliding_apply(df, "accel", 1000, window_binary_trend, "binary")


Threshold-based change:

df <- sliding_apply(df, "accel", 1000, window_threshold_change,
                    "thresholded", threshold = 0.5)


Plot everything:

accel_plot(df, show_mean = TRUE, show_binary = TRUE, show_threshold = TRUE)

Author

Lea Stark
