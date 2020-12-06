import numpy as np
import tensorflow as tf
#from keras.preprocessing.image import load_img, img_to_array
#from keras.models import load_model

longitud, altura = 100,100
modelo = './modelo/modeloP.h5'
pesos = './modelo/pesosP.h5'
cnn = tf.keras.models.load_model(modelo)
cnn.load_weights(pesos)

def predict(file):
    x = tf.keras.preprocessing.image.load_img(file, target_size=(longitud, altura))
    x = tf.keras.preprocessing.image.img_to_array(x)
    x = np.expand_dims(x, axis = 0)
    arreglo = cnn.predict(x) ##[[1,0,0]]
    resultado = arreglo[0] ## [1,0,0]
    respuesta = np.argmax(resultado) #0
    if respuesta == 1:
        print('Diente de Leon')
    elif respuesta == 2:
        print('Girasol')
    elif respuesta == 3:
        print('Margarita')
    elif respuesta == 4:
        print('Rosa')
    elif respuesta == 5:
        print('Tulipan')


print('Set de pruebas #1')
predict('./pruebas/diente_de_leon.jpg') # 1.- Diente de Leon
predict('./pruebas/girasol.jpg')        # 2.- Girasol
predict('./pruebas/margarita.jpg')      # 3.- Margarita
predict('./pruebas/rosa.jpg')           # 4.- Rosa
predict('./pruebas/tulipan.jpg')        # 5.- Tulipan

print('')

print('Set de pruebas #2')
predict('./pruebas2/diente_de_leon.jpg') # 1.- Diente de Leon
predict('./pruebas2/girasol.jpg')        # 2.- Girasol
predict('./pruebas2/margarita.jpg')      # 3.- Margarita
predict('./pruebas2/rosa.jpg')           # 4.- Rosa
predict('./pruebas2/tulipan.jpg')        # 5.- Tulipan

print('')

print('Set de pruebas #3')
predict('./pruebas3/diente_de_leon.jpg') # 1.- Diente de Leon
predict('./pruebas3/girasol.jpg')        # 2.- Girasol
predict('./pruebas3/margarita.jpg')      # 3.- Margarita
predict('./pruebas3/rosa.jpg')           # 4.- Rosa
predict('./pruebas3/tulipan.jpg')        # 5.- Tulipan
