library(shiny)
library(plotly)

ui <- fluidPage(
  selectInput("choice", "Choose", choices = names(penguins_clean), selected = NULL),
  plotlyOutput("graph")
)

server <- function(input, output, session){
  
  output$graph <- renderPlotly({

    plot_ly(penguins_clean, 
            x = ~get(input$choice), 
            y = ~bill_length_mm, 
            z = ~bill_depth_mm, 
            color = ~species, 
            size = 1, 
            type="scatter3d",
            mode = "markers") %>%

            layout(scene = list(xaxis = list(title = 'bill length (mm)'),
                                    yaxis = list(title = 'bill depth (mm)'),
                                    zaxis = list(title = 'flipper lenth (mm)')),
                           title = "Penguins!")
    
      })
}

shinyApp(ui, server)


#to do: initial value shiny input use bill length/depth
