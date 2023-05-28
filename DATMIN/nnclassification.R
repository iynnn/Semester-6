library(nnet)
library(caret)
data("iris")				# Get some data
data <- iris
#Now we shall partition the data into train and test data
inTrain <- createDataPartition(y=iris$Species, p=0.75, 
                               list=FALSE)   
# We wish 75% for the trainset 
train.set <- iris[inTrain,]
test.set  <- iris[-inTrain,]
#Check test train ratio
nrow(train.set)/nrow(test.set) # should be around 3

model <- train(Species ~ ., train.set, method='nnet', 
               trace = FALSE,
               preProc = c("center", "scale")) # train
prediction <- predict(model, test.set[-5])           # predict
table(prediction, test.set$Species) 

