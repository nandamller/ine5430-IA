import numpy as np
import h5py as h5


def load_data():
    # loads given datasets
    trainining_ds = h5.File('../datasets/train_catvnoncat.h5', "r")
    testing_ds = h5.File('../datasets/test_catvnoncat.h5', "r")

    Xtrain = np.array(trainining_ds["train_set_x"][:])  # train set features
    Ytrain = np.array(trainining_ds["train_set_y"][:])  # train set labels

    Xtest = np.array(testing_ds["test_set_x"][:])  # test set features
    Ytest = np.array(testing_ds["test_set_y"][:])  # test set labels

    Ytrain = Ytrain.reshape((1, Ytrain.shape[0]))
    Ytest = Ytest.reshape((1, Ytest.shape[0]))

    return Xtrain, Xtest, Ytrain, Ytest

def transpose(m):
    return m.T

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def calc_cost(m, Y, sig):
  cost = -(1/m) * np.sum(np.multiply(Y, np.log(sig)) + np.multiply(1 - Y, np.log(1-sig)))
  return cost

def back_propagation(X, Y, sig):
    m = X.shape[1]

    # Cost
    cost = calc_cost(m, Y, sig)

    # Backward propagation
    dw = (1/m) * np.dot(X, transpose((sig - Y)))
    db = (1/m) * np.sum(sig - Y)

    return dw, db, cost


def calc_gd(w, b, X, Y, num_iterations, learning_rate):
    costs = []

    for _ in range(num_iterations):
        # Cost and gradient calculation
        sig = sigmoid(np.dot(transpose(w), X) + b)
        dw, db, cost = back_propagation(X, Y, sig)

        # updating sigmoid parameters
        w = w - (learning_rate * dw)
        b = b - (learning_rate * db)
        
        costs.append(cost)

    return w, b, costs


def make_predictions(w, b, X, threshold):
    m = X.shape[1]
    Y_prediction = np.zeros((1, m))
    w = w.reshape(X.shape[0], 1)

    # prediction of the probabilities of being a cat
    sig = sigmoid(np.dot(transpose(w), X) + b)

    for i in range(sig.shape[1]):
        # Convert probabilities A[0,i] to actual predictions p[0,i]
        Y_prediction[0, i] = 1 if sig[0, i] > threshold else 0

    return Y_prediction


def train_model(Xtrain, Ytrain, num_iterations, learning_rate):
    w = np.zeros((Xtrain.shape[0], 1))
    b = 0

    # calculate Gradient descent
    print('\tCalculating Gradient Descent...\n')
    w, b, costs = calc_gd(
        w, b, Xtrain, Ytrain, num_iterations, learning_rate)
    print('\tGradient Descent calculated!\n')

    return w, b, costs

