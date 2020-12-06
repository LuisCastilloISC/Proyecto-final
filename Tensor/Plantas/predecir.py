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
    if respuesta == 0:
        print('Diente de Leon')
    elif respuesta == 1:
        print('Girasol')
    elif respuesta == 2:
        print('Margarita')
    elif respuesta == 3:
        print('Rosa')
    elif respuesta == 4:
        print('Tulipan')
        
        
print('Set de pruebas #1')
predict('./prueba/diente_de_leon.jpg')
predict('./prueba/girasol.jpg')
predict('./prueba/margarita.jpg')
predict('./prueba/rosa.jpg')
predict('./prueba/tulipan.jpg')

