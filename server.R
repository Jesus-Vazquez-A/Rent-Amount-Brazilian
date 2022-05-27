
library(data.table)
library(tidymodels)

model<-readRDS("lm_model_houses.rds")

shinyServer(function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    fire.insurance<-input$fire.insurance
    city<-input$city
    area<-input$area
    rooms<-input$rooms
    bathroom<-input$bathroom
    parking.spaces<-input$parking.spaces
    floor<-input$floor
    animal<-input$animal
    furniture<-input$furniture
    
    new_data<-data.frame(fire.insurance,
                         city,area,rooms,
                         bathroom,parking.spaces,
                         floor,animal,furniture)
    
    
    scaler<-function(x,x_){
      
      return((x-mean(x_))/sd(x_))
    }
    
    
    new_data<-new_data %>%
      
      mutate(rooms=as.numeric(scaler(rooms,df$rooms)),
             
             bathroom=as.numeric(scaler(bathroom,df$bathroom)),
             parking.spaces=as.numeric(scaler(parking.spaces,df$parking.spaces)),
             floor=as.numeric(scaler(floor,df$floor)))
    
    new_data<- new_data %>%
      mutate(fire.insurance=log(fire.insurance),
             area=log(area),
             animal=ifelse(animal=="yes",1,0),
             furniture=ifelse(furniture=="furnished",1,0))
    
    Output<-predict(model,new_data = new_data)
    Output<-exp(Output)
    
    print(Output)
    
    
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


