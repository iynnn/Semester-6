#DECISION TREE
library(rpart)			# Popular decision tree algorithm
library(rattle)			# Fancy tree plot
library(rpart.plot)			# Enhanced tree plots
library(RColorBrewer)			# Color selection for fancy tree plot
library(party)			# Alternative decision tree algorithm
library(partykit)			# Convert rpart object to BinaryTree
data(iris)				# Get some data
data <- iris

# Make big tree
form <- as.formula(Species ~ .)
tree.1 <- rpart(form,data=data,control=rpart.control(minsplit=20,cp=0))

plot(tree.1)			# Will make a mess of the plot
text(tree.1)

prp(tree.1,					# Will plot the tree
    fallen.leaves=TRUE,  # put the leaves on the bottom of the page
    shadow.col="gray",   # shadows under the leaves
    branch.lty=3,        # draw branches using dotted lines
    branch=.5,           # change angle of branch lines
    faclen=0,            # faclen=0 to print full factor names
    trace=1,             # print the automatically calculated cex
    split.cex=1.2,       # make the split text larger than the node text
    split.prefix="is ",  # put "is " before split text
    split.suffix="?",    # put "?" after split text
    col='green', border.col='green',   # green if survived
    split.box.col="lightgray",   # lightgray split boxes (default is white)
    split.border.col="darkgray", # darkgray border on split boxes
    split.round=.5)              # round the split box corners a tad

# Interactively prune the tree
new.tree.1 <- prp(tree.1,snip=TRUE)$obj 	# interactively trim the tree
prp(new.tree.1)

tree.2 <- rpart(form,data)		# A more reasonable tree
prp(tree.2)                                 	# A fast plot													
fancyRpartPlot(tree.2)		# A fancy plot from rattle

#NAIVE BAYES
library(naivebayes)
comp <- read.csv("computer.csv",header = TRUE)
nb_comp<-naive_bayes(buys_computer~age+income+student+credit_rating, 
                     data = comp)

#predict new object
comp.test <- data.frame(t(c("<=30","medium","yes","Fair")))
predict(nb_comp,comp.test)






library(e1071)
# input data training
data.training = as.data.frame(rbind(
  c("Sunny", "Hot", "High", "False", "No"), 
  c("Sunny", "Hot", "High", "True", "No"), 
  c("Overcast", "Hot", "High", "False", "Yes"), 
  c("Rainy", "Mild", "High", "False", "Yes"), 
  c("Rainy", "Cool", "Normal", "False", "Yes"), 
  c("Rainy", "Cool", "Normal", "True", "No"), 
  c("Overcast", "Cool", "Normal", "True", "Yes"), 
  c("Sunny", "Mild", "High", "False", "No"), 
  c("Sunny", "Cool", "Normal", "False", "Yes"), 
  c("Rainy", "Mild", "Normal", "False", "Yes"), 
  c("Sunny", "Mild", "Normal", "True", "Yes"), 
  c("Overcast", "Mild", "High", "True", "Yes"), 
  c("Overcast", "Hot", "Normal", "False", "Yes"), 
  c("Rainy", "Mild", "High", "True", "No")))
# memberi nama kolom
names(data.training)[1] = "OUTLOOK"
names(data.training)[2] = "TEMP"
names(data.training)[3] = "HUMIDIT"
names(data.training)[4] = "WINDY"
names(data.training)[5] = "PLAY"
# input data testing
data.test = as.data.frame(cbind("Sunny", "Cool", "High", "True"))
names(data.test)[1] = "OUTLOOK"
names(data.test)[2] = "TEMP"
names(data.test)[3] = "HUMIDITY"
names(data.test)[4] = "WINDY"
# membuat model
model <- naiveBayes(PLAY ~ ., data = data.training)
print(model)