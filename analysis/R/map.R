install.packages("mapproj")
install.packages("ggmap")
install.packages("DeducerSpatial")

require(maps)
require(ggmap)

map("usa")
map("county")
?map
map("county", fill = TRUE, resolution = 0,
    lty = 0, projection = "polyconic")
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1, lwd = 0.2,
    projection="polyconic")
title("unemployment by county, 2009")
legend("topright", leg.txt, horiz = TRUE, fill = colors)


library(UScensus2010)
library(UScensus2000tract)
data("MSAnames")
data("state.cartoMapEnv")
data(california.tract)
summary(as(MSAnames, "block")
summary(as(state.cartoMapEnv,"SpatialPolygons"))
names(california.tract)

MSA()



install.packages("acs", clean=T)
install.packages("ggplot2")
install.packages("maps")
library(acs)
library(ggplot2)
library(maps)

county.df <- map_data("county")
names(county.df)[5:6] <- c("state","county")
state.df <- map_data("state")
us.county <- geo.make(state="*", county="*")

us.transport=acs.fetch(geography=us.county, 
                       table.number="B08301", col.names="pretty")



install.packages("acs")
install.packages("ggplot2")
install.packages("maps")
library(acs)
library(ggplot2)
library(maps)
county.df=map_data("county")
names(county.df)[5:6]=c("state","county")
state.df=map_data("state")
us.county=geo.make(state="*", county="*")
us.transport=acs.fetch(geography=us.county, 
                       table.number="B08301", col.names="pretty", endyear = 2011)
us.pub.trans=divide.acs(numerator=us.transport[,10], 
                        denominator=us.transport[,1], method="proportion")
pub.trans.est=data.frame(county=geography(us.pub.trans)[[1]], 
                         percent.pub.trans=as.numeric(estimate(us.pub.trans)))
pub.trans.est$county=gsub("Parish", "County", pub.trans.est$county)
pub.trans.est$state=tolower(gsub("^.*County, ", "", pub.trans.est$county))
pub.trans.est$county=tolower(gsub(" County,.*", "", pub.trans.est$county))
choropleth=merge(county.df, pub.trans.est, by=c("state","county"))
choropleth=choropleth[order(choropleth$order), ]
choropleth$pub.trans.rate.d=cut(choropleth$percent.pub.trans, 
                                breaks=c(0,.01,.02,.03,.04,.05,.1,1), include.lowest=T)
ggplot(choropleth, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = pub.trans.rate.d), colour = "white", size = 0.2) + 
  geom_polygon(data = state.df, colour = "white", fill = NA) +
  scale_fill_brewer(palette = "Purples")

#####################
head(fips.county)

us.dat <- map_data("state")
ct.dat <- map_data("county")
ggplot() + 
  geom_polygon(aes(long,lat, group=group), fill="grey65", data=ct.dat) + 
  geom_polygon(aes(long,lat, group=group), color='white', fill=NA, data=us.dat) + 
  theme_bw() + 
  theme(axis.text = element_blank(), axis.title=element_blank())


library(ggplot2)
ggplot(choropleth, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = rate_d), colour = alpha("white", 1/2), size = 0.2) + 
  geom_polygon(data = state_df, colour = "white", fill = NA) +
  scale_fill_brewer(palette = "PuRd")





m1 <- merge(msa.df, MSAnames, by.x = ""







