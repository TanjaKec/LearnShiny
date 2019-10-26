# install.packages("shiny")

# install.packages("shiny", repos = "http://cran.us.r-project.org")


library(shiny)



# Define UI for application that draws a histogram
ui <- fluidPage(
  headerPanel("Hello!"),
  
  sidebarPanel(selectInput("Vector", "Select Mean of Distribution", 
                           c(0, 1, 2, 3, 4, 5), selected = 0, multiple = FALSE),
               numericInput("n", "n", 50),
               actionButton("go", "Go")),
  
  mainPanel(plotOutput("main_plot"),
            verbatimTextOutput("stats"))
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  randomVals <- eventReactive(input$go, input$n)
  
  v <- function() {
    return(rnorm(randomVals(),mean=as.numeric(input$Vector)))  
  }
  
  output$main_plot <- renderPlot( 
    hist(v(), breaks=15, xlab="",
         main="Histogram of samples size n"))
  
  output$stats <- renderPrint({summary(v())})
}

# Run the application 
shinyApp(ui = ui, server = server)
