library("nnet")
library("caret")
library("gridExtra")

runneuralnet <- function(dataset) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  
  dataframe  <- as.data.frame(datacsv)
  dataframe$X <- NULL
  set.seed(7)
  rows = nrow(dataframe)
  trainrows = as.integer(rows * 0.80)
  train_sample <- sample(1:rows, trainrows)
  
  train <- dataframe[train_sample, ]
  # ytrain <- class.ind(train$CLASSES)
  test <- dataframe[-train_sample, ]
  
  # target_index <- grep('CLASSES', colnames(train))
  # model <- nnet(x = train[, -target_index], y = ytrain, method='class',
  #               size=10, softmax=TRUE)
  model <- nnet(CLASSES ~ ., data=train, size=10, method='class')
  test.nnet<-predict(model,test,type=("class"))

  table(test$CLASSES,test.nnet)
}

savePlot <- function(myPlot, title, devoff=TRUE) {
  filename = paste("./img", title, sep="/")
  png(filename)
  print(myPlot)
  if(devoff)
    dev.off()
}

nn_error <- function(dataset, imgname) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  dataframe <- as.data.frame(datacsv)

  tree_data <- learing_curve_dat(dataframe, outcome = 'CLASSES',  proportion = (1:10)/10, test_prop = (1:10)/10,
                                 method='nnet',
                                 metric='Accuracy',
                                 verbose = TRUE,
                                 trControl = trainControl(classProbs = TRUE,
                                                          summaryFunction=defaultSummary)
  )
  myplot <- ggplot(tree_data, aes(x = Training_Size, y = Accuracy, color = Data)) + 
    geom_smooth(method = loess, span = .8) + 
    theme_bw()
  savePlot(myplot, imgname)
}