import cifar10
from sklearn.preprocessing import OneHotEncoder
import matplotlib.pyplot as plt
import numpy as np
from sklearn.model_selection import cross_val_score
import argparse
from keras.callbacks import EarlyStopping
from keras import backend as K
import random
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, f1_score
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
from sklearn.decomposition import KernelPCA as KPCA
from sklearn import svm
from keras.layers  import Dense, Dropout
from sklearn.decomposition import PCA
from keras.models import Sequential
from sklearn.linear_model import LogisticRegression

parser = argparse.ArgumentParser()
parser.add_argument("--kernel_pca", help="kernel for pca ( “linear” | “poly” | “rbf” | “sigmoid” | “cosine”)", type=float)
parser.add_argument('--activation', help='the activation function for the hidden layers')
parser.add_argument("training_model", help="choose from LR, LSVM, KSVM, MLP")
parser.add_argument("--kernel_svm", help="kernel for svm", type=float)
parser.add_argument('--layer', action='append', help='layers for mlp',)
parser.add_argument("dimensionality_reduction_method", help="choose from PCA, LDA or KPCA")
parser.add_argument("--C", help="inverse regularization constant", type=float)
parser.add_argument("--gamma", help="kernel coefficient for rbf", type=float)
parser.add_argument("n_components", help="choose the reduced components", type=int)

args = parser.parse_args()

# Loading the dataset
cifar10.data_path = "data/CIFAR-10/"
class_names = cifar10.load_class_names()
print(class_names)

images_train, cls_train, labels_train = cifar10.load_training_data()
images_test, cls_test, labels_test = cifar10.load_test_data()

x = [None]*5
y = [None]*5

x[0] = images_train.reshape(images_train.shape[0],-1)
x[1] = images_test.reshape(images_test.shape[0], -1)
x[2] = x[0][:5000,:]
x[3] = x[0][5000:6250,:]
x[4] = x[1][:1250,:]

y[0] = cls_train
y[1] = cls_test
y[2] = y[0][:5000]
y[3] = y[0][5000:6250]
y[4] = y[1][:1250]

# dimensionality reduction

x_red = [None]*3
y_red = [None]*3

k = (args.n_components)
if args.dimensionality_reduction_method == "PCA":
    pca = PCA(n_components=k, whiten=True)
    x_red[0] = pca.fit_transform(x[2])
    x_red[1] = pca.transform(x[3])
    x_red[2] = pca.transform(x[4])
    print("Dimenionality Reduction methd used: ",pca)

if args.dimensionality_reduction_method == "LDA":
    lda = LDA(n_components=k)
    x_red[0] = lda.fit_transform(x[2], y[2])
    x_red[1] = lda.transform(x[3])
    x_red[2] = lda.transform(x[4])
    print("Dimenionality Reduction methd used: ",lda)

if args.dimensionality_reduction_method == "KPCA":
    kpca = KPCA(n_components=k, kernel=args.kernel_pca)
    x_red[0] = kpca.fit_transform(x[2])
    x_red[1] = kpca.transform(x[3])
    x_red[2] = kpca.transform(x[4])
    print("Dimenionality Reduction methd used: ",kpca)


# training the model
if args.C == None:
    C = [0.5, 5, 10, 20]
else:
    C = [args.C]

if args.gamma == None:
    gam = [0.01 ,0.05, 0.1, 0.5, 1]
else:
    gam = [args.gamma]

if args.training_model == "LR":
    max_training_score = 0
    best_model = None
    for c in C:
        lr = LogisticRegression(C=c, solver='lbfgs', multi_class='auto')
        lr.fit(x_red[0], y[2])
        y_red[0] = lr.predict(x_red[1])
        model_score = accuracy_score(y[3], y_red[0])
        print("training score for C = " + str(c) + " is " + str (model_score))
        if model_score > max_training_score:
            best_model = lr
            max_training_score = model_score
        
    print("Model used: ",best_model)
    y_red[1] = best_model.predict(x_red[2])
    model_test_score = accuracy_score(y[4], y_red[1])
    f1_score = f1_score(y[4], y_red[1], average='weighted')

if args.training_model == "LSVM":
    max_training_score = 0
    best_model = None
    for c in C:  
        svc = svm.SVC(C=c, kernel='linear')
        svc.fit(x_red[0], y[2])
        y_red[0] = svc.predict(x_red[1])
        model_score = accuracy_score(y[3], y_red[0])
        print("training score for C = " + str(c) + " is " + str (model_score))
        if model_score > max_training_score:
            best_model = svc
            max_training_score = model_score

    print("Model used: ",best_model)
    y_red[1] = best_model.predict(x_red[2])
    model_test_score = accuracy_score(y[4], y_red[1])
    f1_score = f1_score(y[4], y_red[1], average='weighted')

if args.training_model == "KSVM":
    max_training_score = 0
    best_model = None
    for c in C:  
        for g in gam:
            ksvc = svm.SVC(kernel=args.kernel_svm, random_state=0, gamma=g, C=c)
            ksvc.fit(x_red[0], y[2])
            y_red[0] = ksvc.predict(x_red[1])
            model_score = accuracy_score(y[3], y_red[0])
            print("training score for gamma = " + str(g) + " and C = " + str(c) + " is "+str (model_score))
            if model_score > max_training_score:
               	best_model = ksvc
                max_training_score = model_score

    print("Model used: ",best_model)
    y_red[1] = best_model.predict(x_red[2])
    model_test_score = accuracy_score(y[4], y_red[1])
    f1_score = f1_score(y[4], y_red[1], average='weighted')


if args.layer == None:
    layer_combs = [[128, 64, 32], [64, 64, 64], [32, 64, 128]]
else:
    layer_combs = [args.layer]

if args.activation == None:
    acts = ['relu', 'sigmoid', 'tanh']
else:
    acts = [args.activation]

if args.training_model == "MLP":
    max_training_score = 0
    best_model = None
    enc = OneHotEncoder(categories='auto')
    y_train_encoded = enc.fit_transform(y[2].reshape(-1, 1))
    y_crossval_encoded = enc.transform(y[3].reshape(-1, 1))
    y_test_encoded = enc.transform(y[4].reshape(-1, 1))
    print(x_red[0].shape)
    for layers in layer_combs:
        for act in acts:
            mlp = Sequential()
            for i in range(0, len(layers)):
                if i == 0:
                    mlp.add(Dense(int(layers[i]), activation=act, input_dim = x_red[0].shape[1]))
                else:
                    mlp.add(Dense(int(layers[i]), activation=act))

                mlp.add(Dropout(0.2))

            mlp.add(Dense(10, activation='softmax'))
            mlp.compile(loss='categorical_crossentropy', optimizer='adadelta', metrics=['accuracy'])
            mlp.fit(x_red[0], y_train_encoded, callbacks = [EarlyStopping(monitor='loss', min_delta=0, patience=0, verbose=0, mode='auto', baseline=None, restore_best_weights=False)], epochs=50)
            score = mlp.evaluate(x_red[1], y_crossval_encoded)
            model_score = score[1]
            print("for " + str(layers) + " the score is " + str(model_score))
            if model_score > max_training_score:
               	best_model = [layers, act]
                max_training_score = model_score

    print("Model used: ",best_model)
    y_red[1] = mlp.predict_classes(x_red[2])
    model_test_score = mlp.evaluate(x_red[2], y_test_encoded)
    f1_score = f1_score(y[4], y_red[1], average='weighted')
    K.clear_session()

print("Training accuracy: ",max_training_score)
print("Testing accuracy: ",model_test_score[1])
print("f1 score: ",f1_score)