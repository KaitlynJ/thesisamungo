# Analysis Code






#cluster table
reedtemplates::label(path = "figures/clusters.png", caption = "Identified patient typologies of urgent care centers visits (2008-2012).", 
                     label = "clus1", 
                     type = "figure", 
                     scale = .45,
                     angle = 90,
                     options = "h!")


# Logistic Model

NAMCS.logit <- NAMCS.work

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

# make model matrices
dummiesFull.df <- as.data.frame(model.matrix(~., data=logit.varset)[,-1]) 
dummiesUC.df <- as.data.frame(model.matrix(~.,data = UC.varset)[,-1])


dummy.vars <- c("HighEduc", "HighZipPov", "ZipHighIncome", "MAJORPreventative", "MAJORRoutineChronic", "PASTVIS", "SENBEFORYes, established patient", "INJURYYes", "SEXMale", "AGERRetired", "AGERWorkingAge", "WEEKENDYES", "RACERWhite", "RACEROther", "URBANRURRural", "PRIMCAREYes", "URGCAREYes", "PAYTYPERMedicaid", "PAYTYPERMedicare", "PAYTYPEROther")
dummyFull.varset <- dummiesFull.df[dummy.vars]
dummyUC.varset <- dummiesUC.df[dummy.vars]

names(dummyFull.varset)[names(dummyFull.varset) == 'SENBEFORYes, established patient'] <- 'EstablishedPatient'
names(dummyUC.varset)[names(dummyUC.varset) == 'SENBEFORYes, established patient'] <- 'EstablishedPatient'

### summary stats ##

#summary(dummy.varset)

## LOGIT ##
#head(dummy.varset)
#summary(dummy.varset)
#sapply(dummy.varset, sd)
#xtabs(~ URGCAREYes + RACERWhite, data = dummy.varset)

logit.dem <- glm(URGCAREYes ~ INJURYYes + WEEKENDYES+ PAYTYPERMedicaid+PAYTYPERMedicare+PAYTYPEROther+EstablishedPatient + PASTVIS + MAJORPreventative + MAJORRoutineChronic, data = dummyFull.varset, family = binomial)
logit.beh <- glm(URGCAREYes ~ AGERWorkingAge + AGERRetired + SEXMale + RACERWhite + ZipHighIncome + URBANRURRural, data = dummyFull.varset, family = binomial)
logit.full <- glm(URGCAREYes ~ INJURYYes + WEEKENDYES+ PAYTYPERMedicaid+PAYTYPERMedicare+PAYTYPEROther+EstablishedPatient + PASTVIS + MAJORPreventative + MAJORRoutineChronic + AGERWorkingAge + AGERRetired + SEXMale + RACERWhite + ZipHighIncome + URBANRURRural, data = dummyFull.varset, family = binomial)


logit2.dem <- glm(PRIMCAREYes ~ INJURYYes + WEEKENDYES+ EstablishedPatient + PASTVIS + MAJORPreventative + MAJORRoutineChronic, data = dummyUC.varset, family = binomial)

logit2.beh <- glm(PRIMCAREYes ~ AGERWorkingAge + AGERRetired + SEXMale + RACERWhite + ZipHighIncome + URBANRURRural, data = dummyUC.varset, family = binomial)

logit2.full <- glm(PRIMCAREYes ~ INJURYYes + WEEKENDYES + PAYTYPERMedicaid + PAYTYPERMedicare + PAYTYPEROther + EstablishedPatient + PASTVIS + MAJORPreventative + MAJORRoutineChronic + AGERWorkingAge + AGERRetired + SEXMale + RACERWhite + ZipHighIncome + URBANRURRural, data = dummyUC.varset, family = binomial)

#summary(logit2.full)
#psudeor2 <- 1 - (logit.full$deviance / logit.full$null.deviance)
#psudeor2


# Make Table

library(texreg)
texreg(list(logit.beh, logit.dem, logit.full), 
       caption = "Logistic model of the decision to go to urgent care.", 
       fontsize = "small", 
       custom.coef.names = c("Intercept", "Injury Related Visit", "Weekend Visit", "Medicaid" , "Medicare" , "SelfPay", "Established Patient", "Number Past Visits", "Visit Reason: Preventative", "Visit Reason: Routine/Chronic", "Age: Working", "Age: Retired", "Male", "Race: White", "High ZIP Income", "Rural"))

texreg(list(logit2.beh, logit2.dem, logit2.full), 
       caption = "Logistic model of the decision to use urgent care as primary care", 
       fontsize = "small",
       custom.coef.names = c("Intercept", "Injury Related Visit", "Weekend Visit", "Medicaid" , "Medicare" , "SelfPay" , "Established Patient", "Number Past Visits", "Visit Reason: Preventative", "Visit Reason: Routine/Chronic", "Age: Working", "Age: Retired", "Male", "Race: White", "High ZIP Income", "Rural"))


# Weird Diagnostics

#library(ResourceSelection)
#h1<- hoslem.test(dummiesUC.df$PRIMCAREYes, fitted(logit2.full, g =10))
#h1

#library(tree)
#urgentCareOnly.df$PRIMCAREYES <- ifelse(urgentCareOnly.df$PRIMCARE == "Yes",1,0)
#t1 <- tree(PRIMCAREYES ~. - PRIMCARE, data = urgentCareOnly.df, split = "gini")
#plot(t1)
#text(t1, pretty = 0)
#
#naCols <- vector(length=412)
#for (i in 1:412){ naCols[i] <- sum(is.na(urgentCareOnly.df[,i]))}
#subset <- urgentCareOnly.df[,which(naCols < 5)]
#subset <- subset[, sapply(subset, function(col) nlevels(col)) < 10]
#t1 <- tree(PRIMCAREYES ~. - PRIMCARE, data = subset, split = "gini")
#
#set.seed(40)
#t1cv <- cv.tree(t1, FUN = prune.misclass, data = subset)
#t1cv









