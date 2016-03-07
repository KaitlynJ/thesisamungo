# clean data #
#############################

setwd("~/Desktop/fuuuuuck/NAMCS/txt/")
library(dplyr)
NAMCS.work <- read.csv("data/NAMCS08-11.csv", header = TRUE, stringsAsFactors = TRUE)
work.tbl <- tbl_df(NAMCS.work)
urgentCare.sub <- subset(NAMCS.work, TYPE4CLASS == "Urgent Care Center/Freestanding Clinic")
dim(urgentCare.sub)
#left with 3863 observations of urgent care visits

#fix year/blanks
urgentCare.sub[c("VYEAR")][is.na(urgentCare.sub[c("VYEAR")])] <- 2011
urgentCare.sub[urgentCare.sub == "Blank"] <- NA
urgentCare.sub[urgentCare.sub == "Missing Data"] <- NA
dim(urgentCare.sub)

all.vars <- c("VMONTH",
                  "VYEAR",
                  "VDAYR",
                  "AGE",
                  "SEX",
                  "ETHUN",
                  "RACEUN",
                  "PAYPRIV",
                  "PAYMCARE",
                  "PAYMCAID",
                  "PAYWKCMP",  
                  "PAYSELF"   ,
                  "PAYNOCHG"   ,
                  "PAYOTH",
                  "PAYDK"  ,    
                  "PAYTYPER",   
                  "USETOBAC" ,    
                  "INJURY"    , 
                  "RFV1"     ,
                  "RFV13D"   ,
                  "PRIMCARE"  , 
                  "REFER"      ,
                  "SENBEFOR"   ,
                  "PASTVIS"    ,
                  "MAJOR"     ,
              
"ARTHRTIS","ASTHMA","CANCER","CASTAGE","CEBVD","CHF","CRF","COPD","DEPRN","DIABETES","HYPLIPID","HTN","IHD","OBESITY","OSTPRSIS",  
"NOCHRON",
"TOTCHRON",   
"TOTDIAG"  ,  
"HEALTHED"  , "ASTHMAED"   ,"DIETNUTR"  ,"EXERCISE" ,  "GRWTHDEV" ,  "INJPREV"  ,  "STRESMGT" ,  "TOBACED"  ,  "WTREDUC"    ,"OTHLTHED"   ,
"TOTHLTED"   ,
"TOTNONMED"  ,
"NCMED1",
"NUMNEW",
"NUMCONT"  ,  
"NUMMED" ,    
"PHYS"   ,    
"PHYSASST" ,  
"NPNMW"     , 
"RNLPN"     ,
"MHP"        ,
"OTHPROV" ,
"NOFU"     ,  
"RETPRN"    , 
"REFOTHMD"   ,
"RETAPPT"    ,
"TELEPHON"   ,
"REFERED"    ,
"ADMITHOS"  ,
"OTHDISP" ,
"REGION"   ,
"MSA"  ,
"RETYPOFF"   ,
"SOLO"       ,
"EMPSTAT"    ,
"OWNS"      ,
"LAB"    ,
"PATEVEN" ,  
"TELCONR"  ,  
"ECONR",
"PRMCARER",   
"PRMAIDR"  ,  
"PRPRVTR"   , 
"PRPATR"    ,
"PROTHR",
"PCCPROD",    
"PCCSAT"  ,   
"PCCQOC"   ,  
"PCCPPROF"  , 
"RACER"      ,
"AGEDAYS" ,  
"AGER"  ,
"SETTYPE",   
"PCTPOVR" ,  
"HINCOMER" ,  
"PBAMORER"  , 
"URBANRUR"  , 
"SERVICES" ,
"ERADMHOS"  ,
"INJR1",
"INJDETR1",   
"INJDETR2" ,  

"URGCARE"   ,
"WEEKEND")

dem.vars <- c("PCTPOVR" ,  
              "HINCOMER" ,  
              "PBAMORER"  , 
              "URBANRUR",
              "RACEETH",
              "VDAYR",
              "AGE",
              "AGER",
              "SEX",
              "PAYTYPER",
              "INJURY"    ,
              "PRIMCARE"  , 
              "REFER"      ,
              "SENBEFOR"   ,
              "PASTVIS"    ,
              "MAJOR")

cont.vars <- c("PCTPOVR" ,
               "PBAMORER"  ,
               "URBANRUR",
               "AGER",
               "RACER",
               "SEX",
               "PAYTYPER"
               )
               
beh.vars <- c(              "AGER",
                            "SEX",
                            "RACER",
                            "URBANRUR",
                            "PAYTYPER",
                            "INJURY"    ,
                           # "PRIMCARE"  , 
                            "SENBEFOR"   ,
                            "PASTVIS"    ,
                            "MAJOR",
                            "WEEKEND"
                            )


               
              

model.sub <- urgentCare.sub[beh.vars]
y <- na.omit(model.sub)
dim(y)




#          Create clusters        #
####################################
library(dplyr)
library(cluster)
library(plyr)

