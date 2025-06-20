import numpy as np
from sklearn.metrics import confusion_matrix
from sklearn.metrics import ConfusionMatrixDisplay
import matplotlib.pyplot as plt

from utils import train_model, make_predictions, load_data
from env import *


Xtrain, Xtest, Ytrain, Ytest = load_data()

# normalizando os dados
train_set_x = Xtrain.reshape(Xtrain.shape[0], -1).T/255.
test_set_x = Xtest.reshape(Xtest.shape[0], -1).T/255.

# Treinando o modelo
print('Treinando o modelo usando a configuração:')
print('\tTaxa de Aprendizado:', LEARNING_RATE)
print('\tNúmero de iterações:', NUM_ITERATIONS)

w, b, costs = train_model(train_set_x, Ytrain, NUM_ITERATIONS, LEARNING_RATE)
print('Model trained!\n')

print('Fazendo predições...\n')
predictions = make_predictions(w, b, test_set_x, PREDICTION_THRESHOLD)
print('Predições feitas.\n')

print("============================")
accuracy = float_formatter(100 - np.mean(np.abs(predictions - Ytest)) * 100)
print("Acurácia: {}%".format(accuracy))
print("============================")

plt.figure()
plt.plot(costs)
plt.ylabel('custo')
plt.xlabel('iterações')
plt.title("Taxa de aprendizado = " + str(LEARNING_RATE))

test_confusion_matrix = confusion_matrix(Ytest[0], predictions[0])

ConfusionMatrixDisplay(test_confusion_matrix).plot()
plt.show()