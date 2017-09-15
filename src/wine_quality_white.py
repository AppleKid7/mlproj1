import pandas as pd
import numpy as np
import math


class RedWineData(object):
    def __init__(self):
        df = pd.read_csv('data/wine/winequality-white.csv', delimiter=';')
        df_norm = (df - df.min()) / (df.max() - df.min())
        data = df_norm.sample(frac=1).reset_index(drop=True)
        # train_rows = math.floor(0.6* data.shape[0])                                 
        # test_rows = data.shape[0] - train_rows
        # trainX = data[:train_rows,0:-1]                                             
      	# trainY = data[:train_rows,-1]                                               
      	# testX = data[train_rows:,0:-1]                                              
      	# testY = data[train_rows:,-1]
        '''
           partitioning data into training and testing set of roughly
           60/40
        '''
        msk = np.random.rand(len(df)) < 0.6
        self.training_data = data[msk]
        self.testing_data = data[~msk]

    def get_training_data(self):
        return self.training_data

    def get_testing_data(self):
        return self.testing_data


def main():
    data_getter = RedWineData()


if __name__ == '__main__': main()
