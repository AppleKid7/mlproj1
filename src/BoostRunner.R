source('dtree.R')

runtree("vehicles/vehicles.csv", trial=10)

tree_error("vehicles/vehicles.csv", 'vehicles_boost_error.png', trial=10)

runtree("wine/red_wine.csv", trial=10)

tree_error("wine/red_wine.csv", 'wine_boost_error.png', trial=10)