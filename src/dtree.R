library("rpart")
library("rattle")
library("rpart.plot")
library("RColorBrewer")

rattle()

runtree <- function(dataset, methodparam) {
  filename = paste("./data", dataset, sep="/")
  datacsv <- read.csv(filename)
  # View(data)
  dataframe<-as.data.frame(datacsv)
  tree <- rpart(CATEGORY ~ dataframe$COMPACTNESS + dataframe$CIRCULARITY + dataframe$DISTANCE_CIRCULARITY
                + dataframe$RADIUS_RATIO + dataframe$PR.AXIS_ASPECT_RATIO + dataframe$MAX.LENGTH_ASPECT_RATIO
                + dataframe$SCATTER_RATIO + dataframe$ELONGATEDNESS + dataframe$PR.AXIS_RECTANGULARITY
                + dataframe$MAX.LENGTH_RECTANGULARITY + dataframe$SCALED_VARIANCE_ALONG_MAJOR_AXIS
                + dataframe$SCALED_VARIANCE_ALONG_MINOR_AXIS + dataframe$SCALED_RADIUS_OF_GYRATION
                + dataframe$SKEWNESS_ABOUT_MAJOR_AXIS + dataframe$SKEWNESS_ABOUT_MINOR_AXIS
                + dataframe$KURTOSIS_ABOUT_MAJOR_AXIS + dataframe$HOLLOWS_RATIO,
                data=dataframe,
                method=methodparam)
  # plot(tree)
  # text(tree, pretty=0)
  fancyRpartPlot(tree)
}