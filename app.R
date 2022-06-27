

library(shiny)
library(dplyr)
library(glmnet)
library(curl)


dir_mkdir<-"C:\\Users\\PC\\Desktop\\Ciencias de datos\\Proyectos\\Casa de renta\\"
setwd(dir_mkdir)



url_data<-"https://raw.githubusercontent.com/Jesus-Vazquez-A/Casa-de-Renta/master/rent-amount-clear.csv"
url_data<-url(url_data)

old_data<-read.csv(url_data) # load old data


model<-readRDS("lm_ridge_rent.RDS") # load model

ui <- pageWithSidebar(
  
  # Page header
  headerPanel('Predict rent amount in Brazil'),
  
  # Input values
  sidebarPanel(
    HTML("<h3>Input parameters</h4>"),
    
    selectInput("city","City",c("Yes","No")),
    
    selectInput("animal","Animal:",c("acept","not acept")),
    
    selectInput("furniture","Furniture",c("furnished","not furnished")),
    
    sliderInput("area", label = "Area", value = 100,
                min = 10,
                max = 1000),
    
    sliderInput("fire.insurance", label = "Fire insurence", value = 5.0,
                min = 3,
                max = 250),
    
    
    
    
    
    sliderInput("rooms", label = "Rooms", value =2,
                min = 1,
                max = 7,
                step=1),
    
    
    sliderInput("bathroom", label = "Bathroom", value =2,
                min = 1,
                max = 7,
                step=1),
    
    
    sliderInput("floor", label = "Floor", value =2,
                min = 0,
                max = 30,
                step=1),
    
    
    sliderInput("parking.spaces", label = "Parking Spaces", value =2,
                min = 1,
                max = 8,
                step=1),
    
    
    
    
    actionButton("submitbutton", "Submit", class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table
    
  )
)

####################################
# Server                           #
####################################

server<- function(input, output, session) {
  
  
  
  # Input Data
  
  datasetInput <- reactive({  
    
    city<-input$city
    animal<-input$animal
    furniture<-input$furniture
    area<-input$area
    fire.insurance<-input$fire.insurance
    rooms<-input$rooms
    bathroom<-input$bathroom
    floor<-input$floor
    parking.spaces<-input$parking.spaces
    
    
    
    
    new_data<-data.frame(city,animal,furniture,
                         area,fire.insurance,
                         rooms,bathroom,
                         floor,parking.spaces)
    
    scaled_data<- function(old_data,new_data){
      
      
      mean_<-mean(old_data)
      std<-sd(old_data)
      
      scaled<-(new_data-mean_)/std
      return(scaled)
      
    }
    
    rooms_sc<-scaled_data(old_data$rooms,rooms)
    bathroom_sc<-scaled_data(old_data$bathrooms,bathroom)
    floor_sc<-scaled_data(old_data$floor,floor)
    parkin_spaces_sc<-scaled_data(old_data$parking.spaces,parking.spaces)
    
    # scale data
    
    new_data<-new_data %>%
      
      mutate(rooms=rooms_sc) %>%
      mutate(bathroom=bathroom_sc) %>%
      mutate(floor=floor_sc) %>%
      mutate(parking.spaces=parkin_spaces_sc)
    
    
    
    ohe_binary<-function(data,category_class){
      ifelse(data==category_class,1,0)
    }
    
    animal_ohe<-ohe_binary(animal,"acept")
    city_ohe<-ohe_binary(city,"yes")
    furniture_ohe<-ohe_binary(furniture,"furnished")
    
    
    # one hot binary
    
    new_data<- new_data %>%
      
      mutate(animal=animal_ohe) %>%
      mutate(city=city_ohe) %>%
      mutate(furniture=furniture_ohe) 
    
    
    # logarithmic transform
    
    new_data<- new_data %>%
      
      mutate(area=log(area),
             fire.insurance=log(fire.insurance))
    
    
    # transform data to matrix
    
    new_data<- new_data %>% as.matrix()
    
    
    pred<-predict(model,newx=new_data)
    pred<-exp(pred)
    pred<-round(pred,2)
    
    print(paste("Prediction: ",pred)) 
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)



