library(factoextra)
library(cluster)

library(Hmisc)
setwd("~/Desktop/Thesis/analysis")
NAMCS.logit <- read.csv("NAMCS08-11.csv", header = TRUE)

# fixing NAs/blanks
NAMCS.logit[c("VYEAR")][is.na(NAMCS.logit[c("VYEAR")])] <- 2011     # 2011's got entered blank
NAMCS.logit[NAMCS.logit == "Blank"] <- NA
NAMCS.logit[NAMCS.logit == "Missing Data"] <- NA
NAMCS.logit[NAMCS.logit == "Missing data"] <- NA
NAMCS.logit[NAMCS.logit =="Unknown"] <- NA

# variable selection
logit.vars <- c("URGCARE","PRIMCARE","PCTPOVR", "HINCOMER", "PBAMORER", "URBANRUR", "RACER", "WEEKEND", "AGER", "SEX","PAYTYPER",
                "INJURY","SENBEFOR", "PASTVIS", "MAJOR")
logit.varset <- NAMCS.logit[logit.vars]
logit.varset <- na.omit(logit.varset)


# recoding
logit.varset$ZipHighIncome <- as.numeric(logit.varset$HINCOMER == "Quartile 4 ($52,388 or more)")
logit.varset$HighZipPov <- as.numeric(logit.varset$PCTPOVR == "Quartile 4 (20.00 percent or more)")
logit.varset$HighEduc<- as.numeric(logit.varset$PBAMORER == "Quartile 4 (31.69 percent or more)")
levels(logit.varset$URBANRUR) <- list(Urban=c("Large central metro", "Large fringe metro", "Medium metro"), 
                                      Rural=c("Micropolitan/noncore (nonmetro)", "Small metro"))
levels(logit.varset$AGER) <- list(YoungAdult=c("Under 15 years", "15-24 years"),
                                  WorkingAge=c("25-44 years", "45-64 years"),
                                  Retired=c("65-74 years", "75 years and over"))

levels(logit.varset$PAYTYPER) <- list(PrivateIns=c("Private insurance"),
                                      Medicaid=c("Medicaid"),
                                      Medicare=c("Medicare"),
                                      Other=c("Other", "No charge", "Unknown","Worker's compensation", "All sources of payment are blank", "Self-pay" ))

levels(logit.varset$MAJOR) <- list(NewProblem=c("New problem (less than 3 mos. onset)"),
                                   RoutineChronic=c("Pre-/Post-surgery", "Chronic problem, routine", "Chronic problem, flare-up"),
                                   Preventative=c("Preventive care"),
                                   Other=c("Blank", "No charge", "Pre-/Post-surgery"))

logit.varset$PASTVIS <- as.numeric(logit.varset$PASTVIS)


#urgentcareonly model
UC.varset <-subset(logit.varset, logit.varset$URGCARE == "Yes")

dummiesUC.df <- as.data.frame(model.matrix(~.,data = UC.varset)[,-1])
dummiesUC.df<- scale(dummiesUC.df)

res <- get_clust_tendency(dummiesUC.df, 40, graph = FALSE)
res$hopkins_stat

set.seed(123)
# Compute the gap statistic
gap_stat <- clusGap(dummiesUC.df, FUN = kmeans, nstart = 25, 
                    K.max = 10, B = 5) 
library(factoextra)
fvi
fviz_gap_stat(gap_stat)

set.seed(123)
km.res <- kmeans(dummiesUC.df, 9, nstart = 25)
head(km.res$cluster, 20)

fviz_cluster(km.res, dummiesUC.df)