sample <- sample_n(y, 200)

##################


revalue(sample$PCTPOVR, c("Missing data"="Missing", 
                          "Quartile 1 (Less than 5.00 percent)"="Q1: <5%", 
                          "Quartile 2 (5.00-9.99 percent)" = "Q2: 5-10%",  
                          "Quartile 3 (10.00-19.99 percent)" = "Q3: 10-20%",
                          "Quartile 4 (20.00 percent or more)" = "Q4: >20%"))

revalue(sample$PAYTYPER, c("All sources of payment are blank"="Missing", 
                           "Worker's compensation" = "Work Comp"))

revalue(sample$URBANRUR, c("Micropolitan/noncore (nonmetro)"="Rural", 
                           "Missing data" = "Missing"))

#View(sample)

# k-modes######################################################

library(klaR)

#distance matrix
sample.dsy <- daisy(sample, metric = "gower", stand = TRUE)


# pick #
install.packages('ape')
library(ape)

colrs <- c("pink", "blue", "yellow", "green", "purple", "orange", "magenta", "red")

h <- hclust(dsy1, method = "ward.D2")
plot(h, labels= FALSE)

clus8 = cutree(h, 16)
table(clus8)

plot(clus8)

plot(as.phylo(h),  type="radial", tip.color = colrs[clus8] )
title("Phylogenic Repesentation of 8 Sample Clusters")

z <- agnes(dsy1, method = "ward")

plot(z, labels=FALSE)


plot(as.phylo(z$[1]), type = "radial")

title

# where to cut
k <- 9

table(cutree(z, k))
#splom(~sample[4:7], groups=sample$PAYTYPER, auto.key=TRUE, varnames = NULL)





# EXPERIMENT 1 ----------------------------------
X.hclustPL.wardD2 = hclust.PL(dist(y),method="ward.D2")
X.agnes.wardD2 = agnes(dist(y),method="ward")

#identical!


#kmodes(data, modes, iter.max = 10, weighted = FALSE)
sample.kmode <- kmodes(sample, modes = k, iter.max = 10, weighted = FALSE)
cl
cl$modes
summary(cl)

## ways of viewing

#id <-
sample.clus.km <- lapply(1:k, function(nc)
  id[cl$cluster==nc])
sample.clus.km

#sillouette
dsy2   <- dsy1^2
sk2   <- silhouette(cl$cluster, dsy2)
plot(sk2)

plot(cl$withindiff)

clusplot(sample, clus = cl$cluster, color=TRUE, shade=FALSE,
         labels=0, lines=0, )

########################################################################









sample <- scale(sample)
summary(dsy1 <- daisy(sample, metric = "gower"))

mod1 <- Mclust(dsy1)

summary(mod1, parameters = TRUE)

plot(mod1)




s1.dist <- dist(sample, method = "binary")




summary(dsy1 <- daisy(sample, metric = "gower"))


### trying agglom ########################################################

z <- agnes(dsy1)

plot(agnes(dsy1))

table(cutree(z, 8), sample$PAYTYPER)

splom(~sample[4:7], groups=sample$PAYTYPER, auto.key=TRUE, varnames = NULL)


###############

h <- hclust(dsy1, method = "ward.D")
print(h)

plot(h,labels=sample$PAYTYPER)
title("Dendrogram of employment figures: Complete")

#greatest distance?
h.cl<-h$height # height values
h.cl2<-c(0,h.cl[-length(h.cl)])
max(round(h.cl-h.cl2,3))
which.max(round(h.cl-h.cl2,3))

#sums of groups
choose <- 4

groups.choose <- cutree(h, choose)
table(groups.choose)

VAR <- sample$PCTPOVR

##
sample.use <- sample[,-c(1,2)]
modes <- apply(levels(sample), 2, mode)


##
sapply(unique(groups.choose), function(g)sample$URBANRUR[groups.choose == g])
table(groups.choose, sample$RACER)


aggregate(sample,list(groups.choose), median)

aggregate(dsy1, list(groups.choose), mean)

sample$PCTPOVR[groups.choose]











## and visualize with some jitter:
plot(sample, col = cl$cluster)
plot(sample[1:4],col=cl$cluster)
points(cl$modes, col = 1:4, pch = 2)

summary(cl$modes)
plot()

clusplot(sample, cl$cluster, color=TRUE)


#####################################################

dissE <- daisy(sample) 
dE2   <- dissE^2
sk2   <- silhouette(cl$cluster, dE2)
plot(sk2)












#####################################################
clusters.km <- kmeans(dsy1, 4) 

clusplot(sample, cl$cluster, color=TRUE, shade=FALSE,
         labels=0, lines=0, )


k <- 4
clusters.km <- kmeans(dsy1, k)

## setting names of rows
id <- sample$PAYTYPER


## ways of viewing



sample.clus.km <- lapply(1:k, function(nc)
  id[clusters.km$cluster==nc])

sample.clus.km




