library(factoextra)
library(cluster)
library(Hmisc)

setwd("~/Desktop/Thesis/analysis")
NAMCS <- read.csv("NAMCS08-11.csv", header = TRUE)

# Fix NAs/Missing years
NAMCS[c("VYEAR")][is.na(NAMCS[c("VYEAR")])] <- 2011     # 2011's got entered blank
NAMCS[NAMCS == "Blank"] <- NA
NAMCS[NAMCS == "Missing Data"] <- NA
NAMCS[NAMCS == "Missing data"] <- NA
NAMCS[NAMCS =="Unknown"] <- NA


cluster.vars <- c("URGCARE","VDAYR","AGER","SEX", 
                  "PAYTYPER","RACER", "INJURY",
                  "PRIMCARE", "REFER","SENBEFOR",
                  "PASTVIS","MAJOR", "PCTPOVR",
                  "PBAMORER", "URBANRUR","HINCOMER",
                  "AGER","WEEKEND")

cluster.varset <- NAMCS[cluster.vars]
cluster.varset$PASTVIS <- as.numeric(cluster.varset$PASTVIS)

describe(cluster.varset)

UrgentCare <- cluster.varset[cluster.varset$URGCARE=="Yes",]

# collection of people using urgent care as primary care
PrimaryUrgent <- UrgentCare[UrgentCare$PRIMCARE=="Yes",]
describe(PrimaryUrgent)


############################################################
#Cluster Analysis
dim(UrgentCare)
UrgentCare <- na.omit(UrgentCare)

dataset <- as.data.frame(model.matrix(~., data=UrgentCare)[,-1]) 

library(dplyr)
library(cluster)
library(plyr)
library(klaR)

sample <- dataset

sample.dsy <- daisy(sample, metric = "gower", stand = TRUE)
h <- hclust(sample.dsy, method = "ward.D2")
plot(h, labels= FALSE)

z <- agnes(sample.dsy, method = "ward")
plot(z, labels=FALSE)

hcd <- as.dendrogram(h)
plot(hcd)

plot(cut(hcd, h = 3)$upper, main = "Upper tree of cut at h=2")

# install.packages('sparcl')
library(sparcl)
# colors the leaves of a dendrogram
y = cutree(h, 10)

#install.packages("wesanderson")
# Load
#library(wesanderson)
bp+scale_fill_manual(values=wes_palette(n=5, name="GrandBudapest"))

color <- wes_palette("Darjeeling", 5)
color2 <- wes_palette("Darjeeling2", 5)

branches <- as.integer(y)

for (i in 1:3016) {
  if (branches[i] == 1) {
    branches[i] = color[1] 
  } else if (branches[i] == 2){
    branches[i] = color[2]
  } else if (branches[i] == 3){
    branches[i] = color[3]
  } else if (branches[i] == 4){
    branches[i] = color[4]
  } else if (branches[i] == 5){
    branches[i] = color[5]
  } else if (branches[i] == 6){
    branches[i] = color2[1]
  } else if (branches[i] == 7){
    branches[i] = color2[2]
  } else if (branches[i] == 8){
    branches[i] = color2[3]
  } else if (branches[i] == 9){
    branches[i] = color2[4]
  } else {
    branches[i] <- color2[5]
  }
}

ColorDendrogram(h, y = branches, 
                labels = FALSE, 
                main = "Clustered Urgent Care Primary Care Patients", 
                branchlength = 10)



table(y)

########################################################################
# Pull sum stats for each cluster



library(gplots)

# create some data
d <- matrix(rnorm(120),12,10)
d <- dataset

UrgentCare <- na.omit(UrgentCare)
dataset <- as.data.frame(model.matrix(~., data=UrgentCare)[,-1]) 

# cluster it
hr <- hclust(as.dist(1-cor(t(d), method="pearson")), method="complete")


sample <- dataset
sample.dsy <- daisy(sample, metric = "gower", stand = TRUE)
hr <- hclust(sample.dsy, method = "ward.D2")

# define some clusters
mycl <- cutree(hr, h=3)

