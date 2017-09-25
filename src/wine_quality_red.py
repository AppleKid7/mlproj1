import pandas as pd
import numpy as np
import math


class RedWineData(object):
    def __init__(self):
        df = pd.read_csv('data/wine/winequality-red.csv', delimiter=';')
        df_norm = (df - df.min()) / (df.max() - df.min())
        data = df_norm.sample(frac=1).reset_index(drop=True)
        # if quality >= 0.5, this is considered good
        # if < 0.5, it is poor 
        def map_to_class(row):
            return 'GOOD' if row.quality >= 0.5 else 'POOR'
        data['CLASSES'] = data.apply (lambda row: map_to_class(row),axis=1)
        del data['quality']
        self.data = data
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

    def clean_data(self):
        self.data.to_csv('data/wine/red_wine.csv', sep=',', encoding='utf-8')

