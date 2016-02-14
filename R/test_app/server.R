library(shiny)

# Define server logic for slider examples
shinyServer(function(input, output) {
  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    # Compose data frame
    data.frame(
      Name = c("Time"),
      Value = as.character(c(input$date)), 
      stringsAsFactors=FALSE)
  }) 
  

  
  output$myggplot <- renderPlot (function (){
    cur_dat=scal_dat[ , c(input$agg_vars,'USD_Scaled_Price' )]
    melt_dat=melt(cur_dat, id.vars=c('Date'))
    p <- ggplot(melt_dat,  aes(x=Date, y=value,col=variable)) + geom_point()
    
    print(p)
  })
  
  
  
})