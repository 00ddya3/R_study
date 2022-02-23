library(shiny)

#ex1
ui = fluidPage(
  tags$h1("hello shiny!"),
  tags$img(src="https://i.pinimg.com/originals/6b/9f/1a/6b9f1a93faeed9d4a7e4f2832647df9c.jpg")  
)

server = function(input, output, session) {
  #do something here
}

shinyApp(ui=ui, server=server)


#ex2
ui = fluidPage(
  selectInput("dataset",
              label='dataset', 
              choices=ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server = function(input, output, session) {
  output$summary = renderPrint({
    dataset = get(input$dataset, "package:datasets")
    summary(dataset)
  })
  
  output$table = renderTable({
    dataset = get(input$dataset, "package:datasets")
    dataset
  })
}

shinyApp(ui=ui, server=server)


#ex3
ui = fluidPage(
  selectInput("dataset",
              label='dataset', 
              choices=ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server = function(input, output) {
  #create a reactive expression
  dataset = reactive({get(input$dataset, "package:datasets")})
  
  output$summary = renderPrint({
    #use a reactive expression by calling it like a function
    summary(dataset())
  })
  
  output$table = renderTable({
    dataset()
  })
}

shinyApp(ui=ui, server=server)


#ex4
ui = fluidPage(
  plotOutput("plot", click = "plot_click"),
  tableOutput("data")
)
