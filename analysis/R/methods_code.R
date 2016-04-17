# Methods Code

# List of packages required for this analysis
pkg <- c("dplyr", "ggplot2", "knitr", "devtools")
new.pkg <- pkg[!(pkg %in% installed.packages())]
if (length(new.pkg))
  install.packages(new.pkg, repos = "http://cran.rstudio.com")

# Load packages
library(dplyr)
library(ggplot2)
library(knitr)

