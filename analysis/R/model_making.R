setwd("~/Desktop/Thesis/analysis/R")

# Libraries~
library(dplyr)
library(Hmisc)
##############################################

# Load and clean Data using dplyr...

NAMCS.work <- read.csv("data/NAMCS08-11.csv", header = TRUE, stringsAsFactors = TRUE)
urgentCareOnly.df <- subset(NAMCS.work, TYPE4CLASS == "Urgent Care Center/Freestanding Clinic")

# clean badness in data
urgentCareOnly.df[c("VYEAR")][is.na(urgentCareOnly.df[c("VYEAR")])] <- 2011
urgentCareOnly.df[urgentCareOnly.df == "Blank"] <- NA
urgentCareOnly.df[urgentCareOnly.df == "Missing Data"] <- NA
urgentCareOnly.df[urgentCareOnly.df == "Missing data"] <- NA

##############################################

source("Variables.R")

Cont.model <- urgentCareOnly.df[cont.vars]
Cont.model <- na.omit(Cont.model)
dim(y)



##############################################
# Summary statistics

probtable.func <- function(variables){
  table.sums <- table(variables)
  variables.tbl <- prop.table(table.sums)
  variables.tbl
}



PctPov.tbl <-probtable.func(Cont.model$PCTPOVR)
PctBac.tbl <- probtable.func(Cont.model$PBAMORER)
Urban.tbl <- probtable.func(Cont.model$URBANRUR)
AgeGroup.tbl <- probtable.func(Cont.model$AGER)
Race.tbl <- probtable.func(Cont.model$RACER)
Sex.tbl <- probtable.func(Cont.model$SEX)
Payment.tbl <- probtable.func(Cont.model$PAYTYPER)

install.packages("hwriter")
library(hwriter)

htmlTables.func <- function(table) {
  df <- as.data.frame(table)
  html.tbl <- cat(hwrite(df, border = 0, center=TRUE, 
                         table.frame='void', width='800px', 
                         table.style='padding: 30px', row.names=FALSE, 
                         row.style=list('font-weight:bold')))
  html.tbl
}

PctPov.html <- htmlTables.func(PctPov.tbl)
PctBac.html <- htmlTables.func(PctBac.tbl)
Urban.html <- htmlTables.func(Urban.tbl)
AgeGroup.html <- htmlTables.func(AgeGroup.tbl)
Race.html <- htmlTables.func(Race.tbl)
Sex.html <- htmlTables.func(Sex.tbl)
Payment.html <- htmlTables.func(Payment.tbl)



































































































