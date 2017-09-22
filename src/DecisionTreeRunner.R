source('dtree.R')

runtree("vehicles/vehicles.csv", 'vehicles_tree_table.png')

tree_error("vehicles/vehicles.csv", 'vehicles_tree_error.png')

runtree("wine/red_wine.csv", 'wine_tree_table.png')

tree_error("wine/red_wine.csv",'wine_tree_error.png')