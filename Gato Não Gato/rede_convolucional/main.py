from re import T
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import seaborn as sns

from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split

import tensorflow as tf 
from tensorflow import keras
from tensorflow.keras import layers
from keras.layers import Dense
from keras.models import Sequential
from tensorflow.keras.utils import to_categorical

from sklearn.metrics import ConfusionMatrixDisplay
from sklearn.metrics import accuracy_score

from env import *
from utils import load_data, exp_decay


Xtrain, Xtest, Ytrain, Ytest = load_data()

plt.figure(figsize=(15, 15))
for i in range(NUMBER_EXAMPLES_SHOWN_TRAINING_SET):
    ax = plt.subplot(4, 5, i + 1)
    plt.imshow(Xtrain[i+10])
    ax.get_xaxis().set_visible(False)
    ax.get_yaxis().set_visible(False)


num_classes = 2
ytrain = to_categorical(Ytrain, num_classes)
ytest = to_categorical(Ytest, num_classes)


model = tf.keras.Sequential()

model.add(layers.Conv2D(32, (3, 3), activation=RELU, input_shape=Xtrain.shape[1:]))
model.add(layers.MaxPooling2D((2, 2)))

model.add(layers.Conv2D(64, (3, 3), activation=RELU))
model.add(layers.MaxPooling2D((2, 2)))

model.add(layers.Flatten())

model.add(layers.Dense(HIDDEN_LAYER_NEURONS_NUMBER, activation=TANH))
model.add(layers.Dense(OUTPUT_LAYER_NEURONS_NUMBER, activation=SIGMOID))


opt = tf.keras.optimizers.SGD(learning_rate=LEARNING_RATE)
model.compile(optimizer=opt, loss="categorical_crossentropy",
              metrics=["accuracy"])


model.summary()

Xtr, Xval, ytr, yval = train_test_split(Xtrain, ytrain, test_size=TEST_SIZE)
num_train = np.size(Xtr, 0)


callbacks_list = []

if ADD_EARLY_STOP_CALLBACK:
  early_stopping = tf.keras.callbacks.EarlyStopping(monitor='val_loss',
                              mode="min",
                              patience=50,
                              verbose=0)

  callbacks_list.append(early_stopping)


if ADD_LEARNING_RATE_CALLBACK:
  lrate = tf.keras.callbacks.LearningRateScheduler(exp_decay)
  callbacks_list.append(lrate)


if ADD_EARLY_STOP_CALLBACK or ADD_LEARNING_RATE_CALLBACK:
  results = model.fit(Xtr, ytr, validation_data=(
    Xval, yval), batch_size=BATCH_SIZE, epochs=EPOCHS, callbacks=callbacks_list, verbose=SHOW_FITTING_OUTPUT)
else:
  results = model.fit(Xtr, ytr, validation_data=(
    Xval, yval), batch_size=BATCH_SIZE, epochs=EPOCHS, verbose=SHOW_FITTING_OUTPUT)


accuracy = results.history['accuracy']
accuracy_value = results.history['val_accuracy']
loss = results.history['loss']
loss_value = results.history['val_loss']
epochs = range(1, len(accuracy) + 1)

plt.figure()
plt.plot(epochs, accuracy, 'b', label='Training accuracy')
plt.plot(epochs, accuracy_value, 'r', label='Validation accuracy')
plt.title('Training and Validation accuracy')
plt.legend()

plt.figure()
plt.plot(epochs, loss, 'b', label='Training loss')
plt.plot(epochs, loss_value, 'r', label='Validation loss')
plt.title('Training and Validation loss')
plt.legend()


ytestpred = model.predict(Xtest)

ConfusionMatrixDisplay.from_predictions(ytest.argmax(axis=1), ytestpred.argmax(axis=1))

plt.show()