dataset <- paytype.df
library(dplyr)
sample <- sample_n(dataset, 2500)

colnames(sample1) <- c("Urg Care", "Self Pay", "Priv Ins", "Hispanic","WHite","Black","Asian","Two +","Sex", "Rural", "Wealthy")