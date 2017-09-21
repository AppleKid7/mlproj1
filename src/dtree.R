library("C50")
library("rattle")
library("rpart.plot")
library("RColorBrewer")
library("caret")

# rattle()

runtree_nopruning <- function(dataset) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  # View(data)
  dataframe  <- as.data.frame(datacsv)
  tree = classification_tree(dataframe)
  # plot(tree)
  # text(tree, pretty=0)
  fancyRpartPlot(tree)
}

vehicle_error <- function(dataset) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  dataframe <- as.data.frame(datacsv)
  # dataframe$X <- NULL
  # dataframe.y = dataframe$CLASSES
  # dataframe.y <- factor(dataframe.y, labels = c('van', 'saab', 'bus', 'opel'))
  tree_data <- learing_curve_dat(dataframe, outcome = 'CLASSES',  proportion = (1:10)/10, test_prop = (1:10)/10,
                                 method='C5.0',
                                 metric='Accuracy',
                                 verbose = TRUE,
                                 #trControl = trainControl(classProbs = TRUE,
                                 #                        summaryFunction=defaultSummary)
                                 trControl = C5.0Control(classProbs=TRUE, summaryFunction=defaultSummary,
                                                         noGlobalPruning = 1.0)
                                 )
  ggplot(tree_data, aes(x = Training_Size, y = Accuracy, color = Data)) + 
  geom_smooth(method = loess, span = .8) + 
  theme_bw()

}

runtree_pruning <- function(dataset) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  dataframe  <- data.frame(datacsv)
  dataframe$X <- NULL
  #dataframe$CLASSES <- factor(dataframe$CLASSES, levels = c('1', '2', '3', '4'),
  #                            labels = c('saab', 'bus', 'opel', 'van'))
  set.seed(7)
  rows = nrow(dataframe)
  trainrows = as.integer(rows * 0.80)
  train_sample <- sample(1:rows, trainrows)
  
  train <- dataframe[train_sample, ]
  test <- dataframe[-train_sample, ]
  # ptree <- C5.0(CLASSES ~ ., data = dataframe)
  # target_index <- grep('CLASSES', colnames(train))
  x <- train[c(!(colnames(train) == "CLASSES"))]
  y <- train$CLASSES
  fitControl <- trainControl(method = "repeatedcv",
                             number = 10,
                             repeats = 10, returnResamp="all")
  
  grid <- expand.grid( .winnow = c(TRUE,FALSE), .trials=c(1,5,10,15,20), .model="tree" )
  mdl <- train(x=x,y=y,tuneGrid=grid,trControl=fitControl,method="C5.0",verbose=FALSE)
  # ptree <- C5.0(x = train[, -target_index], y = train[['CLASSES']])
  # ptree$call$x <- train[, -target_index]
  # ptree$call$y <- train[['CLASSES']]
  #ptree<- prune(tree,
  #             cp= tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"])
  # fancyRpartPlot(ptree, uniform=TRUE,
  #               main="Pruned Classification Tree")
  plot(mdl)
}

classification_tree <- function(dataframe) {
  tree <- C5.0(CLASSES ~ . ,
               data=dataframe,
               method="class")
  return(tree)
}