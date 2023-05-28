#simulation
x<-c(2,1,5,6,6,8,10,11,12,14,15,16,17)
y<-2.4+0.65*x+rnorm(1,0,2)
c1 <- as.data.frame(cbind(x,y))
plot(x,y)

library(MASS)
Sigma <- matrix(c(3,-1,-1,2),2,2)
mvnorm<-mvrnorm(n = 20, c(7,17), Sigma, tol = 1e-6, 
                empirical = FALSE, EISPACK = FALSE)
mvnorm<-as.data.frame(mvnorm)
colnames(mvnorm)<-c("x","y")
datgab <- rbind(c1,mvnorm)
plot(datgab)

#dbscan
kNNdistplot(datgab, k=4)
db_sim<-dbscan(datgab, 3, 4)

#Kmeans
km_sim <- kmeans(datgab,2)

#Hullplot
par(mfrow=c(1,2))
hullplot(datgab,db_sim$cluster,main = "DBSCAN")
hullplot(datgab,km_sim$cluster,main = "KMEANS")
