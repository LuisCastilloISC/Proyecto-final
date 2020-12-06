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
    if respuesta == 1:
        print('Ardilla')
    elif respuesta == 2:
        print('Caballo')
    elif respuesta == 3:
        print('Elefante')
    elif respuesta == 4:
        print('Gallina')
    elif respuesta == 5:
        print('Gato') 
    elif respuesta == 6:
        print('Mariposa')
    elif respuesta == 7:
        print('Oveja')
    elif respuesta == 8:
        print('Perro')
    elif respuesta == 9:
        print('Vaca')

print('Set de pruebas #1')
predict('./pruebas/ardilla.jpeg')       # 2.- Ardilla
predict('./pruebas/caballo.jpeg')       # 3.- Caballo
predict('./pruebas/elefante.jpg')       # 4.- Elefante
predict('./pruebas/gallina.jpeg')       # 5.- Gallina
predict('./pruebas/gato.jpeg')          # 6.- Gato
predict('./pruebas/mariposa.png')       # 7.- Mariposa
predict('./pruebas/oveja.jpg')          # 8.- Oveja
predict('./pruebas/perro.jpeg')         # 9.- Perro
predict('./pruebas/vaca.jpeg')          # 10.- Vaca

print('')

print('Set de pruebas #2')
predict('./pruebas2/ardilla.jpeg')       # 2.- Ardilla
predict('./pruebas2/caballo.jpeg')       # 3.- Caballo
predict('./pruebas2/elefante.jpeg')      # 4.- Elefante
predict('./pruebas2/gallina.jpeg')       # 5.- Gallina
predict('./pruebas2/gato.jpeg')          # 6.- Gato
predict('./pruebas2/mariposa.jpg')       # 7.- Mariposa
predict('./pruebas2/oveja.jpg')          # 8.- Oveja
predict('./pruebas2/perro.jpeg')         # 9.- Perro
predict('./pruebas2/vaca.jpeg')          # 10.- Vaca