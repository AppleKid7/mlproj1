source('dtree.R')

# DECISION TREE

runtree("vehicles/vehicles.csv", 'vehicles_tree_table.png')
tree_error("vehicles/vehicles.csv", 'vehicles_tree_error.png')

runtree("wine/red_wine.csv", 'wine_tree_table.png')
tree_error("wine/red_wine.csv",'wine_tree_error.png')

# BOOSTed DECISION TREE

runtree("vehicles/vehicles.csv", TRUE)
tree_error("vehicles/vehicles.csv", 'vehicles_boost_error.png', TRUE)

runtree("wine/red_wine.csv", TRUE)
tree_error("wine/red_wine.csv", 'wine_boost_error.png', TRUE)

# NEURAL NETWORK

source('nn.R')

runneuralnet('vehicles/vehicles.csv')
nn_error('vehicles/vehicles.csv', 'vehicles_nnet_error.png')

runneuralnet('wine/red_wine.csv')
nn_error('wine/red_wine.csv', 'wine_nnet_error.png')

# SUPPORT VECTOR MACHINE

source('svm.R')

runsvm('vehicles/vehicles.csv')
svm_error('vehicles/vehicles.csv', 'vehicles_svm_error.png')

# K-NEAREST NEIGHBORS

source('knn.R')

runknn('vehicles/vehicles.csv')
knn_error('vehicles/vehicles.csv', 'vehicles_knn_error.png')