library(e1071)

iris <- iris
attach(iris)

x <- subset(iris, select=-Species)
y <- Species

svm_model <- svm(Species ~ ., data=iris) #atau
svm_model <- svm(x,y)
summary(svm_model)

pred <- predict(svm_model,x)

table(pred,y)

svm_tune <- tune(svm, train.x=x, train.y=y, 
                 kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))

print(svm_tune)

svm_model_after_tune <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=0.5) 
# COST = toleransi kkita untuk membentuk support vector , 
# costnya semakinbesar akurasi akan semakin berkurang
# gamma adalah parameter dari kernel, gamma adalah parameter 
# setiap kernel punya parameter yang beda
summary(svm_model_after_tune)

pred <- predict(svm_model_after_tune,x)

table(pred,y)
