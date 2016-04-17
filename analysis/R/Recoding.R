# Example: dummy <- as.numeric(year == 1957)

#create dummies data frame
#demDummies.df <- data.frame()

#get rid of blanks
#Example: my.data[my.data == ""] <- NA
#Example: my.data[complete.cases(my.data),]



dataset <- important.df

dataset[dataset == "Blank"] <- NA
dataset[dataset == "Missing data"] <- NA

dataset <- dataset[complete.cases(dataset), ]

#recoding

txt <- 
newvar <-
var<-

dataset$newvar <- as.numeric(dataset$var == txt)

year.f = factor(looking.df$NAMCS.df.VDAYR)
dummies = model.matrix(~year.f)

looking.df$TYPE4CLASS.dum <- as.numeric(looking.df$TYPE4CLASS == "Urgent Care Center/Freestanding Clinic")
looking.df$PAYSELF.dum <- as.numeric(looking.df$PAYSELF == "Yes")
looking.df$HISPANIC.dum <- as.numeric(looking.df$ETHUN == "Hispanic or Latino")
looking.df$WHITE.dum <- as.numeric(looking.df$RACEUN == "White Only")
looking.df$BLACK.dum <- as.numeric(looking.df$RACEUN == "Black/African American Only")
looking.df$ASIAN.dum <- as.numeric(looking.df$RACEUN == "Asian Only")
looking.df$TWOPLUS.dum <- as.numeric(looking.df$RACEUN == "More than one race reported")
looking.df$PAYPRIV.dum <- as.numeric(looking.df$PAYPRIV == "Yes")
looking.df$SEX.dum <- as.numeric(looking.df$SEX == "Male")
looking.df$RURAL.dum <- as.numeric(looking.df$URBANRUR == "Micropolitan/noncore (nonmetro)")
looking.df$WEALTHY.dum <- as.numeric(looking.df$HINCOMER == "Quartile 4 ($52,388 or more)")
looking.df$SENBEFORE.dum <- as.numeric(looking.df$NAMCS.df.SENBEFOR)
looking.df$WEEKEND.dum <- 

# quality check:
#> sum(looking.df$TYPE4CLASS == "Urgent Care Center/Freestanding Clinic")
#[1] 2459
#> sum(looking.df$TYPE4CLASS.dum == 1)
#[1] 2459
#> sum(looking.df$SEX == "Male")
#[1] 34423
#> sum(looking.df$SEX.dum == 1)
#[1] 34423




