import numpy as np
import tensorflow as tf
#from keras.preprocessing.image import load_img, img_to_array
#from keras.models import load_model

longitud, altura = 100,100
modelo = './modelo/modeloA.h5'
pesos = './modelo/pesosA.h5'
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
        print('Caballo')
    elif respuesta == 1:
        print('Gallina')
    elif respuesta == 2:
        print('Gato') 
    elif respuesta == 3:
        print('Perro')
    elif respuesta == 4:
        print('Vaca')
        

print('Set de pruebas #1')
predict('./prueba/caballo.jpeg')
predict('./prueba/gallina.jpeg')
predict('./prueba/gato.jpeg')
predict('./prueba/perro.jpeg')
predict('./prueba/vaca.jpeg')

print('')
predict('./prueba/gato.jpg')