# get a color palette equal to the number of clusters
clusterCols <- rainbow(length(unique(mycl)))

# create vector of colors for side bar
myClusterSideBar <- clusterCols[mycl]

# choose a color palette for the heat map
library(gplots)
myheatcol <- rev(redgreen(75))

# draw the heat map
heatmap.2(as.matrix(sample.dsy), main="Hierarchical Cluster", Rowv=as.dendrogram(hr), Colv=NA, dendrogram="row", scale="row", col=myheatcol, density.info="none", trace="none", RowSideColors= myClusterSideBar)

# cutree returns a vector of cluster membership
# in the order of the original data rows
# examine it
mycl
summary(mycl)

# examine the cluster membership by it's order
# in the heatmap
mycl[hr$order]

# grab a cluster
cluster1 <- d[mycl == 1,]

# or simply add the cluster ID to your data
foo <- cbind(d, clusterID=mycl)

# examine the data with cluster ids attached, and ordered like the heat map
foo[hr$order,]


d=(d)[row.hc$order,]
cluster1 <- d[mycl == 1,]


# describe

describe(cluster1)



########################################################################
# k-modes

#          Create clusters        #
####################################
library(dplyr)
library(cluster)
library(plyr)
library(klaR)
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

sample <- PrimaryUrgent

#distance matrix
sample.dsy <- daisy(sample, metric = "gower", stand = TRUE)
h <- hclust(sample.dsy, method = "ward.D2")
plot(h, labels= FALSE)

z <- agnes(sample.dsy, method = "ward")
plot(z, labels=FALSE)

hcd <- as.dendrogram(h)


plot(cut(hcd, h = 4.25)$upper, main = "Upper tree of cut at h=3")


clus8 = cutree(h, 10)
table(clus8)

# pick #######################
install.packages('ape')
library(ape)
colrs <- c("pink", "blue", "yellow", "green", "purple", "orange", "magenta", "red")
plot(as.phylo(h),  type="radial", tip.color = colrs[clus8] )
title("Phylogenic Repesentation of 8 Sample Clusters")


# where to cut
k <- 5

table(cutree(z, k))
#splom(~sample[4:7], groups=sample$PAYTYPER, auto.key=TRUE, varnames = NULL)


cluster.vars <- c("URGCARE","VDAYR","AGER","SEX", "PAYTYPER","RACER", "INJURY","PRIMCARE", 
                  "REFER","SENBEFOR","PASTVIS","MAJOR", "PCTPOVR","PBAMORER", "URBANRUR","HINCOMER","AGER","WEEKEND")



sample <- na.omit(sample)
#kmodes(data, modes, iter.max = 10, weighted = FALSE)
sample.kmode <- kmodes(sample, modes = 5, iter.max = 5)

sample.kmode$withindiff



#########################################

plot(PrimaryUrgent)

mydata <- sample
d <- sample
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
wss <- rep(NA, 9)

for (i in 2:10) wss[i] <- sum(kmodes(mydata, modes = i, iter.max = 10)$withindiff)
plot(1:10, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")


library(fpc)

library(fpc)
pamk.best <- pamk(sample.dsy)
cat("number of clusters estimated by optimum average silhouette width:", pamk.best$nc, "\n")


plot(pam(sample.dsy, pamk.best$nc))
ncol(sample)


asw <- numeric(20)
for (k in 2:20)
  asw[[k]] <- pam(d, k) $ silinfo $ avg.width
k.best <- which.max(asw)
cat("silhouette-optimal number of clusters:", k.best, "\n")
# still 4

require(vegan)
fit <- cascadeKM(scale(sample.dsy, center = TRUE,  scale = TRUE), 1, 10, iter = 1000)
plot(fit, sortg = TRUE, grpmts.plot = TRUE)
calinski.best <- as.numeric(which.max(fit$results[2,]))
cat("Calinski criterion optimal number of clusters:", calinski.best, "\n")










sil <- silhouette(sample.kmode$cluster, sample.dsy)

rownames(sil) <- rownames(sample)
head(sil[, 1:3])
plot(fviz_silhouette(sil))
