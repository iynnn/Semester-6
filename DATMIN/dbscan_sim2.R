#CONTOH 1: data simulation
x<-c(2,1,5,6,6,6,10,11,12,14,15,16,
     17,17,11,20,8,24,22,25,26,18,19)
y <- NA
for(i in 1:length(x)){
  y[i]<-2.4+1.65*x[i]+rnorm(1,0,8)
}

c1 <- as.data.frame(cbind(x,y))
plot(c1)

library(MASS)
Sigma <- matrix(c(3,-2,-2,2),2,2)
set.seed(20)
mvnorm<-mvrnorm(n = 20, c(5,55), Sigma, tol = 1e-6, 
                empirical = FALSE, EISPACK = FALSE)
mvnorm<-as.data.frame(mvnorm)
colnames(mvnorm)<-c("x","y")
datgab <- rbind(c1,mvnorm)
plot(datgab)

#dbscan
library(dbscan)
library(factoextra)
#tuning MinPts
par(mfrow=c(1,2))
kNNdistplot(datgab,k=5)
abline(h=2)
kNNdistplot(datgab,k=7)
abline(h=2)

#MinPts terpilih adalah 6
dev.off()
kNNdistplot(datgab, k=6)
abline(h=3)

sim_clust <- dbscan(datgab,3,6)
sim_clust
fviz_cluster(sim_clust, datgab, ellipse = FALSE, 
             geom = "point",main = "DBSCAN")

#kmeans
km_clust <- kmeans(datgab,2)
fviz_cluster(km_clust, datgab, ellipse = FALSE, 
             geom = "point",main = "KMEANS")


##CONTOH 2 DATA GEMPA
library(dplyr)
library(dbscan)
library(factoextra)
gempa <- read.csv("Data Gempa.csv",header = TRUE)
gempa_java <- gempa%>%mutate(Lat = case_when(SN=="S" ~ -1*Lat,
                                             SN=="N" ~ Lat))%>%filter(Region == "Java, Indonesia")
write.csv(gempa_java[,c(1,3,5,7,8)],file = "gempajawa.csv")

kotajawa <- read.csv("kotajawa.csv", header = TRUE)

plot(gempa_java$Lon,gempa_java$Lat)
points(kotajawa$Long,kotajawa$Lat, pch=2, col="red")
text(kotajawa$Long,kotajawa$Lat,kotajawa$Kota,pos = 3)

#Pulau Jawa
par(mfrow=c(2,2))
kNNdistplot(gempa_java[,c(3,5)],k=25)
abline(h=0.8)

db <- dbscan(gempa_java[,c(5,3)],0.8,25)
hullplot(gempa_java[,c(5,3)], db$cluster)

library(rgdal)
states=readOGR(".",layer = "indonesia")
java <- states[states$FIRST_PRON %in% c("31","32","33","34","35","36"),]
plot(java)
points(gempa_java$Lon,gempa_java$Lat, pch=db$cluster, col=db$cluster+2)
points(kotajawa$Long,kotajawa$Lat, pch=2, col="brown")
text(kotajawa$Long,kotajawa$Lat,kotajawa$Kota,pos = 3)
