pkg <- c("dplyr", "ggplot2", "knitr", "devtools")
new.pkg <- pkg[!(pkg %in% installed.packages())]
if (length(new.pkg))
  install.packages(new.pkg, repos = "http://cran.rstudio.com")

# Load packages
library(dplyr)
library(ggplot2)
library(knitr)


setwd("~/Desktop/Thesis/analysis")
NAMCS.work <- read.csv("NAMCS08-11.csv", header = TRUE)
urgentCareOnly.df <- subset(NAMCS.work, TYPE4CLASS == "Urgent Care Center/Freestanding Clinic")

# fixing NAs/blanks
urgentCareOnly.df[c("VYEAR")][is.na(urgentCareOnly.df[c("VYEAR")])] <- 2011
urgentCareOnly.df[urgentCareOnly.df == "Blank"] <- NA
urgentCareOnly.df[urgentCareOnly.df == "Missing Data"] <- NA
urgentCareOnly.df[urgentCareOnly.df == "Missing data"] <- NA

cont.vars <- c("PCTPOVR", "PBAMORER", "URBANRUR", "AGER", "RACER", "SEX", "PAYTYPER")
Cont.model <- urgentCareOnly.df[cont.vars]
Cont.model <- na.omit(Cont.model)


probtable.func <- function(variable){
  # get name
  category <- deparse(substitute(variable))
  category <- data.frame(name = category, variable = "", Freq = " ", stringsAsFactors = FALSE)
  # get proportions
  table.sums <- table(variable)
  variable.tbl <- round(prop.table(table.sums)*100, 2)
  variable.df <- as.data.frame(variable.tbl, stringsAsFactors = FALSE)
  # add id rows
  variable.df <- cbind(data.frame(name = "", stringsAsFactors = FALSE), variable.df)
  variable.df <- rbind( variable.df[0,0], category, variable.df[] )
  
  variable.df
}

#pretty names
PercentPoverty <- Cont.model$PCTPOVR
PercentBachelors <- Cont.model$PBAMORER
UrbanCategory <- Cont.model$URBANRUR
AgeGroup <- Cont.model$AGER
Race <- Cont.model$RACER
Sex <- Cont.model$SEX
PaymentType <- Cont.model$PAYTYPER

library(dplyr)



t1 <- probtable.func(Sex) 
t2 <- probtable.func(AgeGroup)
t3 <- probtable.func(Race)
t4 <- probtable.func(PaymentType)
t5 <- probtable.func(UrbanCategory)
t6 <- probtable.func(PercentPoverty)
t7 <- probtable.func(PercentBachelors) 

demographics.tbl <- rbind(t1, t2, t3, t4, t5, t6)


kable(demographics.tbl,
      col.names = c("Variable", "Category", "Percentage"),
      caption = "Observed Proportions of Independant Variables \\label{tab:sums}")