library(shiny)
library(plotly)

ui <- fluidPage(
#  selectInput("choice", "Choose", choices = names(iris), selected = NULL),
  selectInput("choice", "Choose", choices = names(penguins_clean), selected = NULL),
  plotlyOutput("graph")
)

server <- function(input, output, session){
  
  output$graph <- renderPlotly({
#    plot_ly(penguins_clean, x = ~get(input$choice), y = ~bill_length_mm, type = 'scatter', mode = 'markers', color = ~species)
    #this works: 2D interactive image
    
#    plot_ly(penguins_clean, x = ~get(input$choice), y = ~bill_length_mm, z = ~bill_depth_mm, color = ~species, size = 1)
# geht,jetzt aber mit annotation

    plot_ly(penguins_clean, 
            x = ~get(input$choice), 
            y = ~bill_length_mm, 
            z = ~bill_depth_mm, 
            color = ~species, 
            size = 1, 
#            type="scatter3d") %>%
            type="scatter3d") %>%
            add_trace(mode = 'lines') %>%

      
      
              layout(scene = list(xaxis = list(title = 'bill length (mm)'),
                                      yaxis = list(title = 'bill depth (mm)'),
                                      zaxis = list(title = 'flipper lenth (mm)')),
                         title = "Penguins!")
    
    
#programm meckert wg plot_ly: daher automatisch scatter3d    
    
      })
}

shinyApp(ui, server)


#to do: initial value shiny input use bill length/depth
