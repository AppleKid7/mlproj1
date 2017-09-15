library("rpart")

runtree <- function(dataset, method) {
  filename = paste("./data", dataset, sep="/")
  data <- read.csv(filename)
  View(data)
}