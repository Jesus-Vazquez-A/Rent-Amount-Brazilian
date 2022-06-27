# **Predict rent amount**


### **How much will the rental price cost?**
Using the programming language R. We solve a regression problem, that is, to predict the price of a rental house in Brazil.
Based on the following attributes.

* City: If the department is in a city.

* Animal: If they accept animals.

* Furniture: If the house is furnished.

* Area: The amount in square meters.

* Fire insurence: The price of fire insurance

* Rooms : Number of rooms.

* Bathroom: Number of bathrooms.

* Floor: Number of floors of the apartment building.

* Parking Spaces: Number of parking spaces.


## Project steps

* EDA: It consists of understanding the nature of the data.

* Feature Engineering: Consists of removing or replacing missing values or outliers, as well as creating new attributes in the dataset.

* Selection Model: It consists of finding the best model or the best parameters, which adapt to the set of data.

* Definitive Model: We create the best model with the same parameters.

* App: We create an interactive application using the model, to generate new predictions.

## **Summary**

We load the dataset. We realized that some continuous variables. R recognizes them as an object type, because these variables contain special characters. Therefore we had to remove these characters.

We transform them and coinvert them to values of the numeric type. We found that the dataset contains a significant number of outliers.


In the feature engineering section for values with outliers. We replace these values by those data, which are in a more normal range.

For variables such as area, firm insurance and rent amount. We had to perform a logarithmic transformation of the data. To improve data distribution.


In the data selection part, we decided to use ridge regression, which is a variant of linear regression. We decided to use it because the variables have a strong correlation between the variable to be predicted. In addition, the ridge regression minimizes the weight of the coefficient for those variables that are not so significant, but add value to the prediction quality.

Since if we only use the variables that are not so significant, we may not have such an accurate prediction. This factor is what differentiates us between humans and algorithms. While only humans rely on variables that are important, algorithms use these variables but complement them with other variables where they find patterns that influence prediction.

Before creating the model we had to perform a scale adjustment. With the aim that the variables are comparable to each other.
Using liberia caret we use it to find the best combination of parameters.


As the penultimate step. We recreate the best model and save it as the trained model.

Finally we use the shiny library to create an interactive application for the user. We use the previously trained model, with the purpose of making new predictions. Based on the data entered by the user.

**Note**

We save the project steps in PDF format.

### GIF Proyect ###

<img src="https://media.giphy.com/media/E3nf3yBa7zFOgK2h2I/giphy.gif" width=350>

### Link app

https://rent-amount-brazilian.shinyapps.io/Rent-Amount/
