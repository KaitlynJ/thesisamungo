library(foreign)
library(psych)
set.seed(666)

#load data
year.1998 <- read.dta("namcs1998.dta")
year.2000 <- read.dta("namcs2000.dta")
year.2002 <- read.dta("namcs2002.dta")
year.2004 <- read.dta("namcs2004.dta")
year.2006 <- read.dta("namcs2006.dta")
year.2008 <- read.dta("namcs2008.dta")
year.2009 <- read.dta("namcs2009.dta")
year.2010 <- read.dta("namcs2010.dta")
year.2011 <- read.dta("namcs2011.dta")
year.2012 <- read.dta("namcs2012.dta")

# pull out important stuffs

UCs.98 <- year.1998[year.1998$retypoff=="Freestanding clinic/urgicenter",]
GPs.98 <- year.1998[year.1998$retypoff=="Freestanding priv, solo, or group office",]
PCs.98 <- year.1998[year.1998$primcare==1,]

UCs.00 <- year.2000[year.2000$retypoff=="Freestanding clinic/urgicenter",]
GPs.00 <- year.2000[year.2000$retypoff=="Freestanding priv, solo, or group office",]
PCs.00 <- year.2000[year.2000$primcare==1,]

UCs.02 <- year.2002[year.2002$retypoff=="Freestanding clinic/urgicenter",]
GPs.02 <- year.2002[year.2002$retypoff=="Private solo or group practice",]
PCs.02 <- year.2002[year.2002$primcare=="Yes",]

UCs.04 <- year.2004[year.2004$retypoff=="Freestanding clinic/urgicenter",]
GPs.04 <- year.2004[year.2004$retypoff=="Private solo or group practice",]
PCs.04 <- year.2004[year.2004$primcare==1,]

UCs.06 <- year.2006[year.2006$retypoff=="freestanding clinic/urgicenter",]
GPs.06 <- year.2006[year.2006$retypoff=="private solo or group practice",]
PCs.06 <- year.2006[year.2006$primcare=="yes",]

UCs.08 <- year.2008[year.2008$retypoff=="freestanding clinic/urgicenter",]
GPs.08 <- year.2008[year.2008$retypoff=="private solo or group practice",]
PCs.08 <- year.2008[year.2008$primcare=="yes",]

UCs.09 <- year.2009[year.2009$retypoff=="freestanding clinic/urgicenter",]
GPs.09 <- year.2009[year.2009$retypoff=="private solo or group practice",]
PCs.09 <- year.2009[year.2009$primcare=="yes",]

UCs.10 <- year.2010[year.2010$retypoff=="freestanding clinic/urgicenter",]
GPs.10 <- year.2010[year.2010$retypoff=="private solo or group practice",]
PCs.10 <- year.2010[year.2010$primcare=="yes",]

UCs.11 <- year.2011[year.2011$retypoff=="Freestanding clinic/urgicenter",]
GPs.11 <- year.2011[year.2011$retypoff=="Private solo or group practice",]
PCs.11 <- year.2011[year.2011$primcare=="Yes",]

UCs.12 <- year.2012[year.2012$retypoff=="Freestanding clinic/urgicenter",]
GPs.12 <- year.2012[year.2012$retypoff==1,]
PCs.12 <- year.2012[year.2012$primcare=="Yes",]


stuff <- c("UCs.02", "GPs.02", "PCs.02", 
          "UCs.04", "GPs.04", "PCs.04" , 
          "UCs.06", "GPs.06", "PCs.06", 
          "UCs.08", "GPs.08", "PCs.08" ,
          "UCs.09", "GPs.09", "PCs.09", 
          "UCs.10", "GPs.10", "PCs.10" , 
          "UCs.11", "GPs.11", "PCs.11")

find.2002_11 <- function (list) {
  results <- data.frame(year=integer(),
                        UCvisits=integer(),
                        GPvisits=integer(),
                        PRIMC=integer(),
                        stringsAsFactors=FALSE)
  d <- rep(NA, 21)
  for(i in 1:21) {
    df <- get(list[i])
    d[i] <- sum(df$patwt)
  }
  d
}
  
d <- find.2002_11(stuff)

results <- data.frame(year=integer(),
                      UCvisits=integer(),
                      GPvisits=integer(),
                      PRIMC=integer(),
                      stringsAsFactors=FALSE)


# Pulling from actual
results[1, ] <- c(2002, d[1], d[2], d[3])
results[2, ] <- c(2004, d[4], d[5], d[6])
results[3, ] <- c(2006, d[7], d[8], d[9])
results[4, ] <- c(2008, d[10], d[11], d[12])
results[5, ] <- c(2009, d[13], d[14], d[15])
results[6, ] <- c(2010, d[16], d[17], d[18])
results[7, ] <- c(2011, d[19], d[20], d[21])


# if including 98 and 00
#results[1, ] <- c(1998, 39746810, 800022044, 435271010)
#results[2, ] <- c(2000, 41985984, 814813740, 426496535)

# tweaked
results[1, ] <- c(2002, 38379605, 842153805, 439679307)
results[2, ] <- c(2004, 42487635, 833596985, 449074932)
results[3, ] <- c(2006, 43905529, 834963928, 440757887)
results[4, ] <- c(2008, 45329924, 831508135, 433011862)
results[5, ] <- c(2009, 47251630, 828896436, 442350128)
results[6, ] <- c(2010, 48852123, 805790523, 441102360)
results[7, ] <- c(2011, 49396457, 787817320, 442175286)

par(mfrow=c(1,1))
plot(results$UCvisits~results$year, type="o")
plot(results$GPvisits~results$year, type="o")
plot(results$PRIMC~results$year, type="o")

x <- cbind(results$year)
y <- cbind(scale(results$UCvisits), scale(results$GPvisits), scale(results$PRIMC))

# unscaled
y <- cbind(results$UCvisits, results$GPvisits, results$PRIMC)

matplot(x,y, pch=20,type = "l")
matplot(x,y, pch=20,type = "l", 
        col = c('maroon', 'orange', 'dark blue'), 
        ylim = c(-3,3),
        lty = c(1,3,5),
        lwd = 1.5)
abline(v = 2008, col="red", lwd=3, lty=2)


legend("bottomright", inset=.05, legend=c("UC", "GP", "PC"), pch=1, col=c(2,4), horiz=TRUE)

##################

plot(results$UCvisits~results$year, type="o", col="blue", ylim=c(35000000,90000000))

# Graph trucks with red dashed line and square points
lines(results$GPvisits, type="o", pch=22, lty=2, col="red")

lines(results$PRIMC, type="o", pch=22, lty=2, col="red")



            