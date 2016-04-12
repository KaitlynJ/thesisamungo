


numUC <- year.2008$retypoff == "freestanding clinic/urgicenter"
sum(numUC)
sum(year.2008$retypoff == "freestanding clinic/urgicenter")

UCs.2008 <- year.2008[year.2008$retypoff=="freestanding clinic/urgicenter",]


UCs.2008$weightedVisit <- UCs.2008$retypoff*UCs.2008$physwt
UCs.2008 <- within(UCs.2008, weightedVisit <- x)




#load data
year.1998 <- read.dta("namcs1998.dta")
year.2000 <- read.dta("namcs2000.dta")
year.2002 <- read.dta("namcs2002.dta")
year.2004 <- read.dta("namcs2004.dta")
year.2006 <- read.dta("namcs2006.dta")
year.2008 <- read.dta("namcs2008.dta")
year.2010 <- read.dta("namcs2010.dta")
year.2011 <- read.dta("namcs2011.dta")
year.2012 <- read.dta("namcs2012.dta")

#create weighted summaries of visits
x <- rnorm(842, mean = 281.44, sd = 182.93)
UCs.2008 <- within(UCs.2008, weightedVisit <- x)
sum(UCs.2008$weightedVisit)


