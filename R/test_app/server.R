library(shiny)
library(ggplot2)

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
  
  selectedBTCvars <- reactive({
    input$btc_vars
  })
  
  selectedCurrVars <- reactive({
    input$finex_vars
  })
  
  selectedCurrVars <- reactive({
    input$finex_vars
  })
  
  currentDateRange <- reactive({
    as.Date(as.character(input$mydateRange))
  })
  
  output$myggplot <- renderPlot (function (){
    cur_dat=scal_dat[ , c('Date',selectedBTCvars(),'USD_Scaled_Price' )]
    #cur_data=subset(cur_data, Date>=currentDateRange()[[1]] && Date<=currentDateRange()[[2]])
    melt_dat=melt(cur_dat, id.vars=c('Date'))
    p <- ggplot(melt_dat,  aes(x=Date, y=value,col=variable)) +geom_point() 
    print(p)
  })
  
  output$myggplot2 <- renderPlot (function (){
    cur_dat=scal_dat[ , c('Date',selectedCurrVars(), 'USD_Scaled_Price')]
    #cur_data=subset(cur_data, Date>=currentDateRange()[[1]] && Date<=currentDateRange()[[2]])
    melt_dat=melt(cur_dat, id.vars=c('Date'))
    p <- ggplot(melt_dat,  aes(x=Date, y=value,col=variable)) +geom_point()
    print(p)
  })
  
})