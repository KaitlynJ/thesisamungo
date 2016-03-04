# Load in data
setwd("~/Desktop/Thesis/analysis")
NAMCS.logit <- read.csv("NAMCS08-11.csv", header = TRUE)
                        
# fixing NAs/blanks
NAMCS.logit[c("VYEAR")][is.na(NAMCS.logit[c("VYEAR")])] <- 2011     # 2011's got entered blank
NAMCS.logit[NAMCS.logit == "Blank"] <- NA
NAMCS.logit[NAMCS.logit == "Missing Data"] <- NA
NAMCS.logit[NAMCS.logit == "Missing data"] <- NA

View(NAMCS.logit)


# making (maybe not sure this works*) names shorter for visualization
revalue(urgentCareOnly.df$PCTPOVR, c("Missing data"="Missing",
                                     "Quartile 1 (Less than 5.00 percent)"="Q1: <5%", 
                                     "Quartile 2 (5.00-9.99 percent)" = "Q2: 5-10%",  
                                     "Quartile 3 (10.00-19.99 percent)" = "Q3: 10-20%",
                                     "Quartile 4 (20.00 percent or more)" = "Q4: >20%"))
revalue(urgentCareOnly.df$PAYTYPER, c("All sources of payment are blank"="Missing", "Worker's compensation" = "Worker's Comp"))
revalue(urgentCareOnly.df$URBANRUR, c("Micropolitan/noncore (nonmetro)"= "Rural", "Missing data" = "Missing"))

factor(NAMCS.logit$VDAYR)

#recoding
logit.vars <- c("PCTPOVR", "HINCOMER", "PBAMORER", "URBANRUR", "RACER", "WEEKEND", "AGER", "SEX", "URBANRUR","PAYTYPER","INJURY", "PRIMCARE", "SENBEFOR", "PASTVIS", "MAJOR", "WEEKEND")
logit.varset <- NAMCS.logit[logit.vars]
logit.varset <- na.omit(logit.varset)
dim(logit.varset)
dummies <- as.data.frame(model.matrix(~., data=logit.varset)[,-1]) 
dummies <- model.matrix( ~ logit.varset)
logit.dummies <- subset(dummies, select = c("PCTPOVRQuartile 1 (Less than 5.00 percent)", 
                                            "PCTPOVRQuartile 4 (20.00 percent or more)", 
                                            "HINCOMERQuartile 4 ($52,388 or more)", 
                                            "PBAMORERQuartile 1 (Less than 12.84 percent)",
                                            "URBANRURMicropolitan/noncore (nonmetro)",
                                            "RACERWhite",
                                            "WEEKENDYES",
                                            "PAYTYPERPrivate insurance",
                                            "INJURYYes",
                                            "SENBEFORYes, established patient",
                                            "PRIMCAREYes"))
                                            
                                            

logit <- glm(logit.dummies$PRIMCAREYes ~., data = logit.dummies)

summary(logit)

subset(NAMCS.work, NAMCS.work$TYPE4CLASS == "Urgent Care Center/Freestanding Clinic")

dummies <- as.data.frame(model.matrix(~., data=logit.varset)[,-1]) 
model.matrix(~., data=logit.varset)[,-1]

model.matrix( ~ Species - 1, data=iris )

# recode poverty: wealthy. poor.
logit.varset$NoZipPov <- as.numeric(logit.varset$PCTPOVR == "Quartile 1 (Less than 5.00 percent)")
logit.varset$ZipPov <- as.numeric(logit.varset$PCTPOVR == "Quartile 4 (20.00 percent or more)")
logit.varset$ZipHighIncome <- as.numeric(logit.varset$HINCOMER == "Quartile 4 ($52,388 or more)")
logit.varset$Young <- as.numeric()

dataset$newvar <- as.numeric(dataset$var == txt)

year.f = factor(looking.df$NAMCS.df.VDAYR)
dummies = model.matrix(~year.f)


  



