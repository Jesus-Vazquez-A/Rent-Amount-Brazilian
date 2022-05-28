

library(shiny)
library(dplyr)

                                                  


model<-readRDS("lm_model_houses.rds")
ui <- pageWithSidebar(
    
    # Page header
    headerPanel('Predict rent amount'),
    
    # Input values
    sidebarPanel(
        HTML("<h3>Input parameters</h4>"),
        sliderInput("fire.insurance", label = "Fire insurence", value = 5.0,
                    min = 3,
                    max = 250),
        
        sliderInput("city","City",value=0,min = 0,max=1,step=1),
        
        sliderInput("area", label = "Area", value = 100,
                    min = 10,
                    max = 1000),
    
        sliderInput("rooms", label = "Rooms", value =2,
                    min = 1,
                    max = 7,
                    step=1),
        
        
        sliderInput("bathroom", label = "Bathroom", value =2,
                    min = 1,
                    max = 7,
                    step=1),
        
        sliderInput("parking.spaces", label = "Parking Spaces", value =2,
                    min = 1,
                    max = 8,
                    step=1),
        
        sliderInput("floor", label = "Floor", value =2,
                    min = 1,
                    max = 30,
                    step=1),
        
        selectInput("animal","Animal:",c("acept","not acept")),
        
        selectInput("furniture","Furniture",c("furnished","not furnished")),
        
    
    
        
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

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)

