from statlog import VehicleSilhouteData
from wine_quality_red import RedWineData


def main():
    wine_data_getter = RedWineData()
    # exports the normalized red wine data to a csv
    # called red_wine.csv 
    wine_data_getter.clean_data()


    data_getter = VehicleSilhouteData()
    # exports the normalized vehicles data to a csv
    # to a csv called vehicles.csv
    data_getter.clean_data()


if __name__ == '__main__': main()

