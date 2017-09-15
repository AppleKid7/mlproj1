import pandas as pd
import numpy as np
import math
import glob
import os


class VehicleSilhouteData(object):
    def __init__(self):
        '''path =r'data/vehicles' # use your path
        allFiles = glob.glob(path + "/*.dat")
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
        frame = pd.DataFrame()
        list_ = []
        for file_ in allFiles:
            fr = pd.read_csv(file_, index_col=False, names=column_names,
                             delimiter=' ')
            list_.append(fr)
        df = pd.concat(list_)

        df_norm = (df.iloc[:,:-1] - df.iloc[:,:-1].min()) / (df.iloc[:,:-1].max() - df.iloc[:,:-1].min())
        df_norm = df_norm.join(df.iloc[:,-1])
        data = df_norm.sample(frac=1).reset_index(drop=True)
        
        msk = np.random.rand(len(df)) < 0.6
        self.training_data = data[msk]
        self.testing_data = data[~msk]'''
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
        df.CLASSES = pd.Categorical(df.CLASSES)
        df['CATEGORY'] = df.CLASSES.cat.codes
        '''
        0 - bus
        1 - opel
        2 - saab
        3 - van
        '''
        del df['CLASSES']
        # df_norm = (df.iloc[:,:-1] - df.iloc[:,:-1].min()) / (df.iloc[:,:-1].max() - df.iloc[:,:-1].min())
        df_norm = (df - df.min())/(df.max() - df.min())
        # df_norm = df_norm.join(df.iloc[:,-1])
        data = df_norm.sample(frac=1).reset_index(drop=True)
        '''
        partitioning data into training and testing set of roughly
        60/40
        '''
        msk = np.random.rand(len(df)) < 0.6
        self.training_data = data[msk]
        self.testing_data = data[~msk]
        from ipdb import set_trace; set_trace()

    def get_training_data(self):
        return self.training_data

    def get_testing_data(self):
        return self.testing_data

def test():
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

    df = get_merged_csv(glob.glob(fmask), index_col=False, delimiter=' ',
                        names=column_names)
    df_norm = (df.iloc[:,:-1] - df.iloc[:,:-1].min()) / (df.iloc[:,:-1].max() - df.iloc[:,:-1].min())
    df_norm = df_norm.join(df.iloc[:,-1])
    data = df_norm.sample(frac=1).reset_index(drop=True)
    '''
    partitioning data into training and testing set of roughly
    60/40
    '''
    msk = np.random.rand(len(df)) < 0.6


def main():
    data_getter = VehicleSilhouteData()
    # data = test()


if __name__ == '__main__': main()
