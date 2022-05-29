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
