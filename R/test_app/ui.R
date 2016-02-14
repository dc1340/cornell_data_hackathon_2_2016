library(shiny)

# Define UI for slider demo application
shinyUI(fluidPage(
  
  #  Application title
  titlePanel("Bitcoin Versus Selected Features Over Time"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(

      dateRangeInput("mydateRange", "Date:", "2009-01-03","2016-02-14"),
      checkboxGroupInput('btc_vars', 'Selected Bitcoin Vars', 
      choices=c("Bitcoin-Average-Transaction-Confirmation-Time"="ATRCT",
        "Bitcoin-Average-Block-Size"="AVBLS",
        "Bitcoin-Estimated-Transaction-Volume"="ETRAV",
        "Bitcoin-Number-of-Unique-Bitcoin-Addresses-Used"="NADDU",
        "Bitcoin-Number-of-Transactions"="NTRAN",
        "Bitcoin-Number-of-Transaction-per-Block"="NTRBL",
        "Bitcoin-Number-of-Transactions-Excluding-Popular-Addresses"="NTREP",
        "Bitcoin-Total-Output-Volume"="TOUTV",
        "Bitcoin-Total-Transaction-Fees"="TRFEE"))
    ),
    
    # Show a table summarizing the values entered
    mainPanel(
      plotOutput("myggplot"),
      
    )
  )
))