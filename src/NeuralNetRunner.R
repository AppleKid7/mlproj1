source('nn.R')

runneuralnet('vehicles/vehicles.csv')
nn_error('vehicles/vehicles.csv', 'vehicles_nnet_error.png')

runneuralnet('wine/red_wine.csv')
nn_error('wine/red_wine.csv', 'wine_nnet_error.png')