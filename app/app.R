library(shiny)
library(dplyr)
library(tidymodels)



model<-readRDS("lm_rent_amount.RDS") # load model

ui <- pageWithSidebar(
  
  # Page header
  headerPanel('Predict rent amount in Brazil'),
  
  # Input values
  sidebarPanel(
    HTML("<h3>Input parameters</h4>"),
    
    
    
    selectInput("furniture","Furniture",c("Furnished","Not Furnished")),
    
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
    
    
    sliderInput("bathrooms", label = "Bathrooms", value =2,
                min = 1,
                max = 7,
                step=1),
    
    
    
    
    sliderInput("parking.spaces", label = "Parking Spaces", value =2,
                min = 1,
                max = 5,
                step=1),
    
    sliderInput("quality_departament", label = "Quality Departament", value =2,
                min = 1,
                max = 5,
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
    
    
    furniture<-input$furniture
    area<-input$area
    fire.insurance<-input$fire.insurance
    rooms<-input$rooms
    bathrooms<-input$bathrooms
    parking.spaces<-input$parking.spaces
    quality_departament<-input$quality_departament
    
    
    
    
    newdata<-data.frame(furniture,
                        area,fire.insurance,
                        rooms,bathrooms,
                        parking.spaces,quality_departament)
    
    
    
    
    
    # one hot binary
    
    newdata<- newdata %>% mutate(furniture=ifelse(furniture=="Furnished",1,0))
    
    # logarithmic transform
    
    newdata<- newdata %>% mutate(area=log(area),fire.insurance=log(fire.insurance))
    
    
    
    
    
    
    
    pred<-predict(model,newdata=newdata)
    pred<-exp(pred)
    pred<-round(pred,2)
    
    print(paste("Prediction $ BRL: ",pred)) 
    
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







