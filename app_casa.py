#!/usr/bin/env python
# coding: utf-8

# In[1]:


import streamlit as st
import numpy as np 
import pandas as pd
import joblib
import PIL


# In[3]:


st.write("""

# Predecir precio de renta.
### Hecho por Amado de Jesús Vázquez Acuña.


""")


# In[4]:


img=PIL.Image.open('img house.jpg')
st.image(img)


# In[31]:


def input_data():
    

    area_slider=st.slider('Area en metros cuadrados: ',min_value=10.0,max_value=700.0,step=0.1),
    rooms_slider=st.slider('Número de habitaciones',min_value=1,max_value=8,step=1),
    bathroom_slider=st.slider('Número de baños',min_value=1,max_value=8,step=1),
    spaces_slider=st.slider('Espacios de estacionamiento',min_value=1,max_value=8,step=1),
    animal_slider=st.selectbox('Aceptar animales',('Sí','No')),
    furniture_slider=st.selectbox('Casa amuebalda',('Sí','No')),
    fire_insurence_slider=st.slider('Precio seguro contra incendios en dólares',min_value=3,max_value=250,step=1)
    
    features={'Área':area_slider,
              'Habitaciones':rooms_slider,
              'Baños':bathroom_slider,
            'Estacionamientos':spaces_slider,
             'Animales':animal_slider,
              'Muebles':furniture_slider,
             'Seguro contra incendios':fire_insurence_slider}
              


    return pd.DataFrame(features)


# In[33]:


data=input_data()


# In[37]:


data['Área']=np.log(data['Área'])
data['Seguro contra incendios']=np.log(data['Seguro contra incendios'])
data['Animales']=np.where(data['Animales']=='Sí',1,0)
data['Muebles']=np.where(data['Muebles']=='Sí',1,0)


# In[40]:


model=joblib.load('lm_rent_amount.pkl')


# In[42]:


X=data.values


# In[46]:



if st.button('Predecir'):
    
    pred=np.exp(model.predict(X))
    
    st.write(pred)
    

