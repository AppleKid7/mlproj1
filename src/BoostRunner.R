source('dtree.R')

runtree("vehicles/vehicles.csv", TRUE)

tree_error("vehicles/vehicles.csv", 'vehicles_boost_error.png', TRUE)

runtree("wine/red_wine.csv", TRUE)

tree_error("wine/red_wine.csv", 'wine_boost_error.png', TRUE)