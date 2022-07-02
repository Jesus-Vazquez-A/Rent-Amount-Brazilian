# **Predict rent amount**




![casa-y-para-el-dibujo-y-la-foto-de-la-muestra-de-la-venta-en-blanco-50582607](https://user-images.githubusercontent.com/85312561/177014534-ae7bb450-343f-409b-8d8a-5d6ba14186ce.jpg)


### **How much will the rental price cost?**
Using the programming language R. We solve a regression problem, that is, to predict the price of a rental house in Brazil.
Based on the following attributes.

## Definition of problem.

All the variables that refer to a certain price are in the Brazilian peso unit.

* City: If the department is in a city.

* Animal: If they accept animals.

* Furniture: If the house is furnished.

* Area: The amount in square meters.

* Fire insurence: The price of fire insurance

* Rooms : Number of rooms.

* Bathroom: Number of bathrooms.

* Floor: Number of floors of the apartment building.

* Parking Spaces: Number of parking spaces.

* Rent Amount: Rental Price

### **Scatter Plots**


![scatter_plots](https://user-images.githubusercontent.com/85312561/177007535-63d0c903-b94b-4abd-b7c3-fcd6869cf9b2.png)


All the variables positively affect the price of the rental house, something that makes a lot of sense.

Especially the variable of fire protection, increases proportionally to the price of the rent. That is, it maintains a linear trend relationship.

The variable area is not seen to have a strong relationship, because it contains many values that are out of the established.


### **Rent Amount**

![rent_amount](https://user-images.githubusercontent.com/85312561/177007284-b334465d-f385-4054-a132-fd29fe97703d.png)




#### **Fire Insurence**


![fire_insurence](https://user-images.githubusercontent.com/85312561/177007288-fa32b274-0846-458a-975c-ad3b85e1e728.png)


### **Area**


![area](https://user-images.githubusercontent.com/85312561/177007292-30f0b135-a411-44bc-a7a9-165f70129ab7.png)


We note that the continuous variables have an important presence of atypical values, that is, values that are out of the normal.



### **Conclusion**


The main challenge will be to find a method that is effective in transforming these values. Since we cannot eliminate them since we risk the loss of useful information,there is especially a high risk for the variable area, which affects the distribution of the data.





# **Proyect Summary**

## **Aprobach**


### **Treatment of outliers**

![rent_log](https://user-images.githubusercontent.com/85312561/177007896-4c2aa0fe-2a40-4b85-b831-9fb24e7ae00b.png)


![fire_log](https://user-images.githubusercontent.com/85312561/177007902-bebbf716-f954-4ba0-8c2b-9584b808123e.png)


![area_log](https://user-images.githubusercontent.com/85312561/177007908-81b1741c-146f-4e55-8dac-3e307d60efc4.png)


We compute several possible confidence intervals. Through these calculations, we identify which values are out of the established. We replace these values with a random sample of values close to the upper interval.

Subsequently, we performed a logarithmic transformation, to improve the distribution of the data.Unlike the previous Python project where our definitive algorithm was an XGBoost, in this case we have to preprocess the data.


## **Model Interpration**


We decided to apply an L1 penalty method which is another variant of linear regression. With the difference of minimizing the weight of the coefficient for those variables that do add value, but not as much as if we compare it with other variables.

This method is used when we know that all the variables are going to serve us and are correlated.


Through a cross-validation technique that serves to see the average generalization of the model. To find the best set of parameters for our data.

* **alpha:** The closer the value is to 1, the greater the L1 penelazation effect.


### **Cross Validation**


![cv](https://user-images.githubusercontent.com/85312561/177008327-c49f35b2-e788-452c-a821-84f7540f4c71.png)


### **Opening the black box..**


![coeficients](https://user-images.githubusercontent.com/85312561/177014276-c6e9b2c3-8325-479c-a63f-0689093408d8.png)


### **Model Visualization**


![model](https://user-images.githubusercontent.com/85312561/177014385-8e206ddd-081c-412d-806a-bf3bcea121c9.png)



## **Conclusion**

The linear model in its L1 variant perfectly solves the problem. It adapts very well to the unknown data set, it is easy to interpret. Instead of using other more complex algorithms like artificial neural networks or support vector machines.


### GIF Proyect ###

<img src="https://media.giphy.com/media/E3nf3yBa7zFOgK2h2I/giphy.gif" width=350>

### Link app

https://rent-amount-brazilian.shinyapps.io/Rent-Amount/
