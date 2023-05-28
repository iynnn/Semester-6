#Multiclass classification using NN
library(neuralnet)
library(nnet)
library(caret)


# Load data and set variables names
setwd("C:/Users/yanto/OneDrive - UGM 365/semester 6/semester-6-/DatMin/[DM06] Pertemuan 6")
wines <- read.csv("wine.csv")
names(wines) <- c("label",
                  "Alcohol",
                  "Malic_acid",
                  "Ash",
                  "Alcalinity_of_ash",
                  "Magnesium",
                  "Total_phenols",
                  "Flavanoids",
                  "Nonflavanoid_phenols",
                  "Proanthocyanins",
                  "Color_intensity",
                  "Hue",
                  "OD280_OD315_of_diluted_wines",
                  "Proline")
head(wines)
str(wines)

# Encode as a one hot vector multilabel data
train <- cbind(wines[, 2:14], class.ind(as.factor(wines$label)))
# Set labels name
names(train) <- c(names(wines)[2:14],"l1","l2","l3")

# Scale data
scl <- function(x){ (x - min(x))/(max(x) - min(x)) }
train[, 1:13] <- data.frame(lapply(train[, 1:13], scl))

n <- names(train)
f <- as.formula(paste("l1 + l2 + l3 ~", paste(n[!n %in% c("l1","l2","l3")], collapse = " + ")))

nn <- neuralnet(f,
                data = train,
                hidden = c(13, 10, 3),
                act.fct = "logistic",
                linear.output = FALSE,
                lifesign = "minimal")
plot(nn)

# Compute predictions
pr.nn <- compute(nn, train[, 1:13])

#accuracy
# Accuracy (training set)
pr.nn_1 <- pr.nn$net.result
original_values <- max.col(train[, 14:16])
pr.nn_2 <- max.col(pr.nn_1)
table(original_values,pr.nn_2)

#Using mxnet
library(mxnet)
wines$label <- as.factor(wines$label)
str(wines)

idx <- createDataPartition(wines$label, p = 0.8, list=FALSE)
dtrain <- wines[idx,]
dtes <- wines[-idx,]

ctrl <- trainControl(method="repeatedcv",   # 10fold cross validation
                     repeats=5,         # do 5 repetitions of cv
                     summaryFunction=twoClassSummary,   # Use AUC to pick the best model
                     classProbs=TRUE)

nn.tune <- train(label~., data = dtrain,
                  method = "mxnet",   # Radial kernel
                  tuneLength = 5,         # 5 values of the cost function
                  preProc = c("center","scale"),  # Center and scale data
                  metric="ROC",
                  trControl=ctrl)
