import numpy as np
import h5py as h5


def load_data():
    ## import datasets
    trainining_ds = h5.File('../datasets/train_catvnoncat.h5', "r")
    testing_ds = h5.File('../datasets/test_catvnoncat.h5', "r")

    # creating data for training and testing
    Xtrain = np.array(trainining_ds["train_set_x"][:])
    Ytrain = np.array(trainining_ds["train_set_y"][:])

    Xtest = np.array(testing_ds["test_set_x"][:])
    Ytest = np.array(testing_ds["test_set_y"][:])

    # Normalizing values
    Xtrain = Xtrain/255.0
    Xtest = Xtest/255.0

    return Xtrain, Xtest, Ytrain, Ytest

def exp_decay(epoch):
   initial_lrate = 1.0
   k = 0.05
   lrate = initial_lrate * np.exp(-k*epoch)
   return lrate
