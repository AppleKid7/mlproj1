library("C50")
library("caret")

runtree <- function(dataset, boosted=FALSE) {
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
  "if(trial == 0)
    ptree <- C5.0(x = train[, -target_index], y = train[['CLASSES']], method='class')
  else
    ptree <- C5.0(x = train[, -target_index], y = train[['CLASSES']], method='class',
                  trial=trial)"
  if(boosted==TRUE)
    grid <- expand.grid(winnow = c(TRUE,FALSE), trials=c(1,5,10,15,20), model='tree')
  else
    grid <- expand.grid(winnow = c(TRUE,FALSE), trials=c(1), model='tree')
  control <- trainControl(method="repeatedcv", number=10, repeats=3)
  model <- train(x = train[, -target_index],
                 y = train$CLASSES,
                 data=train,
                 tuneGrid=grid,
                 trControl=control,
                 method="C5.0",
                 verbose=FALSE)
  ptree <- model
  ptree$call$x <- train[, -target_index]
  ptree$call$y <- train[['CLASSES']]
  plot(ptree, subtree=3)
  test.ptree<-predict(ptree,test)
  
  table(test$CLASSES,test.ptree)
}

savePlot <- function(myPlot, title, devoff=TRUE) {
  filename = paste("./img", title, sep="/")
  png(filename)
  print(myPlot)
  if(devoff)
    dev.off()
}

tree_error <- function(dataset, imgname, trial=0) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  dataframe <- as.data.frame(datacsv)
  if(trial == 0)
    tree_data <- learing_curve_dat(dataframe, outcome = 'CLASSES',  proportion = (1:10)/10, test_prop = (1:10)/10,
                                  method='C5.0',
                                  metric='Accuracy',
                                  verbose = TRUE,
                                  trControl = trainControl(classProbs = TRUE,
                                                           summaryFunction=defaultSummary)
                                 )
  else
    tree_data <- learing_curve_dat(dataframe, outcome = 'CLASSES',  proportion = (1:10)/10, test_prop = (1:10)/10,
                                   method='C5.0',
                                   metric='Accuracy',
                                   verbose = TRUE,
                                   trControl = trainControl(classProbs = TRUE, number=trial,
                                                            summaryFunction=defaultSummary)
                                   )
  myplot <- ggplot(tree_data, aes(x = Training_Size, y = Accuracy, color = Data)) + 
    geom_smooth(method = loess, span = .8) + 
    theme_bw()
  savePlot(myplot, imgname)
}