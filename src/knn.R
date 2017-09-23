library("caret")
library("gridExtra")

runknn <- function(dataset) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  
  dataframe  <- as.data.frame(datacsv)
  dataframe$X <- NULL
  set.seed(7)
  rows = nrow(dataframe)
  trainrows = as.integer(rows * 0.80)
  train_sample <- sample(1:rows, trainrows)
  
  train <- dataframe[train_sample, ]
  test <- dataframe[-train_sample, ]
  
  target_index <- grep('CLASSES', colnames(train))
  grid <- expand.grid(.k=seq(from = 1, to = 20, by = 2))
  control <- trainControl(method="repeatedcv", number=10, repeats=3,
                          classProbs = TRUE)
  model <- train(CLASSES ~ .,
                 data=train,
                 tuneGrid=grid,
                 trControl=control,
                 method="knn")
  
  test.knn<-predict(model,test)
  
  table(test$CLASSES,test.knn)
}

savePlot <- function(myPlot, title, devoff=TRUE) {
  filename = paste("./img", title, sep="/")
  png(filename)
  print(myPlot)
  if(devoff)
    dev.off()
}

knn_error <- function(dataset, imgname) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  dataframe <- as.data.frame(datacsv)
  
  nn_data <- learing_curve_dat(dataframe, outcome = 'CLASSES',  proportion = (1:10)/10, test_prop = (1:10)/10,
                               method='knn',
                               metric='Accuracy',
                               verbose = TRUE,
                               trControl = trainControl(classProbs = TRUE,
                                                        summaryFunction=defaultSummary)
  )
  myplot <- ggplot(nn_data, aes(x = Training_Size, y = Accuracy, color = Data)) + 
    geom_smooth(method = loess, span = .8) + 
    theme_bw()
  savePlot(myplot, imgname)
}