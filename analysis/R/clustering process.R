

cluster.vars <- c("URGCARE","VDAYR","AGER","SEX", "PAYTYPER","RACER", "INJURY","PRIMCARE", 
                  "REFER","SENBEFOR","PASTVIS","MAJOR", "PCTPOVR","PBAMORER", "URBANRUR","HINCOMER","AGER","WEEKEND")

# fixing NAs/blanks
NAMCS.work[c("VYEAR")][is.na(NAMCS.work[c("VYEAR")])] <- 2011     # 2011's got entered blank
NAMCS.work[NAMCS.work == "Blank"] <- NA
NAMCS.work[NAMCS.work == "Missing Data"] <- NA
NAMCS.work[NAMCS.work == "Missing data"] <- NA
NAMCS.work[NAMCS.work =="Unknown"] <- NA

cluster.varset <- NAMCS.work[cluster.vars]
cluster.varset$PASTVIS <- as.numeric(cluster.varset$PASTVIS)

dim(cluster.varset)
cluster.varset <- na.omit(cluster.varset)
cluster.varset <-subset(cluster.varset, cluster.varset$URGCARE == "Yes")

cluster.MM <- as.data.frame(model.matrix(~., data=cluster.varset)[,-1]) 

dataset <- cluster.MM
library(dplyr)

sample <- sample_n(dataset, 500)


colnames(sample) <- c("Urg", "Private Ins", "Emergency", "Weekend", "Return")


#one way
class = sample$PRIMCARE
table(class)

X = sample[,-1]
head(X)

library(mclust)
#clPairs(X, class)

BIC = mclustBIC(X)
summary(BIC)

mod1 = Mclust(sample)
summary(mod1, parameters = TRUE)

plot(mod1)

BICtable(class, mod1$classification)

mod2 = MclustDA(X, class, modelType = "MclustDA")
summary(mod2)
plot(mod2, what = "scatterplot")


mod3 = MclustDA(X, class)
summary(mod3)
plot(mod3, what = "scatterplot")


mod4 = densityMclust(sample)
summary(mod4)
plot(mod4, what = "BIC")
plot(mod4, what = "density", type = "image", 
     col = "dodgerblue3", grid = 100)
plot(mod4, what = "density", type = "persp")



boot1 = MclustBootstrap(mod1)
summary(boot1, what = "se")

mod1dr = MclustDR(mod1)
summary(mod1dr)











#viewing

fit <- Mclust(sample)

#dendrogram
plot(model)

#mclust
plot(fit)



##new?/

devtools::install_github("kassambara/factoextra")
data("f")

set.seed(123)
km.sample <- kmeans(sample, 6)
plotcluster(sample, km.sample$cluster)


library(cluster)
library(HSAUR)




km    <- kmeans(sample, 9)
dissE <- daisy(sample) 
dE2   <- dissE^2
sk2   <- silhouette(km$cl, dE2)
plot(sk2)




library(cluster)
library(fpc)

data(iris)
dat <- iris[, -5] # without known classification 
# Kmeans clustre analysis
clus <- kmeans(dat, centers=3)
# Fig 01
plotcluster(dat, clus$cluster)



clusplot(sample, km.sample$cluster, color=TRUE, shade=TRUE, 
         labels=2, lines=0, cor = FALSE)



