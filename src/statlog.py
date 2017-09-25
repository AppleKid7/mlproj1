import pandas as pd
import numpy as np
import math
import glob
import os


class VehicleSilhouteData(object):
    def __init__(self):
        def get_merged_csv(flist, **kwargs):
            return pd.concat([pd.read_csv(f, **kwargs) for f in flist], ignore_index=True)

        path = 'data/vehicles'
        fmask = os.path.join(path, '*.dat')
        column_names = ['COMPACTNESS', 'CIRCULARITY',
                        'DISTANCE_CIRCULARITY', 'RADIUS_RATIO',
                        'PR.AXIS_ASPECT_RATIO', 'MAX.LENGTH_ASPECT_RATIO',
                        'SCATTER_RATIO', 'ELONGATEDNESS',
                        'PR.AXIS_RECTANGULARITY', 'MAX.LENGTH_RECTANGULARITY',
                        'SCALED_VARIANCE_ALONG_MAJOR_AXIS',
                        'SCALED_VARIANCE_ALONG_MINOR_AXIS',
                        'SCALED_RADIUS_OF_GYRATION',
                        'SKEWNESS_ABOUT_MAJOR_AXIS',
                        'SKEWNESS_ABOUT_MINOR_AXIS',
                        'KURTOSIS_ABOUT_MINOR_AXIS',
                        'KURTOSIS_ABOUT_MAJOR_AXIS',
                        'HOLLOWS_RATIO', 'CLASSES']

        df = get_merged_csv(glob.glob(fmask), index_col=False,
                            delimiter=' ', names=column_names)
        # df.CLASSES = pd.Categorical(df.CLASSES)
        # df['CATEGORY'] = df.CLASSES.cat.codes
        '''
        0 - bus
        1 - opel
        2 - saab
        3 - van
        '''
        # del df['CLASSES']
        df_norm = (df.iloc[:,:-1] - df.iloc[:,:-1].min()) / (df.iloc[:,:-1].max() - df.iloc[:,:-1].min())
        # df_norm = (df - df.min())/(df.max() - df.min())
        df_norm = df_norm.join(df.iloc[:,-1])
        self.data = df_norm.sample(frac=1).reset_index(drop=True)
        '''
        partitioning data into training and testing set of roughly
        60/40
        '''
        msk = np.random.rand(len(df)) < 0.6
        self.training_data = self.data[msk]
        self.testing_data = self.data[~msk]

    def get_training_data(self):
        return self.training_data

    def get_testing_data(self):
        return self.testing_data

    def clean_data(self):
        self.data.to_csv('data/vehicles/vehicles.csv', sep=',', encoding='utf-8')

